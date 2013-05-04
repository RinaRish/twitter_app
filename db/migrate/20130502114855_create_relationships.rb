class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :following_id
      t.integer :followers_id

      t.timestamps
    end

    add_index :relationships, :following_id
    add_index :relationships, :followers_id
    add_index :relationships, [:following_id, :followers_id], unique: true
  end
end
