class A
  def call(directory, skip_hidden = true)
    Dir.new(directory).each do |file|
      next if %w(. ..).include?(file)
      next if skip_hidden && file.start_with?('.')

      file_name = File.join(directory, file)

      if File.directory?(file_name)
        call(file_name)
      else
        puts File.read(file_name)
      end
    end
  end
end

A.new.call('.')
