require 'spec_helper'

module Refinery
  module Sites
    describe Coupon do
      describe "validations" do
        subject do
          FactoryGirl.create(:coupon)
        end

        it { should be_valid }
        its(:errors) { should be_empty }

      end
    end
  end
end
