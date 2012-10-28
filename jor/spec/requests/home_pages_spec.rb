require 'spec_helper'

describe "HomePages" do
  subject { page }
  
  describe "home page" do
    before { visit root_path }
    
    describe "when user is not signed in" do
      it { should have_selector('title', text => 'jurny') }
      it { should have_selector('h1',    text: 'Plan your journey') }
      it { should have_link('Sign up now!', href: signup_path) }
    end
    
    describe "when user is signed in" do
      let(:user) { FactoryGirl.create(:traveller) }
      before { sign_in user }
      
      it { should have_selector('title', text: 'dashboard') }
      it { should have_selector('h2',    text: 'Your trips') }
      it { should have_selector('h2',    text: 'Your destinations') }
    end
  end
end
