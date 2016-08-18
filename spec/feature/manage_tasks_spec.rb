require 'rails_helper'

feature 'Manage tasks', js: true do
  before do
    visit todos_path
    fill_in 'todo_title', with: 'Be Batman'
    page.execute_script("$('form').submit()")
  end

  scenario 'add a new task' do
    expect(page).to have_content('Be Batman')
  end

  scenario 'counter changes' do
    sleep(1) # Wait for 1 second so the counter can be updated

    expect( page.find(:css, 'span#todo-count').text ).to eq "1"
  end

  scenario 'complete a task' do
    check('todo-1')

    sleep(1) # Wait for 1 second so the counter can be updated

    expect( page.find(:css, 'span#todo-count').text ).to eq "0"
  end

  scenario 'advanced todo management' do
    fill_in 'todo_title', with: 'Be Spiderman'
    page.execute_script("$('form').submit()")

    fill_in 'todo_title', with: 'Be Batwoman'
    page.execute_script("$('form').submit()")

    check('todo-1')
    check('todo-2')

    sleep(1) # Wait for 1 second so counters can be updated

    expect( page.find(:css, 'span#todo-count').text ).to eq "1"
    expect( page.find(:css, 'span#completed-count').text ).to eq "2"
    expect( page.find(:css, 'span#total-count').text ).to eq "3"
  end

  scenario 'advanced todo management' do
    fill_in 'todo_title', with: 'Be Spiderman'
    page.execute_script("$('form').submit()")

    fill_in 'todo_title', with: 'Be Batwoman'
    page.execute_script("$('form').submit()")

    check('todo-1')
    check('todo-2')

    click_link('clean-up')
    sleep(1) # Wait for 1 second so counters can be updated

    expect( page.find(:css, 'span#todo-count').text ).to eq "1"
    expect( page.find(:css, 'span#completed-count').text ).to eq "0"
    expect( page.find(:css, 'span#total-count').text ).to eq "1"
  end
end
