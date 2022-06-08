class Candidate < ApplicationRecord
    has_many :aplications
    has_many :jobAdvirtesments, through: :aplications
    # VALIDATIONS
    #validates :candidateName, :candidateLastName, :birthdate, :emial, presence :true
end
