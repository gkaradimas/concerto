class PrivateFeedsAndSuch < ActiveRecord::Migration
  def up
    change_table :feeds do |t|
      t.remove :public
      t.remove :read_ony
      t.boolean :is_viewable, :default => 1, :null => false
      t.boolean :is_submittable, :default => 1, :null => false
    end
  end

  def down
    change_table :feeds do |t|
      t.boolean :public
      t.boolean :read_only
      t.remove :is_viewable
      t.remove is_submittable
    end  
  end
end
