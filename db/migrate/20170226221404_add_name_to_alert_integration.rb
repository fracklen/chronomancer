class AddNameToAlertIntegration < ActiveRecord::Migration[5.0]
  def change
    add_column :alert_integrations, :name, :string
  end
end
