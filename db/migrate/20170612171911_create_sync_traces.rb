class CreateSyncTraces < ActiveRecord::Migration[5.1]
  def change
    create_table :sync_traces do |t|
      t.string :sync_url

      t.timestamps
    end
  end
end
