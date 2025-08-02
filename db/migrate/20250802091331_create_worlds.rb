class CreateWorlds < ActiveRecord::Migration[7.2]
  def change
    create_table :worlds do |t|
      t.string :name, null: false
      t.string :launch_url
      t.text :descroption

      t.timestamps
    end
  end
end
