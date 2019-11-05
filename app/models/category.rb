class Category < ApplicationRecord
    validates :title, presence: true
    validates :color, presence: true
    belongs_to :user
    has_many :tasks
end
