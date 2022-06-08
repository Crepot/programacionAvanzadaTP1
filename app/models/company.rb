class Company < ApplicationRecord
    has_many :jobAdvirtesments
    
    # VALIDATIONS
    validates :companyName, presence :true
end
