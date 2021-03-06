# == Schema Information
#
# Table name: taggings
#
#  id       :integer          not null, primary key
#  topic_id :integer          not null
#  url_id   :integer          not null
#

class Tagging < ActiveRecord::Base
  validates :topic_id, :url_id, presence: true

  belongs_to :topic,
    primary_key: :id,
    foreign_key: :topic_id,
    class_name: :TagTopic

  belongs_to :url,
    primary_key: :id,
    foreign_key: :url_id,
    class_name: :ShortenedUrl

  
end
