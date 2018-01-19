module PathHelpers
  def spec_root
    File.expand_path(File.join(__FILE__, '..'))
  end

  def example_root
    File.expand_path(File.join(spec_root, '..', 'examples'))
  end
end
