class CreateCandidates < ActiveRecord::Migration[7.0]
  def change
    create_table :candidates do |t|
      t.string :candidateName
      t.string :candidateLastName
      t.timestamp :birthdate
      t.string :emial
      t.timestamps
    end
  end
end
