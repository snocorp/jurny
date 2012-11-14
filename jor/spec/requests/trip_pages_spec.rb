require 'spec_helper'

describe "Trips pages" do

  subject { page }
  
  describe "trips" do
    describe "page" do
      let(:traveller) { FactoryGirl.create(:traveller) }
      let(:admin) { FactoryGirl.create(:admin) }
      before do
        @trip = traveller.owned_trips.build(name: "Traveller Trip")
        @admin_trip = admin.owned_trips.build(name: "Admin Trip")
      end
      
      describe "for regular user" do
        before do
          sign_in traveller
          visit trips_path
        end

        it { should have_selector('h1',    text: 'Trips') }
        it { should have_selector('title', text: 'trips') }
        
        it "should list each trip for the user" do
          traveller.trips.each do |trip|
            page.should have_selector('a', text: trip.name)
          end
        end
        it { should_not have_selector('a', text: @admin_trip.name)}
      end      
      
      describe "for signed out user" do
        before { visit trips_path }

        specify { current_path.should eq(signin_path) }
        it { should have_notice('Please sign in.') }
        
        describe "after sign in as regular user" do
          before do
            fill_in "Email", with: traveller.email
            fill_in "Password", with: traveller.password
            click_button "Sign in"
          end

          specify { current_path.should eq(trips_path) }
        end
      end
    end
  
    describe "all trips" do
      describe "page" do
        let(:traveller) { FactoryGirl.create(:traveller) }
        let(:admin) { FactoryGirl.create(:admin) }
      before do
        @trip = traveller.owned_trips.build(name: "Traveller Trip")
        @admin_trip = admin.owned_trips.build(name: "Admin Trip")
      end

        describe "for regular user" do
          before do
            sign_in traveller
            visit trips_all_path
          end

          specify { current_path.should eq(root_path) }
          it { should have_notice('Permission denied') }
        end

        describe "for admin user" do
          before do
            sign_in admin
            visit trips_all_path
          end

          it { should have_selector('h1',    text: 'Trips') }
          it { should have_selector('title', text: 'trips') }
          
          it "should list each trip for all users" do
            Trip.all.each do |trip|
              page.should have_selector('a', text: trip.name)
            end
          end
        end      
      
        describe "for signed out user" do
          before { visit trips_all_path }

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

            specify { current_path.should eq(trips_all_path) }
          end
        end
      end
    end
  end
end
