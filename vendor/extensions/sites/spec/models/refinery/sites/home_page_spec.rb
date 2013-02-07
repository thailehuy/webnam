require 'spec_helper'

module Refinery
  module Sites
    describe HomePage do
      describe "validations" do
        subject do
          FactoryGirl.create(:home_page)
        end

        it { should be_valid }
        its(:errors) { should be_empty }
      end
    end
  end
end
