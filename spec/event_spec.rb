# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
# require 'rspec'
require 'capybara/rspec'
require 'capybara/dsl'

RSpec.describe 'Creating a event', type: :feature do
  scenario 'valid inputs' do
    visit welcome_path
    expect(page).to have_content('Please sign-in to continue!')
    click_button 'Sign Up'
    fill_in 'Email', with: 'test1233'
    fill_in 'Password', with: 'test1233'
    click_on 'Create User'

    visit new_event_path

    fill_in 'Name', with: 'Honor Career Fair'
    fill_in 'Date', with: DateTime.current.strftime("%m%d%Y\t%I%M%P")
    sleep(3)
    fill_in 'Description', with: 'Gimme job pls man'
    fill_in 'event_type', with: 'Career Fair'
    fill_in 'location', with: 'Zach 420'
    click_on 'Create Event'
    visit events_path
    expect(page).to have_content('Career Fair')
  end

  scenario 'invalid inputs' do
    visit welcome_path
    expect(page).to have_content('Please sign-in to continue!')
    click_button 'Sign Up'
    fill_in 'Username', with: 'test1233'
    fill_in 'Password', with: 'test1233'
    click_on 'Create User'

    visit new_event_path

    fill_in 'Name', with: 'Honor Career Fair'
    fill_in 'Date', with: DateTime.current.strftime("%m%d%Y\t%I%M%P")
    fill_in 'Description', with: 'Gimme job pls man'
    fill_in 'event_type', with: 'Career Fair'
    click_on 'Create Event'
    expect(page).to have_content('New Event')
  end
end

RSpec.describe 'Updating a event', type: :feature do
  scenario 'valid inputs' do
    visit welcome_path
    expect(page).to have_content('Please sign-in to continue!')
    click_button 'Sign Up'
    fill_in 'Username', with: 'test1233'
    fill_in 'Password', with: 'test1233'
    click_on 'Create User'

    newB = Event.create!(name: 'LOLMAN', date: Time.zone.now, description: 'Get a job', event_type: 'Career Fair', location: 'Zach 420')
    visit edit_event_path(id: newB.id)
    sleep(3)
    fill_in 'Name', with: 'Honors Career Fair'
    click_on 'Update Event'
    visit events_path
    # sleep(3)
    expect(page).to have_content('Career Fair')
  end
end

RSpec.describe 'Deleting a event', type: :feature do
  scenario 'success' do
    visit welcome_path
    expect(page).to have_content('Please sign-in to continue!')
    click_button 'Sign Up'
    fill_in 'Email', with: 'test1233'
    fill_in 'Password', with: 'test1233'
    click_on 'Create User'

    newB = Event.create!(name: 'LOLMAN', description: 'Get a job', event_type: 'Career Fair', location: 'Zach 420', date: DateTime.current.strftime("%m%d%Y\t%I%M%P"))
    visit events_path
    find(:xpath, ".//a[i[contains(@class, 'fa fa-trash fa-lg')]]").click
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content('Event was successfully destroyed.')
    expect(page).not_to have_content('LOLMAN')

    newB = Event.create!(name: 'LOLMAN', description: 'Get a job', event_type: 'Career Fair', location: 'Zach 420', date: DateTime.current.strftime("%m%d%Y\t%I%M%P"))
    visit events_path
    find(:xpath, ".//a[i[contains(@class, 'fa fa-trash fa-lg')]]").click
    page.driver.browser.switch_to.alert.accept
    expect(page).to have_content('Event was successfully destroyed.')
    expect(page).not_to have_content('LOLMAN')
  end
end

RSpec.describe 'Viewing a event', type: :feature do
  scenario 'success' do
    visit welcome_path
    expect(page).to have_content('Please sign-in to continue!')
    click_button 'Sign Up'
    fill_in 'Email', with: 'test1233'
    fill_in 'Password', with: 'test1233'
    click_on 'Create User'

    newB = Event.create!(name: 'LOLMAN', description: 'Get a job', event_type: 'Career Fair', location: 'Zach 420', date: Time.zone.now)
    visit events_path
    find(:xpath, ".//a[i[contains(@class, 'fa fa-search fa-lg')]]").click
    expect(page).to have_content('Name: LOLMAN')
    sleep(3)
  end
end

RSpec.describe EventsController, type: :feature do
  scenario 'Importing Events CSV with correct headers' do
    visit welcome_path
    expect(page).to have_content('Please sign-in to continue!')
    click_button 'Sign Up'
    fill_in 'Username', with: 'test1233'
    fill_in 'Password', with: 'test1233'
    click_on 'Create User'
    visit events_path
    attach_file('file', "#{Rails.root}/spec/eventsExported.csv", visible: false)
    click_on('Import CSV', visible: false)
    visit events_path
    sleep(4)
    expect(page).to have_content('pool party')
    expect(page).to have_content('1998-11-12 02:45:00 UTC')
    expect(page).to have_content('Its a party')
    expect(page).to have_content('Service')
    expect(page).to have_content('Tomball, Tx')
  end
end
