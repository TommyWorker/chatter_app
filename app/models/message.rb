class Message < ApplicationRecord

    belongs_to :User, optional: true, foreign_key:'user_id'

end
