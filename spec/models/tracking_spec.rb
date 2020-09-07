require 'rails_helper'

RSpec.describe Tracking, type: :model do

  describe "Associations" do
    it { should belong_to(:url) }
  end
  
end
