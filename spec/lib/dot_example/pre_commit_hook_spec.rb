require "spec_helper"

describe PreCommitHook do
  describe '.find_or_create' do
    # TODO: Figure out how best to test this
    # there's a lot of calls to the file system--stub them out?
    # create real files and then blow everything up afterward?
    # What is best? Maybe do some reading about this
  end

  describe '#write!' do
    after do
      %x[ rm #{PreCommitHook::FILEPATH}  ]
    end

    context 'pre commit hook already exists and contains the steps from dot_example' do
      before do
        %x[ touch #{PreCommitHook::FILEPATH}  ]
        dot_env_dot_example = DotEnvDotExample.new
        File.open(PreCommitHook::FILEPATH, "w") do |file|
          file.puts "Existing pre commit hook\n#{dot_env_dot_example.pre_commit_hook}"
        end
      end

      it 'does not write to the file' do
        pre_commit_hook = PreCommitHook.find_or_create
        pre_commit_hook.write!

        expect(File).not_to receive(:open)
      end

      it 'file continues to have the existing pre commit hook and the dot_example pre commit hook' do 
        pre_commit_hook = PreCommitHook.find_or_create
        dot_env_dot_example = pre_commit_hook.dot_env_dot_example
        pre_commit_hook.write!

        expect(File.read(PreCommitHook::FILEPATH)).to include(dot_env_dot_example.pre_commit_hook)
        expect(File.read(PreCommitHook::FILEPATH)).to include("Existing pre commit hook")
      end
    end

    context 'there is no existing pre commit hook' do
      it 'creates a pre commit hook and adds the steps from dot_example to it' do
        pre_commit_hook = PreCommitHook.find_or_create
        dot_env_dot_example = pre_commit_hook.dot_env_dot_example
        pre_commit_hook.write!

        expect(File.read(PreCommitHook::FILEPATH)).to include(dot_env_dot_example.pre_commit_hook)
      end
    end

    context 'pre commit hook already exists but does not contain steps from dot_example' do
      before do
        %x[ touch #{PreCommitHook::FILEPATH}  ]
        File.open(PreCommitHook::FILEPATH, "w") do |file|
          file.puts "Existing pre commit hook"
        end
      end

      it 'appends the steps from dot_example to the pre commit hook without overwriting existing hook' do
        pre_commit_hook = PreCommitHook.find_or_create
        dot_env_dot_example = pre_commit_hook.dot_env_dot_example
        pre_commit_hook.write!

        expect(File.read(PreCommitHook::FILEPATH)).to include(dot_env_dot_example.pre_commit_hook)
        expect(File.read(PreCommitHook::FILEPATH)).to include("Existing pre commit hook")
      end
    end
  end
end
