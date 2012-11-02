require 'spec_helper'

RSpec::Matchers.define :have_edit_fields_for do |traveller|
  match do |page|
    page.should have_field('Email', with: traveller.email )
    page.should have_field('First Name', with: traveller.firstname )
    page.should have_field('Last Name', with: traveller.lastname )
  end
end

RSpec::Matchers.define :have_create_fields do
  match do |page|
    page.should have_field('Email' )
    page.should have_field('First Name' )
    page.should have_field('Last Name' )
    page.should have_field('Password', type: 'password' )
    page.should have_field('Confirm', type: 'password' )
  end
end

RSpec::Matchers.define :have_text_for do |traveller|
  match do |page|
    page.should have_selector('p', text => traveller.firstname)
    page.should have_selector('p', text => traveller.lastname)
    page.should have_selector('p', text => traveller.email)
  end
end

describe "Traveller pages" do

  subject { page }
  
  describe "profile" do
    describe "page" do
      let(:traveller) { FactoryGirl.create(:traveller) }
      let(:admin) { FactoryGirl.create(:admin) }

      describe "for signed out user" do
        before { visit traveller_path(traveller) }

        specify { current_path.should eq(signin_path) }
        it { should have_notice('Please sign in.') }
        
        describe "after sign in" do
          before do
            fill_in "Email", with: traveller.email
            fill_in "Password", with: traveller.password
            click_button "Sign in"
          end
          
          specify { current_path.should eq(traveller_path(traveller)) }
        end
      end

      describe "for regular user" do
        before do 
          sign_in traveller
          visit traveller_path(traveller)
        end

        it { should have_selector('title', text: 'profile') }
        it { should have_text_for(traveller) }

        it "should not have a link to the travellers list" do
          should_not have_selector('div.container a', href: travellers_path, text: 'Travellers')
        end
      end

      describe "for admin user" do
        before do 
          sign_in admin
          visit traveller_path(admin)
        end

        it { should have_selector('title', text: 'profile') }
        it { should have_text_for(admin) }

        it "should have a link to the travellers list" do
          should have_selector('div.container a', href: travellers_path, text: 'Travellers')
        end
      end
    end
  end
  
  describe "travellers" do
    describe "page" do
      let(:traveller) { FactoryGirl.create(:traveller) }
      let(:admin) { FactoryGirl.create(:admin) }
      
      describe "for regular user" do
        before do 
          sign_in traveller
          visit travellers_path
        end

        specify { current_path.should eq(root_path) }
        it { should have_notice('Permission denied') }
      end

      describe "for admin user" do
        before do 
          sign_in admin
          visit travellers_path
        end

        it { should have_selector('h1',    text: 'Travellers') }
        it { should have_selector('title', text: 'travellers') }
      end      
      
      describe "for signed out user" do
        before { visit travellers_path }

        specify { current_path.should eq(signin_path) }
        it { should have_notice('Please sign in.') }
        
        describe "after sign in as regular user" do
          before do
            fill_in "Email", with: traveller.email
            fill_in "Password", with: traveller.password
            click_button "Sign in"
          end

          specify { current_path.should eq(root_path) }
          it { should have_notice('Permission denied') }
        end
        
        describe "after sign in as admin user" do
          before do
            fill_in "Email", with: admin.email
            fill_in "Password", with: admin.password
            click_button "Sign in"
          end
          
          specify { current_path.should eq(travellers_path) }
        end
      end
    end
  end
  
  describe "edit" do
    let(:traveller) { FactoryGirl.create(:traveller) }
    let(:admin) { FactoryGirl.create(:admin) }
    
    let(:submit) { "Update" }
    
    describe "page" do
      let(:traveller) { FactoryGirl.create(:traveller) }
      let(:admin) { FactoryGirl.create(:admin) }

      describe "for regular user" do
        before do 
          sign_in traveller
          visit edit_traveller_path(traveller)
        end

        it { should have_selector('title', text: 'edit traveller') }
        it { should have_selector('div.container a', href: traveller_path(traveller), text: 'Profile') }

        it { should have_edit_fields_for(traveller) }
        it { should have_button("Update") }

        it "should not have a link to the travellers list" do
          should_not have_selector('div.container a', href: travellers_path, text: 'Travellers')
        end
      end

      describe "for admin user" do
        before do 
          sign_in admin
          visit edit_traveller_path(admin)
        end

        it { should have_selector('title', text: 'edit traveller') }
        it { should have_selector('div.container a', href: traveller_path(admin), text: 'Profile') }

        it { should have_edit_fields_for(admin) }
        it { should have_checked_field("Admin") }
        it { should have_button("Update") }

        it "should have a link to the travellers list" do
          should have_selector('div.container a', href: travellers_path, text: 'Travellers')
        end
      end
    end
    
    describe "when user is not signed in" do
      before { visit edit_traveller_path(traveller) }
      
      specify { current_path.should eq(signin_path) }
      it { should have_notice('Please sign in.') }
    end
    
    describe "when user is editing different user" do
      before do
        sign_in(traveller)
        visit edit_traveller_path(admin)
      end
      
      specify { current_path.should eq(root_path) }
      it { should have_notice('Permission denied') }
    end
    
    describe "when admin is editing different user" do
      before do
        sign_in(admin)
        visit edit_traveller_path(traveller)
      end
      
      it { should have_selector('title', text: 'edit traveller') }
      it { should_not have_notice('Permission denied') }
      
      it { should have_edit_fields_for(traveller) }
      it { should have_unchecked_field("Admin") }
      
      describe "with invalid information" do
        before do
          fill_in "Email", with: "invalidemail"
          click_button submit
        end
        
        it { should have_content('error') }
      end
      
      describe "with valid information" do
        let(:new_firstname)  { "New First Name" }
        let(:new_lastname)  { "New Last Name" }
        let(:new_email) { "new@example.com" }
        before do
          fill_in "First Name",       with: new_firstname
          fill_in "Last Name",        with: new_lastname
          fill_in "Email",            with: new_email
          check "Admin"
          click_button submit
        end
        
        it { should have_selector('title', text: "profile") }
        it { should have_selector('div.alert.alert-success') }
        it { should have_link('Sign out', href: signout_path) }
        specify { traveller.reload.firstname.should  == new_firstname }
        specify { traveller.reload.lastname.should  == new_lastname }
        specify { traveller.reload.email.should == new_email }
        specify { traveller.reload.admin?.should == true }
      end
    end
    
    describe "when user is editing user" do
      before do
        sign_in(traveller)
        visit edit_traveller_path(traveller)
      end
      
      it { should have_selector('title', text: 'edit traveller') }
      it { should_not have_selector('div.alert.alert-notice', text: 'Permission denied') }
      
      it { should have_edit_fields_for(traveller) }
      
      describe "with invalid information" do
        before do
          fill_in "Email", with: "invalidemail"
          click_button submit
        end
        
        it { should have_content('error') }
      end
      
      describe "with valid information" do
        let(:new_firstname)  { "New First Name" }
        let(:new_lastname)  { "New Last Name" }
        let(:new_email) { "new@example.com" }
        before do
          fill_in "First Name",       with: new_firstname
          fill_in "Last Name",        with: new_lastname
          fill_in "Email",            with: new_email
          click_button submit
        end
        
        it { should have_selector('title', text: "profile") }
        it { should have_selector('div.alert.alert-success') }
        it { should have_link('Sign out', href: signout_path) }
        specify { traveller.reload.firstname.should  == new_firstname }
        specify { traveller.reload.lastname.should  == new_lastname }
        specify { traveller.reload.email.should == new_email }
      end
    end
  end

  describe "signup" do

    let(:submit) { "Sign Up" }

    describe "page" do
      let(:traveller) { FactoryGirl.create(:traveller) }

      describe "for signed out user" do
        before { visit signup_path }

        it { should have_selector('h1',    text: 'Sign Up') }
        it { should have_selector('title', text: 'sign up') }

        it { should have_create_fields }
      end

      describe "for signed in user" do
        before do
          sign_in traveller
          visit signup_path
        end

        specify { current_path.should eq(root_path) }
        it { should have_notice('You\'re already signed up.') }
      end
    end

    describe "with invalid information" do

      before { visit signup_path }
    
      it "should not create a user" do
        expect { click_button submit }.not_to change(Traveller, :count)
      end
    end

    describe "with valid information" do
      before do
        visit signup_path
        fill_in "First Name",   with: "Example"
        fill_in "Last Name",    with: "User"
        fill_in "Email",        with: "user@example.com"
        fill_in "Password",     with: "foobar"
        fill_in "Confirm", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(Traveller, :count).by(1)
      end
      it "should not create an admin user" do
        expect { click_button submit }.not_to change(Traveller.where(:admin => 1), :count)
      end
    end
  end
end
