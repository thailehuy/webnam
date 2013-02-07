require 'spec_helper'

module Refinery
  module Sites
    describe GoogleCalendar do
      describe "validations" do
        subject do
          FactoryGirl.create(:google_calendar,
          :account => "Refinery CMS")
        end

        it { should be_valid }
        its(:errors) { should be_empty }

        its(:account) { should == "Refinery CMS" }

      end
    end
  end
end
