require 'rails_helper'

RSpec.describe "Predictions", type: :system do
  before do
    driven_by(:selenium_chrome_headless)
  end

  it "predicts" do
    visit root_path
    click_link "Teams"

    fill_in "Name", with: "Winners"
    click_button "Create Team"
    expect(page).to have_text("Winners was successfully created.")

    fill_in "Name", with: "Losers"
    click_button "Create Team"
    expect(page).to have_text("Losers was successfully created.")

    click_link "Match results"

    select "Winners", from: "Home team"
    fill_in "Home goals", with: "90"
    fill_in "Home red cards", with: "0"

    select "Losers", from: "Away team"
    fill_in "Away goals", with: "0"
    fill_in "Away red cards", with: "0"

    click_button "Record"

    expect(page).to have_text("90 – 0")

    click_link "Predictions"

    select "Winners", from: "fixture[home_team_id]"
    select "Losers", from: "fixture[away_team_id]"
    click_button "Predict"

    expect(page).to have_text("home\n100.0%")
  end
end
