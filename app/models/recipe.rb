class Recipe < ApplicationRecord
  belongs_to :user

  has_many :recipe_foods, foreign_key: :recipe_id, dependent: :delete_all

  validates :name, presence: true, length: { maximum: 250 }
  validates :description, presence: true
  validates :preparation_time, presence: true
  validates :cooking_time, presence: true
end
