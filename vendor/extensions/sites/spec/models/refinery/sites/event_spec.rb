require 'spec_helper'

module Refinery
  module Sites
    describe Event do
      describe "validations" do
        subject do
          FactoryGirl.create(:event,
          :event_title => "Refinery CMS")
        end

        it { should be_valid }
        its(:errors) { should be_empty }

        its(:event_title) { should == "Refinery CMS" }

      end
    end
  end
end
