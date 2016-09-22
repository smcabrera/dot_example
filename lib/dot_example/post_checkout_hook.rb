class PostCheckoutHook < Hook
  def initialize(dot_env_dot_example = nil)
    @dot_env_dot_example = dot_env_dot_example || DotEnvDotExample.new
    @type = "post-checkout"
    create_file_if_does_not_exist
  end

  attr_reader :dot_env_dot_example, :type

  def steps
    "dot_example check"
  end
end
