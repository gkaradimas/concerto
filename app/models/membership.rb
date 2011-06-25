class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  #Validations
  validates :user, :presence => true, :associated => true
  validates :group, :presence => true, :associated => true
  validates_uniqueness_of :user_id, :scope => :group_id
  
  before_save :check_writable, :check_admins
  
  def check_writable
    if self.group.memberships.count != 0 and !self.group.is_writable?
      raise Group::PermissionDenied
    end
  end
  
  def check_admins
    
  end
end
