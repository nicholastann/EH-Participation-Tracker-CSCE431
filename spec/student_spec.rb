# frozen_string_literal: true

require 'rails_helper'
require 'spec_helper'
# require 'rspec'
require 'capybara/rspec'
require 'capybara/dsl'
# require 'books'

RSpec.describe 'Creating a student', type: :feature do
  scenario 'valid inputs' do
    visit welcome_path
    expect(page).to have_content('Please sign-in to continue!')
    click_button 'Sign Up'
    fill_in 'Email', with: 'test1233'
    fill_in 'Password', with: 'test1233'
    click_on 'Create User'

    visit new_student_path

    fill_in 'First Name', with: 'Sam'
    fill_in 'Last Name', with: 'Ham'
    fill_in 'Email', with: 'samHam@tamu.edu'
    fill_in 'Uin', with: '32134213'
    fill_in 'Year', with: '2021'
    fill_in 'Major', with: 'CSCE'
    fill_in 'Gpa', with: '2021'
    click_on 'Create Student'
    visit students_path
    # sleep(5)
    expect(page).to have_content('Sam')
  end

  scenario 'invalid inputs' do
    visit welcome_path
    expect(page).to have_content('Please sign-in to continue!')
    click_button 'Sign Up'
    fill_in 'Email', with: 'test1233'
    fill_in 'Password', with: 'test1233'
    click_on 'Create User'

    visit new_student_path

    fill_in 'First Name', with: 'Sam'
    fill_in 'Last Name', with: 'Ham'
    fill_in 'Email', with: 'samHam@tamu.edu'
    fill_in 'Uin', with: '32134213'
    fill_in 'Year', with: '2021'
    fill_in 'Major', with: 'CSCE'
    click_on 'Create Student'
    expect(page).to have_content('New Student')
  end
end

RSpec.describe 'Updating a student', type: :feature do
  scenario 'valid inputs' do
    visit welcome_path
    expect(page).to have_content('Please sign-in to continue!')
    click_button 'Sign Up'
    fill_in 'Username', with: 'test1233'
    fill_in 'Password', with: 'test1233'
    click_on 'Create User'

    newB = Student.create!(firstName: 'Magic', lastName: 'Phil', email: 'Nice', gpa: 2.1, status: 'Bad Standing', uin: 123_213, year: 2001, major: 'CSCE')
    visit edit_student_path(id: newB.id)
    fill_in 'First Name', with: 'Ham'
    click_on 'Update Student'
    visit students_path
    # sleep(3)
    expect(page).to have_content('Ham')
  end
end

RSpec.describe 'Deleting a student', type: :feature do
  scenario 'success' do
    visit welcome_path
    expect(page).to have_content('Please sign-in to continue!')
    click_button 'Sign Up'
    fill_in 'Email', with: 'test1233'
    fill_in 'Password', with: 'test1233'
    click_on 'Create User'

    newB = Student.create!(firstName: 'Magic', lastName: 'Phil', email: 'Nice', gpa: 2.1, status: 'Bad Standing', uin: 123_213, year: 2001, major: 'CSCE')
    visit students_path
    first(:xpath, ".//a[i[contains(@class, 'fa fa-trash fa-lg')]]").click
    page.driver.browser.switch_to.alert.accept
    page.driver.browser.switch_to.alert.accept
    expect(page).not_to have_content('Magic')
  end
end

RSpec.describe 'Viewing a student', type: :feature do
  scenario 'success' do
    visit welcome_path
    expect(page).to have_content('Please sign-in to continue!')
    click_button 'Sign Up'
    fill_in 'Email', with: 'test1233'
    fill_in 'Password', with: 'test1233'
    click_on 'Create User'

    newB = Student.create!(firstName: 'Magic', lastName: 'Phil', email: 'Nice', gpa: 2.1, status: 'Bad Standing', uin: 123_213, year: 2001, major: 'CSCE')
    visit students_path
    first(:xpath, ".//a[i[contains(@class, 'fa fa-search fa-lg')]]").click
    expect(page).to have_content('enter first name')
    sleep(6)
  end
end

RSpec.describe StudentsController, type: :feature do
  scenario 'valid inputs' do
    visit welcome_path
    expect(page).to have_content('Please sign-in to continue!')
    click_button 'Sign Up'
    fill_in 'Username', with: 'test1233'
    fill_in 'Password', with: 'test1233'
    click_on 'Create User'
    visit students_path
    attach_file('file', "#{Rails.root}/spec/studentsExported.csv", visible: false)
    click_on('Import CSV', visible: false)
    visit students_path
    sleep(4)
    expect(page).to have_content('Chuck')
    expect(page).to have_content('Esedebe')
    expect(page).to have_content('cce0359@tamu.edu')
    expect(page).to have_content('123456789')
    expect(page).to have_content('2021')
    expect(page).to have_content('CPSC')
    expect(page).to have_content('0.0')
    expect(page).to have_content('Good Standing')
    expect(page).to have_content('Nicholas')
  end
end
