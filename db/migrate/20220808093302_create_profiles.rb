class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.string :name, null: false
      t.string :phone
      t.string :group, null:false
      t.references :user, foreign_key: true, null: false
      t.timestamps
    end
  end
end
