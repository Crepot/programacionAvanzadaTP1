class CreateJobAdvirtesments < ActiveRecord::Migration[7.0]
  def change
    create_table :job_advirtesments do |t|
      t.belongs_to :company

      t.timestamp :fechaPublicacion
      t.string :details
      t.timestamp :fechaCierre

      t.timestamps
    end
  end
end
