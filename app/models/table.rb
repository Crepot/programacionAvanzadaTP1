class Table < ApplicationRecord
    has_many :tablePlayers, dependent: :destroy
    has_many :players, through: :tablePlayers

    has_many :tablePositions, dependent: :destroy
    has_many :positions, through: :tablePositions

    # Estados del tablero:

    enum statusGame: {finalizado:3 ,'En curso':2 ,buscando:1 ,creado:0} #De esta forma yo le puedo poner el número que quiera

    before_create :default_values # Por defecto al crear un table lo inicializamos con los valores por defecto
    def default_values
        self.winner = -1
        self.moveNumber = 0
        self.statusGame = 0
    end

end
