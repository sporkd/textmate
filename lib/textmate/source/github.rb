require 'octopi'

class Textmate::Source::Github < Textmate::Source::Base

  name 'Github'

  def bundles(search = '')
    github_search(search).map do |repository|
      normalize_github_repo_name(repository.name).split('.').first
    end.uniq.sort
  end

  def install(bundle)
    repositories = github_search(bundle).sort_by { |r| r.followers }.reverse

    case repositories.length
      when 0 then abort("Can't find Github bundle to install: #{bundle}")
      when 1 then install_bundle_from_github(repositories.first, bundle)
      else        install_bundle_from_github(select_repository(repositories), bundle)
    end
  end

private ######################################################################

  CAPITALIZATION_EXCEPTIONS = %w[tmbundle on]

  def github_search(bundle)
    # GitHub API bug: we have to use '%20' instead of '+' for string concatenation
    search_string = "(#{bundle}_ AND ((tmbundle) OR (textmate bundle) OR (tm bundle)))".gsub(/ /, "%20")
    Octopi::Repository.find_all(search_string)
  end

  def normalize_github_repo_name(name)
    name = name.gsub("-", " ").split.each{|part| part.capitalize! unless CAPITALIZATION_EXCEPTIONS.include? part}.join(" ")
    name = name.gsub(/_*(tm.*bundles*|textmate.*bundles*|textmate)/i, "")
  end

  def select_repository(repositories)
    puts "Please select a repository from the following list: (CTRL-C to exit)"
    puts
    repository_index = {}
    repositories.inject(0) do |index, repository|
      repository_index[index += 1] = repository
      puts "%d. %-50s watchers:%-3d updated:%s" % [
        index,
        "#{repository.username}/#{repository.name}",
        repository.followers,
        repository.pushed.split('T').first
      ]
      index
    end

    puts
    index = Thor.new.ask('Which repository would you like to install?').to_i
    puts
    abort("Unknown option: #{index}") unless repository_index[index]

    repository_index[index]
  end

  def install_bundle_from_github(repository, bundle)
    around_install(bundle) do
      %x{ git clone --depth 1 "#{git_clone_url(repository)}" "#{local_path_for(bundle)}" }
    end
  end

  def git_clone_url(repository)
    "git://github.com/#{repository.username}/#{repository.name}.git"
  end

end

Textmate::Remote.register_source Textmate::Source::Github
