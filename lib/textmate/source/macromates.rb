class Textmate::Source::Macromates < Textmate::Source::Base

  name 'Macromates'

  def bundles(search = '')
    repositories.map do |repository|
      repository_bundles(repository, search)
    end.flatten.uniq.sort
  end

  def install(bundle)
    repository = repositories.detect do |repository|
      repository_bundles(repository, bundle, :exact)
    end
    install_bundle_from_svn("#{repository}/#{bundle}.tmbundle", bundle)
  end

private ######################################################################

  def repositories
    repositories  = []
    repositories << 'http://svn.textmate.org/trunk/Bundles/'
    repositories << 'http://svn.textmate.org/trunk/Review/Bundles/'
  end

  def repository_bundles(repository, search = '', match = :partial)
    search_term = Regexp.new(".*#{search}.*", 'i')

    %x{ svn list #{repository} }.split.map do |bundle|
      bundle.split('.').first
    end.select do |bundle|
      match == :partial ? bundle =~ search_term : bundle == search
    end
  end

  def install_bundle_from_svn(svn_path, bundle)
    around_install(bundle) do
      %x{ svn co "#{svn_path}" "#{local_path_for(bundle)}" }
      puts "#{bundle} installed"
    end
  end

end

Textmate::Remote.register_source Textmate::Source::Macromates
