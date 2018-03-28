class Comment < ApplicationRecord
  validates_presence_of :content
  belongs_to :job

  def time_format
    self.created_at.strftime("%b %d, %Y %k:%M %P")
  end
end
