class PostCheckoutHook < Hook
  FILEPATH = File.join(".git", "hooks", "post-checkout")

  def initialize(dot_env_dot_example = nil)
    @dot_env_dot_example = dot_env_dot_example || DotEnvDotExample.new
    @name = "post-checkout"
  end

  attr_reader :dot_env_dot_example, :name

  def self.find_or_create
    unless Dir.glob(FILEPATH).any?
      %x[ touch #{FILEPATH} ]
      %x[ chmod +x #{FILEPATH} ]
      self.print_new_hook_message
    end
    new
  end

  def write!
    unless contains_steps? 
      File.open(FILEPATH, "a") do |file|
        file.puts steps
      end
    print_new_steps_message
    end
  end

  def self.print_new_hook_message
    puts "*" * 60 
    puts "New #{name} hook created"
    puts "*" * 60 
  end

  def print_new_steps_message
    puts "*" * 60 
    puts "New steps added to #{name} hook"
    puts steps
    puts "*" * 60 
  end

  def contains_steps?
    contents.include?(steps)
  end

  def contents
    File.read(FILEPATH)
  end

  def steps
    "dot_example check"
  end
end
