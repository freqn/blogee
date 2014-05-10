require 'spec_helper'


feature "Creating Comments" do
  before do
    ActionMailer::Base.deliveries.clear
    @post = FactoryGirl.create(:post, user: FactoryGirl.create(:user))
    visit post_path(@post)
    click_link "Add Comment"
  end

  scenario "with valid attributes" do
    fill_in "Author", with: "Anonymous Internet User"
    fill_in "Content", with: "You're wrong! This is the Internet - whatever you say is wrong."

    click_button "Add Comment"

    expect(current_path).to eq post_path(@post)
    expect(page).to have_content("Comment has been saved.")

    email = find_email!(@post.user.email)
    subject = "[blogee] #{@post.title} - Commment by #{@post.author}"
    email.subject.should include(subject)
  end

  scenario "must have content longer than 15 characters" do
    fill_in "Author", with: "Anonymous Internet User"
    fill_in "Content", with: "You're wrong!"
    click_button "Add Comment"
    expect(page).to have_content("Content must be at least 15 characters long.")
  end

  scenario "with invalid attributes" do
    click_button "Add Comment"
    expect(page).to have_content("Comment has not been saved.")
    expect(page).to have_content("Author can't be blank")
    expect(page).to have_content("Content can't be blank")
  end end
