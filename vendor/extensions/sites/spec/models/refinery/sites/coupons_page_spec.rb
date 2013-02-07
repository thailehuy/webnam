require 'spec_helper'

module Refinery
  module Sites
    describe CouponsPage do
      describe "validations" do
        subject do
          FactoryGirl.create(:coupons_page)
        end

        it { should be_valid }
        its(:errors) { should be_empty }

      end
    end
  end
end
