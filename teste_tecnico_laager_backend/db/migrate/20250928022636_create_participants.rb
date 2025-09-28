class CreateParticipants < ActiveRecord::Migration[7.1]
  def change
    # nao vou usar uuid mas fica pra referencia
    # create_table :participants, id: :uuid do |t|
    create_table :participants, id: false do |t|
      t.bigint :id, primary_key: true
      t.string :name, limit: 100, null: false
      t.bigint :total_votes, default: 0, null: true
      t.timestamps
    end
  end
end
