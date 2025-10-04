class CreateParticipants < ActiveRecord::Migration[7.1]
  def change
    # nao vou usar uuid mas fica pra referencia
    # create_table :participants, id: :uuid do |t|
    create_table :participants do |t|
      t.string :name, limit: 100, null: false
      t.timestamps
    end
  end
end
