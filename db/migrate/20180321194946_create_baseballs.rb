class CreateBaseballs < ActiveRecord::Migration[5.1]
  def change
    create_table :baseballs do |t|
      t.integer :cbs_id
      t.string :first_name
      t.string :last_name
      t.string :name_brief
      t.string :position
      t.integer :age

      t.timestamps
    end

    add_index :baseballs, :cbs_id, unique: true
  end
end
