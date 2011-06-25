class Membership < ActiveRecord::Base
  class PermissionDenied < StandardError; end

  belongs_to :user
  belongs_to :group

  #Validations
  validates :user, :presence => true, :associated => true
  validates :group, :presence => true, :associated => true
  validates_uniqueness_of :user_id, :scope => :group_id
  
  before_save :check_writable, :check_admins
  after_find :check_readable

  def is_readable?
    accessor = User.accessor
    accessor.is_super_user? or self.group.is_member?(accessor)
  end

  def is_writable?
    self.group.memberships.count == 0 or self.group.is_writable?
  end

  def check_readable
    if !self.is_readable?
      raise Membership::PermissionDenied
    end
  end

  def check_writable
    if !self.is_writable?
      raise Membership::PermissionDenied
    end
  end
  
  def check_admins
    
  end
end
