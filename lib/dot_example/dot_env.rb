class DotEnv
  def initialize(filename = nil)
    @filename = filename || ".env"
    create_file_if_does_not_exist
  end

  attr_reader :filename

  def key_lines
    keys.map { |key| key + "=" }.join("\n")
  end
  
  def lint!
    unless line.match(/^[^=\s]*=[^=\s]*$/)
      # TODO: Don't know if this is the best error message
        raise "Invalid Environment variable defintion"
    end
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

  private

  def lines
    File.readlines(filename)
  end
end
