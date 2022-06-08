class JobAdvirtesment < ApplicationRecord
    has_many :aplications
    has_many :candidates, through: :aplications
    #VALIDATIONS
    #validates :fechaPublicacion,:fechaCierre,:details, presence :true

end
