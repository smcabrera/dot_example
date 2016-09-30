require 'spec_helper'

RSpec.describe 'dot_example sync', :type => :aruba do
  let(:dot_env_file) { '.env'  }
  let(:dot_env_content) { 'FOO=var'  }
  let(:dot_env_dot_example_file) { '.env.example'  }
  let(:dot_env_dot_example_content) { '.env.example'  }

  before(:each) { write_file dot_env_file, dot_env_content  }
  before(:each) { write_file dot_env_dot_example_file, ''  }
  #before(:each) { write_file dot_env_file, dot_env_content  }

  xit 'writes the keys from .env to .env.example' do
    `dot_example sync`
    require 'pry' ; binding.pry
    expect(read(dot_env_dot_example_file)).to eq dot_env_content
  end
end
