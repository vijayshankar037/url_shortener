class Url < ApplicationRecord
  include Shorten::Url


        def total_count
           self.trackings.count
        end

        def top_countries
          self.trackings.select(:country).group(:country).order(count: :desc).limit(3).pluck(:country).reject(&:empty?)
        end

        def generate_short_url
          url = ([*('a'..'z'),*('0'..'9')]).sample(UNIQUE_ID_LENGTH).join
          old_url = Url.where(short_url: url).last

          if old_url.present?
            self.generate_short_url
          else
            self.short_url = url
          end
        end

        #Check duplicate url
        def find_duplicate
          Url.find_by_sanitize_url(self.sanitize_url)
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
