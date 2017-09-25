class CreateCanaries < ActiveRecord::Migration[5.0]
  def change
    create_table :canaries do |t|
      t.string :name
      t.string :schedule
      t.references :team, foreign_key: true
      t.text :comment
      t.string :uuid
      t.references :created_by, foreign_key: true, foreign_key: {to_table: :users }

      t.timestamps
    end
  end
end
