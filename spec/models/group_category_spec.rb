require 'rails_helper'

RSpec.describe GroupCategory, type: :model do
  context "validates -" do
    it 'it should be valid' do
      expect(build(:group_category)).to be_valid
    end

    it "group category without refers to a category should be invalid" do 
      expect(build(:group_category, category_id:nil)).to be_invalid
    end
    
    it "group category without refers to a group should be invalid" do 
      expect(build(:group_category, group_id:nil)).to be_invalid
    end
  end
end
