require 'spec_helper'

describe "Traveller pages" do

  subject { page }
  
  describe "edit page" do
    let(:traveller) { FactoryGirl.create(:traveller) }
    before do 
      sign_in traveller
      visit edit_traveller_path(traveller)
    end
    
    it { should have_selector('title', text: 'edit traveller') }
    it { should have_selector('div.container a', href: traveller_path(traveller), text: 'Profile') }
    
    it { should have_field('Email', with: traveller.email ) }
    it { should have_field('First Name', with: traveller.firstname ) }
    it { should have_field('Last Name', with: traveller.lastname ) }
    it { should have_field('Password', type: 'password' ) }
    it { should have_field('Confirm', type: 'password' ) }
  end
  
  describe "edit page for admin user" do
    let(:traveller) { FactoryGirl.create(:admin) }
    before do 
      sign_in traveller
      visit edit_traveller_path(traveller)
    end
    
    it { should have_selector('div.container a', href: travellers_path, text: 'Travellers') }
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
  
  describe "profile page for admin user" do
    let(:traveller) { FactoryGirl.create(:admin) }
    before do 
      sign_in traveller
      visit traveller_path(traveller)
    end
    
    it { should have_selector('div.container a', href: travellers_path, text: 'Travellers') }
  end

  describe "signup page" do
    before { visit signup_path }

    it { should have_selector('h1',    text: 'Sign Up') }
    it { should have_selector('title', text: 'sign up') }
  end
  
  describe "travellers page for admin user" do
    let(:traveller) { FactoryGirl.create(:admin) }
    before do 
      sign_in traveller
      visit travellers_path
    end
    
    it { should have_selector('h1',    text: 'Travellers') }
    it { should have_selector('title', text: 'travellers') }
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
