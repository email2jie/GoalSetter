require 'spec_helper'
require 'rails_helper'

feature "creating goals process" do
  context "when logged in" do
    before(:each) do
      sign_up_as_ginger_baker
      visit '/goals/new'
    end

    it "has a new goal page" do
      expect(page).to have_content("Create New Goal")
    end

    it "has all the right fields" do
      expect(page).to have_content("Title")
      expect(page).to have_content("Description")
      expect(page).to have_content("Completion Date")
      expect(page).to have_content("Type")
    end

    it "takes correct params" do
      fill_in("Title", with: "#{Faker::StarWars.specie}")
      fill_in("Description", with: "#{Faker::Hipster.sentence}")
      fill_in("Completion Date", with: "#{Faker::Date.forward(30)}")
      select("Public", from: 'Type')
      click_button('Set Goal')
      expect(current_url).to eq(goal_url(Goal.last))
    end

    it "takes incorrect params" do
      fill_in("Title", with: "#{Faker::StarWars.specie}")
      fill_in("Description", with: "#{Faker::Hipster.sentence}")
      select("Public", from: 'Type')
      click_button('Set Goal')
      expect(current_url).to eq(new_goal_url)
    end
  end

  context "when not logged " do
    before(:each) do
      visit '/goals/new'
    end

    it "redirects to sign in" do
      expect(current_url).to eq(new_session_url)
    end
  end
end

feature "When viewing all goals" do
  let(:my_public_goal) { FactoryGirl.build(:my_public_goal) }
  let(:public_goal) { FactoryGirl.build(:public_goal) }
  let(:my_private_goal) { FactoryGirl.build(:my_private_goal) }
  let(:private_goal) { FactoryGirl.build(:private_goal) }
  context "when logged in" do
    before(:each) do
      sign_up_as_ginger_baker

      visit user_goals_url(1)
    end

    it "shows everyone's public goals and my private goals" do
      save_and_open_page
      expect(page).to have_content(my_public_goal.title)
      expect(page).to have_content(public_goal.title)
      expect(page).to have_content(my_private_goal.title)
    end

    it "doesn't show private goals" do
      expect(page).to_not have_content(private_goal.title)
    end

    it "each goal is a link" do
      click_on(public_goal.title)
      expect(current_url).to eq(goal_url(public_goal))
    end
  end

  context "when not logged in" do
    before(:each) do
      visit 'users/1/goals'
    end

    it "redirects to sign in" do
      expect(current_url).to eq(new_session_url)
    end
  end

  feature "editing existing goals" do
    # let(:goal) { FactoryGirl.build(:goal) }
  end
end
