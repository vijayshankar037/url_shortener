require 'rails_helper'

RSpec.describe Url, type: :model do
    subject {
        described_class.new(original_url: "https://github.com/vijayshankar037/url_shortener")
      }

    it "should have many trackings" do
      t = Url.reflect_on_association(:trackings)
      expect(t.macro).to eq(:has_many)
    end

    describe 'validations' do
      it{ is_expected.to validate_presence_of :original_url }
    end
end
