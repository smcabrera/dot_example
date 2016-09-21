require 'spec_helper'

describe DotExample do
  it 'has a version number' do
    expect(DotExample::VERSION).not_to be nil
  end

  describe '.add_pre_commit_hook' do
    #TODO: For when I figure out how to effectively test these
  end

  describe 'add_post_checkout_hook' do
    #TODO: For when I figure out how to effectively test these
  end
end

