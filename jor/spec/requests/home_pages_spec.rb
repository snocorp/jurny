require 'spec_helper'

describe "HomePages" do
  subject { page }
  
  describe "home page" do
    before { visit root_path }
    
    describe "when user is not signed in" do
      it { should have_selector('title', text => 'jurny') }
      it { should have_selector('h1',    text: 'Plan your journey') }
      it { should have_link('Sign up now!', href: signup_path) }
      it { should have_link('Sign in', href: signin_path) }
    end
    
    describe "when user is signed in" do
      let(:user) { FactoryGirl.create(:traveller) }
      before { sign_in user }
      
      it { should have_selector('title', text: 'dashboard') }
      it { should have_selector('h2',    text: 'Your trips') }
      it { should have_selector('h2',    text: 'Your destinations') }
      
      it { should have_link('Home', href: root_path) }
      it { should have_link('Profile', href: traveller_path(user) ) }
      it { should have_link('Sign out', href: signout_path) }
      
      it { should_not have_link('Admin', href: '#') }
    end
    
    describe "when admin is signed in" do
      let(:user) { FactoryGirl.create(:admin) }
      before { sign_in user }
      
      it { should have_link('Admin', href: '#') }
    end
  end
end
