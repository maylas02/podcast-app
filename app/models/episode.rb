class Episode < ApplicationRecord
    # Change the belongs_to relationship to just validate the presence of podcast_id
  belongs_to :user
end