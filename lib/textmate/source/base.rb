class Textmate::Source::Base

  def self.name(name = nil)
    @name = name if name
    @name
  end

  def name
    self.class.name
  end

  def <=>(other)
    name <=> other.name
  end

  def clear_existing(bundle)
    FileUtils.rm_rf(local_path_for(bundle))
  end

  def local_path_for(bundle)
    File.join(Textmate::Local.bundle_install_path, "#{bundle}.tmbundle")
  end

  def around_install(bundle, &block)
    clear_existing(bundle)
    yield
    puts "#{bundle} bundle installed"
    puts
  end

end
