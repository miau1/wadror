require 'rails_helper'

describe Beer do
  it "is not saved without a name" do
    beer = Beer.create style:"Lager"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not saved without a style" do
    beer = Beer.create name:"kalja"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  describe "with a name and a style" do
    let(:beer){ Beer.create name:"kalja", style:"Lager" }

    it "is saved" do
      expect(beer).to be_valid
      expect(Beer.count).to eq(1)
    end
  end
end
