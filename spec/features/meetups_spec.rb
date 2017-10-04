require "spec_helper"

# require_relative "../../app.rb"

# set :environment, :test_mode
# Capybara.app = Sinatra::Application

feature "pages display correctly" do
  scenario "user visits homepage" do
    visit '/'
    expect(page).to have_content "Meetups"
    end
end
