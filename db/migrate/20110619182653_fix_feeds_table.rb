class FixFeedsTable < ActiveRecord::Migration
  def up
    remove_column :feeds, :parent_id
    change_table :feeds do |t|
      t.boolean :read_only, :default => 0, :null => false
      t.boolean :public, :default => 1, :null => false 
      t.index :name
      t.index :group_id
      t.index :read_only
      t.index :public
    end  
  end

  def down
    add_column :feeds, :parent_id, :integer
    remove_column :feeds, :read_only
    remove_column :feeds, :public
    remove_index :name
    remove_index :group_id
    remove_index :read_only
    remove_index :public
  end
end
