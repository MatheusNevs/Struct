require 'rails_helper'

RSpec.describe Group, type: :model do
  context "validates - " do
    it "either not nil title and not nil description should be valid" do
      expect(build(:group)).to be_valid
    end

    it "nil title should'nt be valid" do
      expect(build(:group, title:nil)).to be_invalid
    end

    it "nill description should'nt be valid" do
      expect(build(:group, description:nil)). to be_invalid
    end
  end
end
