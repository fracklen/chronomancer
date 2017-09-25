class CreateAlertIntegrations < ActiveRecord::Migration[5.0]
  def change
    create_table :alert_integrations do |t|
      t.references :team, foreign_key: true
      t.string :kind
      t.text :data

      t.timestamps
    end
  end
end
