class AddIndexOnUuidToCanaries < ActiveRecord::Migration[5.0]
  def change
    add_index :canaries, :uuid, unique: true
  end
end
