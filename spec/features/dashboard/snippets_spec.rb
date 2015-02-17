require 'spec_helper'

describe "In the dashboard, Snippets" do
  before do 
    login_admin
  end

  it "lists snippets", js: true do
    3.times{ FactoryGirl.create(:snippet) }
    visit storytime.dashboard_path
    find("#snippets-link").trigger('click')
    wait_for_ajax
    
    Storytime::Snippet.all.each do |s|
      expect(page).to have_link(s.name, href: url_for([:edit, :dashboard, s, only_path: true]))
      expect(page).to_not have_content(s.content)
    end
  end
  
  it "creates a snippet", js: true do
    visit storytime.dashboard_path
    find("#snippets-link").trigger('click')
    wait_for_ajax
    click_link "new-snippet-link"
    expect(page).to have_content("New Text Snippet")

    expect{
      fill_in "snippet_name", with: "jumbotron-text"
      fill_in "snippet_content", with: "Hooray Writing!"
      click_button "Save"
      expect(page).to have_content("Text Snippets")
    }.to change(Storytime::Snippet, :count).by(1)
  end

  it "updates a snippet", js: true do
    snippet = FactoryGirl.create(:snippet, content: "Test")

    visit storytime.dashboard_path
    click_link "snippets-link"
    expect(page).to have_content("Text Snippets")

    click_link "edit-snippet-#{snippet.id}"
    
    expect(page).to have_content("Edit Text Snippet")
    fill_in "snippet_name", with: "new-name"
    fill_in "snippet_content", with: "It was a dark and stormy night..."
    click_button "Save"
    
    expect(page).to have_content("Text Snippets")

    snippet.reload
    expect(snippet.name).to eq("new-name")
    expect(snippet.content).to eq("It was a dark and stormy night...")
  end

  it "deletes a snippet", js: true do
    snippet = FactoryGirl.create :snippet

    visit storytime.dashboard_path
    click_link("snippets-link")
    expect(page).to have_content(snippet.name)

    expect{
      find("#snippet_#{snippet.id}").hover()
      expect(page).to have_selector("#delete_snippet_#{snippet.id}")
      click_link "delete_snippet_#{snippet.id}"
      expect(page).to_not have_content(snippet.name)
    }.to change(Storytime::Snippet, :count).by(-1)
  end
  
end
