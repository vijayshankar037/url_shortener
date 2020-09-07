module Shorten
  module Url
      extend ActiveSupport::Concern

      included do
        UNIQUE_ID_LENGTH = 5
        URL_REGEXP = /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/ix

        has_many :trackings

        validates :original_url, presence: true, on: :create

        validates :original_url, format: {
          multiline: true,
          with: URL_REGEXP,
          message: 'You provided invalid URL'
        }
        validates_uniqueness_of :sanitize_url

        before_create :generate_short_url, :sanitize, :set_expiry
      end

      def new_url?
        find_duplicate.nil?
      end

      def sanitize
        self.original_url.strip!
        self.sanitize_url = self.original_url.downcase.gsub(/(https?:\/\/)|(www\.)/,"")
        self.sanitize_url = "http://#{self.sanitize_url}"
      end
      
      def set_expiry
        self.expiration = Time.now.next_month
      end

      def remaining_days
        expired? ? 0 : ((self.expiration.to_time - Time.now)/1.day).to_i
      end

      def expired?
        (self.expiration.to_time - Time.now)/1.day <= 0
      end

  end
end
