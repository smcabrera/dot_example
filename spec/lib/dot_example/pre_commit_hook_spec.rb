require "spec_helper"

describe PreCommitHook do
  describe '#write!' do
    after do
      %x[ rm #{PreCommitHook.new.filepath}  ]
    end

    context 'pre commit hook already exists and contains the steps from dot_example' do
      before do
        dot_env_dot_example = DotEnvDotExample.new
        pre_commit_hook = PreCommitHook.new
        File.open(pre_commit_hook.filepath, "w") do |file|
          file.puts "Existing pre commit hook\n#{dot_env_dot_example.pre_commit_hook}"
        end
      end

      it 'does not write to the file' do
        pre_commit_hook = PreCommitHook.new
        pre_commit_hook.write!

        expect(File).not_to receive(:open)
      end

      it 'file continues to have the existing pre commit hook and the dot_example pre commit hook' do 
        pre_commit_hook = PreCommitHook.new
        dot_env_dot_example = pre_commit_hook.dot_env_dot_example
        pre_commit_hook.write!

        expect(File.read(pre_commit_hook.filepath)).to include(dot_env_dot_example.pre_commit_hook)
        expect(File.read(pre_commit_hook.filepath)).to include("Existing pre commit hook")
      end
    end

    context 'there is no existing pre commit hook' do
      it 'creates a pre commit hook and adds the steps from dot_example to it' do
        pre_commit_hook = PreCommitHook.new
        dot_env_dot_example = pre_commit_hook.dot_env_dot_example
        pre_commit_hook.write!

        expect(File.read(pre_commit_hook.filepath)).to include(dot_env_dot_example.pre_commit_hook)
      end
    end

    context 'pre commit hook already exists but does not contain steps from dot_example' do
      before do
         pre_commit_hook = PreCommitHook.new
        File.open(pre_commit_hook.filepath, "w") do |file|
          file.puts "Existing pre commit hook"
        end
      end

      it 'appends the steps from dot_example to the pre commit hook without overwriting existing hook' do
        pre_commit_hook = PreCommitHook.new
        pre_commit_hook.write!

        expect(File.read(pre_commit_hook.filepath)).to include(pre_commit_hook.steps)
        expect(File.read(pre_commit_hook.filepath)).to include("Existing pre commit hook")
      end
    end
  end
end
