# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
# require 'rspec'
require 'capybara/rspec'
require 'capybara/dsl'

RSpec.describe 'Registering User', type: :feature do
    scenario 'Signup with valid input' do
        visit welcome_path
        expect(page).to have_content("Please sign-in to continue!")
        click_button 'Sign Up'
        fill_in 'Email', with: 'test1233'
        fill_in 'Password', with: 'test1233'
        click_on 'Create User'
        expect(page).to have_content('Welcome back, test1233!')
        find('a', text: 'Logout').click()

    within('#logoutModal') do
      # expect(page).to have_content("Are you sure you would like to logout?")
      find('a', text: 'Log out').click
    end
    sleep(1)
    expect(page).to have_content('Please sign-in to continue!')
    sleep(1)
  end

  # TODO: Invalid inputs, signing up existing user
end

RSpec.describe 'Logging in User', type: :feature do
    scenario 'Login with existing user' do
        visit welcome_path
        expect(page).to have_content("Please sign-in to continue!")
        click_button 'Sign Up'
        fill_in 'Email', with: 'test1233'
        fill_in 'Password', with: 'test1233'
        click_on 'Create User'
        expect(page).to have_content('Welcome back, test1233!')
        find('a', text: 'Logout').click()
        
        within('#logoutModal') do
            # expect(page).to have_content("Are you sure you would like to logout?")    
            find('a', text: 'Log out').click()
        end

        click_button 'Login'
        fill_in 'Email', with: 'test1233'
        fill_in 'Password', with: 'test1233'
        click_on 'Login'
        expect(page).to have_content('Welcome back, test1233!')
    end

    scenario 'Login with unregistered user' do
        visit welcome_path
        click_button 'Login'
        fill_in 'Email', with: 'test1233'
        fill_in 'Password', with: 'test1233'
        click_on 'Login'
        expect(page).to have_content('Login')
    end
end

RSpec.describe 'Penetration Testing', type: :feature do
    scenario 'Logging in with SQL Injection' do
        visit welcome_path
        expect(page).to have_content("Please sign-in to continue!")
        click_button 'Sign Up'
        fill_in 'Email', with: 'test1233'
        fill_in 'Password', with: 'test1233'
        click_on 'Create User'
        expect(page).to have_content('Welcome back, test1233!')
        find('a', text: 'Logout').click()
        
        within('#logoutModal') do
            # expect(page).to have_content("Are you sure you would like to logout?")    
            find('a', text: 'Log out').click()
        end

        click_button 'Login'
        fill_in 'Email', with: 'test1233\'or\'1\'=\'1'
        fill_in 'Password', with: 'test1233\'or\'1\'=\'1'
        click_on 'Login'
        expect(page).not_to have_content('Welcome back, test1233!')
    end

    click_button 'Login'
    fill_in 'email', with: 'test1233\'or\'1\'=\'1'
    fill_in 'Password', with: 'test1233\'or\'1\'=\'1'
    click_on 'Login'
    expect(page).not_to have_content('Welcome back, test1233!')
  end
end
