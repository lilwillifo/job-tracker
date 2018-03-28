# app/models/contact.rb
class Contact < ApplicationRecord
  validates :name, presence: true
  validates :role, presence: true
  validates :email, presence: true
  belongs_to :company
end
