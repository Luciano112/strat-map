# frozen_string_literal: true

# Column collection model
class Collection < ApplicationRecord
  has_many :column_collections, dependent: :destroy
  has_many :strat_columns, through: :column_collections
  belongs_to :user

  validates :name, presence: true
end
