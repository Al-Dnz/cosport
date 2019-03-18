require 'rails_helper'

RSpec.describe Comment, type: :model do

   before(:each) do 
     @comment = FactoryBot.create(:comment)
   end
  
  it "has a valid factory" do
    expect(build(:comment)).to be_valid
  end

  context "validation" do

    it "is valid with valid attributes" do
      expect(@comment).to be_a(comment)
    end

   
  end

  context "associations" do

  

  end
end