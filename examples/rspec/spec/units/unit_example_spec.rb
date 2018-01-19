require 'spec_helper'

RSpec.describe "unit example" do
  it 'is passing' do
    expect(true).to be(true)
  end

  it 'is failing' do
    expect(true).to be(false)
  end
end
