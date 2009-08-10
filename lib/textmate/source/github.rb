require 'octopi'

class Textmate::Source::Github < Textmate::Source::Base

  name 'Github'

  def bundles(search = '')
    Octopi::Repository.find_all(search, 'tmbundle').map do |repository|
      normalize_github_repo_name(repository.name).split('.').first
    end.uniq.sort
  end

private ######################################################################

  CAPITALIZATION_EXCEPTIONS = %w[tmbundle on]
  # Convert a GitHub repo name into a "normal" TM bundle name
  # e.g. ruby-on-rails-tmbundle => Ruby on Rails.tmbundle
  def normalize_github_repo_name(name)
    name = name.gsub("-", " ").split.each{|part| part.capitalize! unless CAPITALIZATION_EXCEPTIONS.include? part}.join(" ")
    name[-9] = ?. if name =~ / tmbundle$/
    name
  end

  # Does the opposite of normalize_github_repo_name
  def denormalize_github_repo_name(name)
    name += " tmbundle" unless name =~ / tmbundle$/
    name.split(' ').each{|part| part.downcase!}.join(' ').gsub(' ', '-')
  end

end

Textmate::Remote.register_source Textmate::Source::Github