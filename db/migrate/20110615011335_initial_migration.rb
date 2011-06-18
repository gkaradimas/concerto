class InitialMigration < ActiveRecord::Migration
  def self.up
    drop_table :contents
    
    create_table :contents do |t|
      t.string :name, :null => false
      t.string :type, :null => false
      t.integer :duration, :null => false
      t.references :user, :null => false
      t.boolean :public, :default => 1, :null => false
      t.datetime :start_time, :null => true
      t.datetime :end_time, :null => true
      t.timestamps
    end
    
    add_index :contents, :name
    add_index :contents, :type
    add_index :contents, :user_id
    add_index :contents, :public
    add_index :contents, :start_time
    add_index :contents, :end_time
    
    drop_table :feeds
    
    create_table :feeds do |t|
      t.string :name, :null => false
      t.text :description
      t.references :group, :null => false
      t.boolean :read_only, :default => 0, :null => false
      t.boolean :public, :default => 1, :null => false
      t.timestamps
    end
    
    add_index :feeds, :name
    add_index :feeds, :group_id
    add_index :feeds, :read_only
    add_index :feeds, :public
    
    drop_table :groups
    
    create_table :groups do |t|
      t.string :name, :null => false
      t.boolean :public, :default => 1, :null => false
      t.timestamps
    end
    
    add_index :groups, :name
    add_index :groups, :public
    
    drop_table :memberships
    
    create_table :memberships do |t|
      t.references :user, :null => false
      t.references :group, :null => false
      t.boolean :admin, :default => 0, :null => false
      t.boolean :moderator, :default => 0, :null => false
    end
    
    add_index :memberships, :user_id
    add_index :memberships, :group_id
    add_index :memberships, :admin
    add_index :memberships, :moderator
    
    drop_table :submissions
    
    create_table :submissions do |t|
      t.references :content, :null => false
      t.references :feed, :null => false
      t.integer :duration, :null => false
      t.boolean :moderation_flag, :default => 0, :null => true
      t.references :moderator, :null => true
      t.timestamps
    end
    
    add_index :submissions, :content_id
    add_index :submissions, :feed_id
    add_index :submissions, :moderation_flag
    add_index :submissions, :moderator_id
    
    drop_table :users
    
    create_table :users do |t|
      t.string :username, :null => false
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.string :email, :null => false
      t.boolean :super_user, :default => 0, :null => false
      t.timestamps
    end
    
    add_index :users, :username, :unique => true
    add_index :users, :super_user
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
