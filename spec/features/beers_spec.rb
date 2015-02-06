require 'rails_helper'

describe "Beer" do
  let!(:brewery) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:user) { FactoryGirl.create :user }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  it "is added when given a valid name" do
    visit new_beer_path
    save_and_open_page
    fill_in('beer_name', with:'olut')
    expect{
      click_button('Create Beer')
    }.to change{Beer.count}.by(1)
  end

  it "is not added when given an invalid name" do
    visit new_beer_path

    expect{
      click_button('Create Beer')
    }.to change{Beer.count}.by(0)
  end
end