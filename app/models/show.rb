class Show < ApplicationRecord
    has_many :reviews, dependent: :destroy
end