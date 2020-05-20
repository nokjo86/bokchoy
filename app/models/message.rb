class Message < ApplicationRecord
  belongs_to :sender, class_name: 'Profile', foreign_key: 'sender_id'
  belongs_to :recipient, class_name: 'Profile', foreign_key: 'recipient_id'
  belongs_to :listing, optional: true
  has_many :attached_messages, class_name: "Message", foreign_key: "thread_id"
  belongs_to :thread, class_name: "Message", optional: true
  validates :body, presence: true, length: { in: 3..500 }
end
