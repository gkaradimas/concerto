class FixBooleanConvention < ActiveRecord::Migration
  def up
    rename_column :contents, :public, :is_public
    rename_column :groups, :public, :is_public
    rename_column :memberships, :admin, :is_admin
    rename_column :memberships, :moderator, :is_moderator
    rename_column :submissions, :moderation_flag, :is_moderated
    rename_column :users, :super_user, :is_super_user
  end

  def down
    rename_column :contents, :is_public, :public
    rename_column :groups, :is_public, :public
    rename_column :memberships, :is_admin, :admin
    rename_column :memberships, :is_moderator, :moderator
    rename_column :submissions, :is_moderated, :moderation_flag
    rename_column :users, :is_super_user, :super_user  
  end
end
