class Task < ApplicationRecord
    validates :title, presence: true
    validates :is_done, presence: { if: lambda { is_done.nil? } }
    belongs_to :user
    belongs_to :category, optional: true
    has_many :tag_associations, dependent: :delete_all
    has_many :tags, through: :tag_associations
end
