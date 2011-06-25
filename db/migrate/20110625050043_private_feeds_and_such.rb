class PrivateFeedsAndSuch < ActiveRecord::Migration
  def up
    change_table :feeds do |t|
      t.remove :is_public
      t.remove :is_read_only
      t.boolean :is_viewable, :default => 1, :null => false
      t.boolean :is_submittable, :default => 1, :null => false
    end
  end

  def down
    change_table :feeds do |t|
      t.boolean :is_public
      t.boolean :is_read_only
      t.remove :is_viewable
      t.remove is_submittable
    end  
  end
end
