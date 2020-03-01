class RecursiveFilesList
  include Enumerable

  def initialize(directory, skip_hidden: true)
    @files_list = read_dir(directory, [], skip_hidden: skip_hidden)
  end

  def each
    @files_list.each { |x| yield x }
  end

  private

  def read_dir(directory, accumulator, skip_hidden:)
    Dir.new(directory).each do |file|
      next if %w(. ..).include?(file)
      next if skip_hidden && file.start_with?('.')

      file_name = File.join(directory, file)

      if File.directory?(file_name)
        read_dir(file_name, accumulator, skip_hidden: skip_hidden)
      else
        accumulator << file_name
      end
    end
    accumulator
  end
end

# EXAMPLE:
# Having a directory tree looking like this:
# .
# ├── foo
# │   ├── bar
# │   │   └── two
# │   ├── baz
# │   │   └── .three
# │   └── one
# └── recursive_files_list.rb

# pp RecursiveFilesList.new('foo', skip_hidden: false).map { |x| "__#{x}" }
# ["__foo/one", "__foo/baz/.three", "__foo/bar/two"]
