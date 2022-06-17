class Position < ApplicationRecord
    has_many :tablePositions, dependent: :destroy
    has_many :tables, through: :tablePositions
    #ME PUEDO GUARDAR SOLAMENTE números de jugadas
end
