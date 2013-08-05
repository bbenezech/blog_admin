require 'spec_helper'

describe "publish blog posts", :type => :feature do
  before :each do
    User.create(email: 'user@example.com', password: 'password', profile: 'writer')
  end

  it "creates a new blog post and publish it" do

    visit rails_admin.dashboard_path                                                           # let's go to the dashboard!

    expect(current_path).to eq new_user_session_path                                           # we are being redirected for auth.

    fill_in 'Email', with: 'user@example.com'                                                  # Fillin' some email
    fill_in 'Password', with: 'password'                                                       # and password,
    click_button 'Sign in'                                                                     # and pressing 'Sign in',

    expect(current_path).to eq rails_admin.dashboard_path                                      # I should finally be redirected to dashboard
    expect(page.find('.alert')).to have_content 'Signed in successfully'                       # with a word of notice
    expect(page.find('[data-model]')).to have_content('Posts')                                 # where I can manage 'Posts'
    expect(page.find('[data-model]')).to_not have_content('Users')                             # but not 'Users'

    page.find('.blog_post_links .new_collection_link a').click                                 # I press the new (collection level) link for Post

    expect(current_path).to eq rails_admin.new_path(model_name: 'blog~post')                   # I should be on the new post page
    fill_in 'Title', with: 'Unpublished post'                                                  # Where I fill in a new title "Unpublished post"
    click_button 'Save and edit'                                                               # And press "Save and edit"
    post = Blog::Post.first
    expect(current_path).to eq rails_admin.edit_path(model_name: 'blog~post', id: post.id)     # I should be redirected to the edit page
    expect(page.find('.alert')).to have_content 'Post successfully created'                    # with a word of notice
    expect(post.reload.metadata['published']).to eq '0'                                        # and the post shouldn't be published yet

    page.find('.nav-tabs .publish_member_link a').click                                        # In the nav-tabs, I click the publish link for the current post

    expect(current_path).to eq rails_admin.publish_path(model_name: 'blog~post', id: post.id)  # I should be on the post publish page
    click_button "Yes, I'm sure"                                                               # Where I confirm I want to publish it

    expect(current_path).to eq rails_admin.index_path(model_name: 'blog~post')                 # I should land on the index page of Posts
    expect(page.find('.alert')).to have_content 'Post successfully published'                  # with a word of notice
    expect(post.reload.metadata['published']).to eq true                                       # and the post should be published
  end
end
