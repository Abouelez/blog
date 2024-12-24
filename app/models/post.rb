class Post < ApplicationRecord
  after_create :schedule_post_deletion
  belongs_to :user
  has_many :comments

  validates :title, presence: true
  validates :body, presence: true
  validates :tags, presence: true


  def schedule_post_deletion
    DeletePostJob.set(wait: 24.hours).perform_later(self.id)
  end
end
