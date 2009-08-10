class Textmate::Source::Macromates < Textmate::Source::Base

  name 'Macromates'

  def bundles(search = '')
    repositories.map do |repository|
      repository_bundles(repository, search)
    end.flatten.uniq.sort
  end

private ######################################################################

  def repositories
    repositories  = []
    repositories << 'http://svn.textmate.org/trunk/Bundles/'
    repositories << 'http://svn.textmate.org/trunk/Review/Bundles/'
  end

  def repository_bundles(repository, search = '')
    search_term = Regexp.new(".*#{search}.*", 'i')

    %x{ svn list #{repository} }.map do |bundle|
      bundle.split('.').first
    end.select do |bundle|
      bundle =~ search_term
    end
  end

end

Textmate::Remote.register_source Textmate::Source::Macromates