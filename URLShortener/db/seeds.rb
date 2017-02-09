# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
ActiveRecord::Base.transaction do
  User.destroy_all
  user1 = User.create(email: 'ryley@gmail.com')
  user2 = User.create(email: 'fernanda@gmail.com')

  TagTopic.destroy_all
  topic1 = TagTopic.create(topic: 'sports')
  topic2 = TagTopic.create(topic: 'music')
  topic3 = TagTopic.create(topic: 'food')

  ShortenedUrl.destroy_all
  url1 = ShortenedUrl.record_url!(user1, "www.espn.com")
  url2 = ShortenedUrl.record_url!(user2, "www.food.com")
  url3 = ShortenedUrl.record_url!(user1, "www.musicandfood.com")
  url4 = ShortenedUrl.record_url!(user1, "www.nba.com")

  Tagging.destroy_all
  tag1 = Tagging.create(topic_id: topic1.id, url_id: url1.id)
  tag2 = Tagging.create(topic_id: topic3.id, url_id: url2.id)
  tag3 = Tagging.create(topic_id: topic2.id, url_id: url3.id)
  tag4 = Tagging.create(topic_id: topic3.id, url_id: url3.id)
  tag5 = Tagging.create(topic_id: topic1.id, url_id: url4.id)

end
