class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :title, null:false
      t.string :category, null:false
      t.string :url
      t.date :deadline, null:false
      t.timestamps
    end
  end
end
