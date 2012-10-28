require 'spec_helper'

describe "Traveller pages" do

  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_selector('h1',    text: 'Sign Up') }
    it { should have_selector('title', text: 'sign up') }
  end

  describe "profile page" do
    let(:traveller) { FactoryGirl.create(:traveller) }
    before do 
      sign_in traveller
      visit traveller_path(traveller)
    end

    it { should have_selector('title', text: 'profile') }
    it { should have_selector('p', text => traveller.firstname) }
    it { should have_selector('p', text => traveller.lastname) }
    it { should have_selector('p', text => traveller.email) }
  end

  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Sign Up" }

    describe "with invalid information" do
      it "should not create a user" do
        expect { click_button submit }.not_to change(Traveller, :count)
      end
    end

    describe "with valid information" do
      before do
        fill_in "First Name",   with: "Example"
        fill_in "Last Name",    with: "User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirm", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(Traveller, :count).by(1)
      end
    end
  end
end
