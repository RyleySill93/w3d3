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

  has_many :visits,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: :Visit

  has_many :visitors,
    through: :visits,
    source: :user

  has_many :unique_visitors,
    Proc.new {distinct},
    through: :visits,
    source: :user

  def self.random_code
    random_number = SecureRandom.urlsafe_base64
    while ShortenedUrl.exists?(short_url: random_number)
      random_number = SecureRandom.urlsafe_base64
    end
    random_number
  end

  def self.record_url(user, long_url)
    ShortenedUrl.create!(
    long_url: long_url,
    short_url: ShortenedUrl.random_code,
    user_id: user.id)
  end

  def num_clicks
    visits.count
  end

  def num_uniques
    unique_visitors.count
  end

  def num_recent_uniques
    visits.select('user_id').distinct.where("created_at > ?", 120.minutes.ago).count
  end

end
