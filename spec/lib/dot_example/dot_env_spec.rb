require 'spec_helper'

describe DotEnv do
  describe '#key_lines' do
    it 'returns a string with each key on its own line' do
      dot_env_file = DotEnv.new(".env", ['SOME_API_KEY=Foo', 'SOME_API_SECRET=Bar'])
      expect(dot_env_file.key_lines).to eq "SOME_API_KEY=\nSOME_API_SECRET="
    end
  end
end
