class TomIndicesFields < ActiveRecord::Migration
  def up
    change_column :contents, :name, :string, :null => false
    change_column :contents, :type, :string, :null => false
    change_column :contents, :duration, :integer, :null => false
    change_column :contents, :user_id, :integer, :null => false
    change_column :contents, :start_time, :datetime, :null => true
    change_column :contents, :end_time, :datetime, :null => true     
    change_table :contents do |t|
      t.boolean :public, :default => 1, :null => false
      t.remove :kind_id
      t.index :name
      t.index :type
      t.index :user_id
      t.index :public
      t.index :start_time
      t.index :end_time      
    end    
      
   change_column :groups, :name, :string, :null => false
   change_table :groups do |t|
      t.boolean :public, :default => 1, :null => false 
      t.index :name
      t.index :public 
   end
   
   change_column :memberships, :user_id, :integer, :null => false
   change_column :memberships, :group_id, :integer, :null => false
   change_table :memberships do |t|
      t.boolean :admin, :default => 0, :null => false
      t.boolean :moderator, :default => 0, :null => false   
      t.remove :is_leader
      t.index :user_id
      t.index :group_id
      t.index :admin
      t.index :moderator      
   end
   
   change_column :submissions, :content_id, :integer, :null => false
   change_column :submissions, :feed_id, :integer, :null => false
   change_column :submissions, :duration, :integer, :null => false
   change_column :submissions, :moderation_flag, :boolean, :null => false
   change_column :submissions, :moderator_id, :integer, :null => true
   change_column_default :submissions, :moderation_flag, 0
   change_table :submissions do |t|
      t.index :content_id
      t.index :feed_id
      t.index :moderation_flag
      t.index :moderator_id
    end
    
  change_table :users do |t|
    t.boolean :super_user, :default => 0, :null => false
    t.index :super_user
  end
  
  end

  def down
  end
end
