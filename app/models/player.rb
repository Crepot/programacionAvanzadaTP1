class Player < ApplicationRecord
    has_many :tablePlayers, dependent: :destroy
    has_many :tables, through: :tablePlayers
    
    # Validations
    before_create :default_values # Por defecto al crear un player lo inicializamos sin symbol y con sessionActive en false para que se logee
    def default_values
        self.tokenAuth =''
        self.symbol = ''
        self.sessionActive = false
        self.score = 0
    end

    validates :name,:email, presence:true

    has_secure_password
end
