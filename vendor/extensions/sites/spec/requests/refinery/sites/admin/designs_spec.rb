# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Sites" do
    describe "Admin" do
      describe "designs" do
        login_refinery_user

        describe "designs list" do
          before(:each) do
            FactoryGirl.create(:design, :scss_model => "UniqueTitleOne")
            FactoryGirl.create(:design, :scss_model => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.sites_admin_designs_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before(:each) do
            visit refinery.sites_admin_designs_path

            click_link "Add New Design"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Scss Model", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Sites::Design.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Scss Model can't be blank")
              Refinery::Sites::Design.count.should == 0
            end
          end

          context "duplicate" do
            before(:each) { FactoryGirl.create(:design, :scss_model => "UniqueTitle") }

            it "should fail" do
              visit refinery.sites_admin_designs_path

              click_link "Add New Design"

              fill_in "Scss Model", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::Sites::Design.count.should == 1
            end
          end

        end

        describe "edit" do
          before(:each) { FactoryGirl.create(:design, :scss_model => "A scss_model") }

          it "should succeed" do
            visit refinery.sites_admin_designs_path

            within ".actions" do
              click_link "Edit this design"
            end

            fill_in "Scss Model", :with => "A different scss_model"
            click_button "Save"

            page.should have_content("'A different scss_model' was successfully updated.")
            page.should have_no_content("A scss_model")
          end
        end

        describe "destroy" do
          before(:each) { FactoryGirl.create(:design, :scss_model => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.sites_admin_designs_path

            click_link "Remove this design forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Sites::Design.count.should == 0
          end
        end

      end
    end
  end
end
