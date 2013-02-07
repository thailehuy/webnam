# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Sites" do
    describe "Admin" do
      describe "events" do
        login_refinery_user

        describe "events list" do
          before(:each) do
            FactoryGirl.create(:event, :event_title => "UniqueTitleOne")
            FactoryGirl.create(:event, :event_title => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.sites_admin_events_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before(:each) do
            visit refinery.sites_admin_events_path

            click_link "Add New Event"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Event Title", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Sites::Event.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Event Title can't be blank")
              Refinery::Sites::Event.count.should == 0
            end
          end

          context "duplicate" do
            before(:each) { FactoryGirl.create(:event, :event_title => "UniqueTitle") }

            it "should fail" do
              visit refinery.sites_admin_events_path

              click_link "Add New Event"

              fill_in "Event Title", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::Sites::Event.count.should == 1
            end
          end

          context "with translations" do
            before(:each) do
              Refinery::I18n.stub(:frontend_locales).and_return([:en, :cs])
            end

            describe "add a page with title for default locale" do
              before do
                visit refinery.sites_admin_events_path
                click_link "Add New Event"
                fill_in "Event Title", :with => "First column"
                click_button "Save"
              end

              it "should succeed" do
                Refinery::Sites::Event.count.should == 1
              end

              it "should show locale flag for page" do
                p = Refinery::Sites::Event.last
                within "#event_#{p.id}" do
                  page.should have_css("img[src='/assets/refinery/icons/flags/en.png']")
                end
              end

              it "should show event_title in the admin menu" do
                p = Refinery::Sites::Event.last
                within "#event_#{p.id}" do
                  page.should have_content('First column')
                end
              end
            end

            describe "add a event with title for primary and secondary locale" do
              before do
                visit refinery.sites_admin_events_path
                click_link "Add New Event"
                fill_in "Event Title", :with => "First column"
                click_button "Save"

                visit refinery.sites_admin_events_path
                within ".actions" do
                  click_link "Edit this event"
                end
                within "#switch_locale_picker" do
                  click_link "Cs"
                end
                fill_in "Event Title", :with => "First translated column"
                click_button "Save"
              end

              it "should succeed" do
                Refinery::Sites::Event.count.should == 1
                Refinery::Sites::Event::Translation.count.should == 2
              end

              it "should show locale flag for page" do
                p = Refinery::Sites::Event.last
                within "#event_#{p.id}" do
                  page.should have_css("img[src='/assets/refinery/icons/flags/en.png']")
                  page.should have_css("img[src='/assets/refinery/icons/flags/cs.png']")
                end
              end

              it "should show event_title in backend locale in the admin menu" do
                p = Refinery::Sites::Event.last
                within "#event_#{p.id}" do
                  page.should have_content('First column')
                end
              end
            end

            describe "add a event_title with title only for secondary locale" do
              before do
                visit refinery.sites_admin_events_path
                click_link "Add New Event"
                within "#switch_locale_picker" do
                  click_link "Cs"
                end

                fill_in "Event Title", :with => "First translated column"
                click_button "Save"
              end

              it "should show title in backend locale in the admin menu" do
                p = Refinery::Sites::Event.last
                within "#event_#{p.id}" do
                  page.should have_content('First translated column')
                end
              end

              it "should show locale flag for page" do
                p = Refinery::Sites::Event.last
                within "#event_#{p.id}" do
                  page.should have_css("img[src='/assets/refinery/icons/flags/cs.png']")
                end
              end
            end
          end

        end

        describe "edit" do
          before(:each) { FactoryGirl.create(:event, :event_title => "A event_title") }

          it "should succeed" do
            visit refinery.sites_admin_events_path

            within ".actions" do
              click_link "Edit this event"
            end

            fill_in "Event Title", :with => "A different event_title"
            click_button "Save"

            page.should have_content("'A different event_title' was successfully updated.")
            page.should have_no_content("A event_title")
          end
        end

        describe "destroy" do
          before(:each) { FactoryGirl.create(:event, :event_title => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.sites_admin_events_path

            click_link "Remove this event forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Sites::Event.count.should == 0
          end
        end

      end
    end
  end
end
