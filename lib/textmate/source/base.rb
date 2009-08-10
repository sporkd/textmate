class Textmate::Source::Base

  def self.name(name = nil)
    @name = name if name
    @name
  end

  def name
    self.class.name
  end

end
