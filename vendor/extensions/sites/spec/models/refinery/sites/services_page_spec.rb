require 'spec_helper'

module Refinery
  module Sites
    describe ServicesPage do
      describe "validations" do
        subject do
          FactoryGirl.create(:services_page)
        end

        it { should be_valid }
        its(:errors) { should be_empty }

      end
    end
  end
end
