class Textmate::Remote

  def self.register_source(klass)
    sources << klass.new
  end

  def self.sources
    @sources ||= []
  end

  def sources
    self.class.sources
  end

  def bundles(search = '')
    sources.inject({}) do |hash, source|
      hash.update(source.name => source.bundles(search))
    end
  end

end
