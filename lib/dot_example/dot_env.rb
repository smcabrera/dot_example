class DotEnv
  def initialize(filename = nil, lines = nil)
    @filename = filename || ".env"
    @lines = lines || File.readlines(@filename)
    create_file_if_does_not_exist
  end

  attr_reader :filename, :lines

  def key_lines
    keys.map { |key| key + "=" }.join("\n")
  end

  def keys
    lines.map do |line|
      line.split("=")[0]
    end
  end

  def create_file_if_does_not_exist
    unless Dir.glob(filename).any?
      create_file
    end
  end

  def create_file
    %x[ touch #{filename} ]
    puts Paint[".env created", :green]
    # TODO: Add to .gitignore if it's not there already.
  end
end
