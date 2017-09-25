class AddIntegrationAlertToCanary < ActiveRecord::Migration[5.0]
  def change
    add_reference :canaries, :alert_integration, foreign_key: false, null: true
  end
end
