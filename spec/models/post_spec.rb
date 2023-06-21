require 'rails_helper'

RSpec.describe Post, type: :model do
  context "Testing factory" do
    it "should be valid" do
      expect(build(:post)).to be_valid
    end
  end
  # Adicionar testes: do content, do title
end