require 'spec_helper'

describe DotEnvDotExample do
    before { `touch .env.example` } 
    after { `rm .env.example` }

  describe 'write!' do
    it 'writes the key_lines from the .env file to filename' do
      dot_env = DotEnv.new("spec/support/.env")
      dot_env_dot_example = DotEnvDotExample.new(
        filename: "spec/support/.env.example",
        dot_env: dot_env
      )
      dot_env_dot_example.write!

      expect(
        File.read(dot_env_dot_example.filename)
      ).to eq "SOME_API_KEY=\nSOME_API_SECRET=\n"
    end
  end

  describe 'missing_keys' do
    context '.env is not missing any keys from .env.example' do
      it 'returns an empty array' do
        allow(File).to receive(:readlines).with(".env").and_return(
          ["SOME_API_KEY=", "SOME_API_SECRET="]
        )
        allow(File).to receive(:readlines).with(".env.example").and_return(
          ["SOME_API_KEY=", "SOME_API_SECRET="]
        )

        dot_env_dot_example = DotEnvDotExample.new
        expect(dot_env_dot_example.missing_keys).to eq []
      end
    end

    context '.env is missing a key from .env.example' do
      it 'returns those ENV variables in an array' do
        allow(File).to receive(:readlines).with(".env").and_return(
          ["SOME_API_KEY=some_value"]
        )
        allow(File).to receive(:readlines).with(".env.example").and_return(
          ["SOME_API_KEY=", "SOME_API_SECRET="]
        )

        dot_env_dot_example = DotEnvDotExample.new
        expect(dot_env_dot_example.missing_keys).to eq ["SOME_API_SECRET"]
      end
    end
  end

  describe '#keys_new_to_example' do
    context '.env contains new keys that .env.example did not have' do
      it 'returns the new keys' do
        allow(File).to receive(:readlines).with(".env").and_return(
          ["SOME_API_KEY=some_value", "SOME_API_SECRET=other_value"]
        )
        allow(File).to receive(:readlines).with(".env.example").and_return(
          ["SOME_API_KEY="]
        )
        dot_env_dot_example = DotEnvDotExample.new

        expect(dot_env_dot_example.keys_new_to_example).to eq ["SOME_API_SECRET"]
      end
    end

    context '.env and .env.example contain the same keys' do
      it 'returns an empty array' do
        allow(File).to receive(:readlines).with(".env").and_return(
          ["SOME_API_KEY=some_value", "SOME_API_SECRET=other_value"]
        )
        allow(File).to receive(:readlines).with(".env.example").and_return(
          ["SOME_API_KEY=", "SOME_API_SECRET="]
        )
        dot_env_dot_example = DotEnvDotExample.new

        expect(dot_env_dot_example.keys_new_to_example).to eq []
      end
    end
  end

  describe '#pre_commit_hook' do
    context 'default filenames for .env and .env.example are used' do
      it 'uses these in the commands for the pre commit hook' do
        allow(File).to receive(:readlines).with(".env")
        allow(File).to receive(:readlines).with(".env.example")
        dot_env_dot_example = DotEnvDotExample.new

        expect(dot_env_dot_example.pre_commit_hook).to eq "dot_example sync\ngit add .env.example"
      end
    end

    #context 'alternative filenames for .env and .env.example are used' do
      #it 'uses these file locations in the commands' do
        #allow(File).to receive(:readlines).with(".env")
        #allow(File).to receive(:readlines).with(".env.template")
        #dot_env_dot_example = DotEnvDotExample.new
      #end
    #end
  end
end
