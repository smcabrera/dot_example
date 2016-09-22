class PreCommitHook < Hook
  def initialize(dot_env_dot_example = nil)
    @dot_env_dot_example = dot_env_dot_example || DotEnvDotExample.new
    @type = "pre-commit"
    create_file_if_does_not_exist
  end

  attr_reader :dot_env_dot_example, :type

  # TODO: Make it possible to put .env and .env.example files somewhere else?
  # Maybe later if people actually want this feature
  def steps
    [
      "dot_example sync",
      "git add .env.example"
    ].join("\n")
  end
end
