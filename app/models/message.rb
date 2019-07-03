class Message < ApplicationRecord

    belongs_to :User, optional: true

end
