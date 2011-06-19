class FixFeedsTable < ActiveRecord::Migration
  def up
    remove_column :feeds, :parent_id
    change_table :feeds do |t|
      t.boolean :is_read_only, :default => 0, :null => false
      t.boolean :_ispublic, :default => 1, :null => false 
      t.index :name
      t.index :group_id
      t.index :is_read_only
      t.index :is_public
    end  
  end

  def down
    add_column :feeds, :parent_id, :integer
    remove_column :feeds, :is_read_only
    remove_column :feeds, :is_public
    remove_index :name
    remove_index :group_id
    remove_index :is_read_only
    remove_index :is_public
  end
end
