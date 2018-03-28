require 'rails_helper'

describe "User deletes existing category" do
  scenario "a user can delete a category" do
    category = Category.create(title: 'le category')
    visit categories_path

    within(".category_#{category.id}") do
      find(:xpath, ".//a[i[contains(@class, 'fas fa-trash-alt')]]").click
    end

    expect(page).to have_content("le category was successfully deleted!")
  end
end
