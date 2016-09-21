require 'spec_helper'

describe DotEnv do
  describe '#key_lines' do
    it 'returns a string with each key on its own line' do
      dot_env_file = DotEnv.new("spec/support/.env")
      expect(dot_env_file.key_lines).to eq "SOME_API_KEY=\nSOME_API_SECRET="
    end
  end

# TODO: This logic has been moved to a lint! function but I'm not sure when and how to use that...
# Maybe as a separate command that is called only when the .env needs to be valid?

  #describe '#key_lines' do
    #it 'raises an error if file contains a line with spaces in the ENV' do
      # Let me just see if I'm allowed to use that parameter in the initializer
      #WRONG _FORMATTING=a3429e8959\n
      #dot_env = DotEnv.new('spec/support/.env')
      #allow(File).to receive(:readlines).and_return(
        #["CORRECT_FORMATTING=28d1230fk\n",
         #"WRONG _FORMATTING=a3429e8959\n"]
      #)

      # TODO: Does it make sense to create a class to encapsulate the error?
      #expect{ dot_env.key_lines }.to raise_error(InvalidDotEnvError)
      #expect{ dot_env.key_lines }.to raise_error(RuntimeError)
    #end

    #it 'raises an error if file contains a line with multiple "="s' do
      #dot_env = DotEnv.new('spec/support/.env')
      #allow(File).to receive(:readlines).and_return(
        #["CORRECT_FORMATTING=28d1230fk\n",
         #"FORMATTING=WRONG=a3429e8959\n"]
      #)

      #expect{ dot_env.key_lines }.to raise_error(RuntimeError)
    #end

    #it 'does not returns an error if ENV variables are formatted correctly' do
      #dot_env = DotEnv.new('spec/support/.env')
      #allow(File).to receive(:readlines).and_return(
        #["CORRECT_FORMATTING=28d1230fk\n",
         #"ALSO_CORRECT=a3429e8959\n"]
      #)

      #expect{ dot_env.key_lines }.not_to raise_error
    #end
  #end
end
