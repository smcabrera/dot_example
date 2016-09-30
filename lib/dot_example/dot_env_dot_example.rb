class DotEnvDotExample
  def initialize( options = {} )
    @filename = options[:filename] || ".env.example"
    @dot_env = options[:dot_env] || DotEnv.new
  end

  attr_reader :filename, :dot_env

  def write!
    if keys_new_to_example.any?
      print_new_keys_message
      File.open(filename, "a") do |file|
        file.puts keys_new_to_example.map { |key| "#{key}=" }
      end
    end
  end

  def keys_new_to_example
    dot_env.keys.reject do |key|
      keys.map(&:chomp).include? key
    end
  end

  def print_new_keys_message
    puts Paint[
      "New variables added to #{filename}",
      :green
    ]
    puts keys_new_to_example
  end

  def missing_keys
    keys.reject { |key| dot_env.keys.include?(key) }
  end

  def print_missing_keys_message
    if missing_keys.any?
      puts Paint[
        "missing ENV variables from #{dot_env.filename}",
        :green
      ]
      puts missing_keys
    end
  end

  def pre_commit_hook
    # TODO: Make it possible to put .env and .env.example files somewhere else?
    # Maybe later if people actually want this feature
    [
      "dot_example sync",
      "git add .env.example"
    ].join("\n")
  end

  private

  def keys
    lines.map{ |line| line.split("=")[0] }
  end

  def lines
    unless Dir.glob(filename).any?
      `touch #{filename}`
    end
    File.readlines(filename)
  end
end
