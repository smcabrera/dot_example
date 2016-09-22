require "spec_helper"

describe PostCheckoutHook do
  describe '#write!' do
    after do
      %x[ rm #{PostCheckoutHook.new.filepath}  ]
    end

    context 'post-checkout hook already exists and contains the steps from dot_example' do
      before do
        post_checkout_hook = PostCheckoutHook.new
        File.open(post_checkout_hook.filepath, "w") do |file|
          file.puts "Existing post-checkout hook\n#{post_checkout_hook.steps}"
        end
      end

      it 'does not write to the file' do
        post_checkout_hook = PostCheckoutHook.new
        post_checkout_hook.write!

        expect(File).not_to receive(:open)
      end

      it 'file continues to have the existing post-checkout hook and the dot_example post-checkout hook' do 
        post_checkout_hook = PostCheckoutHook.new
        post_checkout_hook.write!

        expect(File.read(post_checkout_hook.filepath)).to include(post_checkout_hook.steps)
        expect(File.read(post_checkout_hook.filepath)).to include("Existing post-checkout hook")
      end
    end

    context 'there is no existing post-checkout hook' do
      it 'creates a post-checkout hook and adds the steps from dot_example to it' do
        post_checkout_hook = PostCheckoutHook.new
        post_checkout_hook.write!

        expect(File.read(post_checkout_hook.filepath)).to include(post_checkout_hook.steps)
      end
    end

    context 'post-checkout hook already exists but does not contain steps from dot_example' do
      before do
        post_checkout_hook = PostCheckoutHook.new
        File.open(post_checkout_hook.filepath, "w") do |file|
          file.puts "Existing post-checkout hook"
        end
      end

      it 'appends the steps from dot_example to the post-checkout hook without overwriting existing hook' do
        post_checkout_hook = PostCheckoutHook.new
        post_checkout_hook.write!

        expect(File.read(post_checkout_hook.filepath)).to include(post_checkout_hook.steps)
        expect(File.read(post_checkout_hook.filepath)).to include("Existing post-checkout hook")
      end
    end
  end
end
