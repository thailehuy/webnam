# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "Sites" do
    describe "Admin" do
      describe "aboutus_pages" do
        login_refinery_user

        describe "aboutus_pages list" do
          before(:each) do
            FactoryGirl.create(:aboutus_page, :category => "UniqueTitleOne")
            FactoryGirl.create(:aboutus_page, :category => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.sites_admin_aboutus_pages_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before(:each) do
            visit refinery.sites_admin_aboutus_pages_path

            click_link "Add New Aboutus Page"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Category", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::Sites::AboutusPage.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Category can't be blank")
              Refinery::Sites::AboutusPage.count.should == 0
            end
          end

          context "duplicate" do
            before(:each) { FactoryGirl.create(:aboutus_page, :category => "UniqueTitle") }

            it "should fail" do
              visit refinery.sites_admin_aboutus_pages_path

              click_link "Add New Aboutus Page"

              fill_in "Category", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::Sites::AboutusPage.count.should == 1
            end
          end

          context "with translations" do
            before(:each) do
              Refinery::I18n.stub(:frontend_locales).and_return([:en, :cs])
            end

            describe "add a page with title for default locale" do
              before do
                visit refinery.sites_admin_aboutus_pages_path
                click_link "Add New Aboutus Page"
                fill_in "Category", :with => "First column"
                click_button "Save"
              end

              it "should succeed" do
                Refinery::Sites::AboutusPage.count.should == 1
              end

              it "should show locale flag for page" do
                p = Refinery::Sites::AboutusPage.last
                within "#aboutus_page_#{p.id}" do
                  page.should have_css("img[src='/assets/refinery/icons/flags/en.png']")
                end
              end

              it "should show category in the admin menu" do
                p = Refinery::Sites::AboutusPage.last
                within "#aboutus_page_#{p.id}" do
                  page.should have_content('First column')
                end
              end
            end

            describe "add a aboutus_page with title for primary and secondary locale" do
              before do
                visit refinery.sites_admin_aboutus_pages_path
                click_link "Add New Aboutus Page"
                fill_in "Category", :with => "First column"
                click_button "Save"

                visit refinery.sites_admin_aboutus_pages_path
                within ".actions" do
                  click_link "Edit this aboutus_page"
                end
                within "#switch_locale_picker" do
                  click_link "Cs"
                end
                fill_in "Category", :with => "First translated column"
                click_button "Save"
              end

              it "should succeed" do
                Refinery::Sites::AboutusPage.count.should == 1
                Refinery::Sites::AboutusPage::Translation.count.should == 2
              end

              it "should show locale flag for page" do
                p = Refinery::Sites::AboutusPage.last
                within "#aboutus_page_#{p.id}" do
                  page.should have_css("img[src='/assets/refinery/icons/flags/en.png']")
                  page.should have_css("img[src='/assets/refinery/icons/flags/cs.png']")
                end
              end

              it "should show category in backend locale in the admin menu" do
                p = Refinery::Sites::AboutusPage.last
                within "#aboutus_page_#{p.id}" do
                  page.should have_content('First column')
                end
              end
            end

            describe "add a category with title only for secondary locale" do
              before do
                visit refinery.sites_admin_aboutus_pages_path
                click_link "Add New Aboutus Page"
                within "#switch_locale_picker" do
                  click_link "Cs"
                end

                fill_in "Category", :with => "First translated column"
                click_button "Save"
              end

              it "should show title in backend locale in the admin menu" do
                p = Refinery::Sites::AboutusPage.last
                within "#aboutus_page_#{p.id}" do
                  page.should have_content('First translated column')
                end
              end

              it "should show locale flag for page" do
                p = Refinery::Sites::AboutusPage.last
                within "#aboutus_page_#{p.id}" do
                  page.should have_css("img[src='/assets/refinery/icons/flags/cs.png']")
                end
              end
            end
          end

        end

        describe "edit" do
          before(:each) { FactoryGirl.create(:aboutus_page, :category => "A category") }

          it "should succeed" do
            visit refinery.sites_admin_aboutus_pages_path

            within ".actions" do
              click_link "Edit this aboutus page"
            end

            fill_in "Category", :with => "A different category"
            click_button "Save"

            page.should have_content("'A different category' was successfully updated.")
            page.should have_no_content("A category")
          end
        end

        describe "destroy" do
          before(:each) { FactoryGirl.create(:aboutus_page, :category => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.sites_admin_aboutus_pages_path

            click_link "Remove this aboutus page forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::Sites::AboutusPage.count.should == 0
          end
        end

      end
    end
  end
end
