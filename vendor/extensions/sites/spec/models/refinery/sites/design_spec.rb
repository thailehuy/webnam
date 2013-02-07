require 'spec_helper'

module Refinery
  module Sites
    describe Design do
      describe "validations" do
        subject do
          FactoryGirl.create(:design,
          :scss_model => "Refinery CMS")
        end

        it { should be_valid }
        its(:errors) { should be_empty }
        its(:scss_model) { should == "Refinery CMS" }
      end
    end
  end
end
