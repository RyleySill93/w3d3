# == Schema Information
#
# Table name: shortened_urls
#
#  id         :integer          not null, primary key
#  short_url  :string           not null
#  created_at :datetime
#  updated_at :datetime
#  long_url   :string           not null
#  user_id    :integer          not null
#

class ShortenedUrl < ActiveRecord::Base
  validates :short_url, :long_url, presence: true, uniqueness: true
  validates :user_id, presence: true

  belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  def self.random_code
    random_number = SecureRandom.urlsafe_base64
    while ShortenedUrl.exists?(short_url: random_number)
      random_number = SecureRandom.urlsafe_base64
    end
    random_number
  end

  def self.create!(user, long_url)
    ShortenedUrl.new(
    long_url: long_url,
    short_url: ShortenedUrl.random_code,
    user_id: user.id)
  end

end
