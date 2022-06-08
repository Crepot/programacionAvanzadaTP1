class Position < ApplicationRecord
    has_many :tablePositions, dependent: :destroy
    has_many :tables, through: :tablePositions

    before_create :default_values # Por defecto al crear una instancia de posiciones las inicializamos en 0 a todas
    def default_values
        self.box0 = 0
        self.box1 = 0
        self.box2 = 0
        self.box3 = 0
        self.box4 = 0
        self.box5 = 0
        self.box6 = 0
        self.box7 = 0
        self.box8 = 0
    end
end
