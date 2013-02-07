# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Sites" do
    describe "Admin" do
      describe "google_calendars" do
        login_refinery_user

        describe "google_calendars list" do
          before(:each) do
            FactoryGirl.create(:google_calendar, :account => "UniqueTitleOne")
            FactoryGirl.create(:google_calendar, :account => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.sites_admin_google_calendars_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before(:each) do
            visit refinery.sites_admin_google_calendars_path

            click_link "Add New Google Calendar"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Account", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Sites::GoogleCalendar.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Account can't be blank")
              Refinery::Sites::GoogleCalendar.count.should == 0
            end
          end

          context "duplicate" do
            before(:each) { FactoryGirl.create(:google_calendar, :account => "UniqueTitle") }

            it "should fail" do
              visit refinery.sites_admin_google_calendars_path

              click_link "Add New Google Calendar"

              fill_in "Account", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::Sites::GoogleCalendar.count.should == 1
            end
          end

        end

        describe "edit" do
          before(:each) { FactoryGirl.create(:google_calendar, :account => "A account") }

          it "should succeed" do
            visit refinery.sites_admin_google_calendars_path

            within ".actions" do
              click_link "Edit this google calendar"
            end

            fill_in "Account", :with => "A different account"
            click_button "Save"

            page.should have_content("'A different account' was successfully updated.")
            page.should have_no_content("A account")
          end
        end

        describe "destroy" do
          before(:each) { FactoryGirl.create(:google_calendar, :account => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.sites_admin_google_calendars_path

            click_link "Remove this google calendar forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Sites::GoogleCalendar.count.should == 0
          end
        end

      end
    end
  end
end
