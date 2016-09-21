class DotEnv
  def initialize(filename = nil)
    @filename = filename || ".env"
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

  private

  def lines
    File.readlines(filename)
  end
end
