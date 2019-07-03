require "rails_helper"

RSpec.describe "the home page", type: :system do

  before do
    driven_by(:rack_test)
  end

  it "works" do
    visit root_path

    expect(page).to have_content("Home Page")
  end
end


