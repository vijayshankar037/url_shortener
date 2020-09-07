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

      




end
