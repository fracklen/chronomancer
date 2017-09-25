class AddLastCheckinToCanary < ActiveRecord::Migration[5.0]
  def change
    add_column :canaries, :last_checkin, :timestamp, null: true
    add_column :canaries, :next_checkin, :timestamp
  end
end
