class Aplication < ApplicationRecord
    belongs_to :candidate
    belongs_to :jobAdvirtesment
    # VALIDATIONS
    # validates :status, :fechaAplicacion,presence :true

    # Estados de las aplicaciones a los trabajos
    enum state: {contratado:3 ,interesa:2 ,rechazado:1 ,pendiente:0} #De esta forma yo le puedo poner el número que quiera
end
