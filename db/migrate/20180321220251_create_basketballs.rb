class CreateBasketballs < ActiveRecord::Migration[5.1]
  def change
    create_table :basketballs do |t|
      t.integer :cbs_id
      t.string :first_name
      t.string :last_name
      t.string :name_brief
      t.string :position
      t.integer :age
    end

    add_index :basketballs, :cbs_id, unique: true
  end
end
