require 'rails_helper'

describe Beer do
  let(:style) { FactoryGirl.create :style }
  it "is not saved without a name" do

    beer = Beer.create style:style

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not saved without a style" do
    beer = Beer.create name:"kalja"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  describe "with a name and a style" do
    let(:style) { FactoryGirl.create :style }
    let(:beer){ Beer.create name:"kalja", style:style }

    it "is saved" do
      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end
  end
end
