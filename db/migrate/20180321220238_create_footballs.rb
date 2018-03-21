class CreateFootballs < ActiveRecord::Migration[5.1]
  def change
    create_table :footballs do |t|
      t.integer :cbs_id
      t.string :first_name
      t.string :last_name
      t.string :name_brief
      t.string :position
      t.integer :age
    end

    add_index :footballs, :cbs_id, unique: true
  end
end
