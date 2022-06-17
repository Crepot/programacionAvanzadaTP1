class Position < ApplicationRecord
    has_many :tablePositions, dependent: :destroy
    has_many :tables, through: :tablePositions
    #ME PUEDO GUARDAR SOLAMENTE números de jugadas
    before_create :default_values # Por defecto al crear una instancia de posiciones las inicializamos en 0 a todas
    def default_values
        self.box = 0
    end
end
