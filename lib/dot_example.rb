require 'paint'
require_relative "dot_example/version"
require_relative "dot_example/dot_env"
require_relative "dot_example/dot_env_dot_example"
require_relative "dot_example/hook"
require_relative "dot_example/pre_commit_hook"
require_relative "dot_example/post_checkout_hook"

module DotExample
  def self.add_pre_commit_hook(dot_env_dot_example)
    pre_commit_hook = PreCommitHook.new
    pre_commit_hook.write!
  end

  def self.add_post_checkout_hook
    post_checkout_hook = PostCheckoutHook.new
    post_checkout_hook.write!
  end
end
