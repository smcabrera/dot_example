require_relative './hook'

class PreCommitHook < Hook
  FILEPATH = File.join(".git", "hooks", "pre-commit")

  def initialize(dot_env_dot_example = nil)
    @dot_env_dot_example = dot_env_dot_example || DotEnvDotExample.new
  end

  attr_reader :dot_env_dot_example

  def self.find_or_create
    unless Dir.glob(FILEPATH).any?
      %x[ touch #{FILEPATH} ]
      %x[ chmod +x #{FILEPATH} ]
      self.print_new_pre_commit_hook_message
    end
    new
  end

  def self.print_new_pre_commit_hook_message
    puts "*" * 60 
    puts "New pre-commit hook created"
    puts "*" * 60 
  end

  def write!
    unless contains_dot_example_steps? 
      File.open(FILEPATH, "a") do |file|
        file.puts dot_env_dot_example.pre_commit_hook
      end
    end
  end

  def print_new_steps_message
    puts "*" * 60 
    puts "New steps added to pre-commit hook"
    puts dot_env_dot_example.pre_commit_hook
    puts "*" * 60 
  end

  def contents
    File.read(FILEPATH)
  end

  def contains_dot_example_steps?
    contents.include?(dot_env_dot_example.pre_commit_hook)
  end
end
