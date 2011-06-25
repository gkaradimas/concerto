class Group < ActiveRecord::Base
  class PermissionDenied < StandardError; end
  class GuestUser < StandardError; end
  
  has_many :feeds
  has_many :memberships, :dependent => :destroy
  has_many :users, :through => :memberships
  
  before_update :check_writable
  before_create :check_guest_user
  after_create :add_initial_user
  after_find :check_readable

  #Validations
  validates :name, :presence => true, :uniqueness => true
  
  #Test if a member is part of this group
  def is_member?(user)
    self.memberships.where(:user_id => user.id).exists?
  end

  def is_admin?(user)
     self.memberships.where(:user_id => user.id, :is_admin => true).exists?
  end

  def is_moderator?(user)
    self.is_admin?(user) or self.memberships.where(:user_id => user.id, :is_moderator => true).exists?
  end

  def is_readable?
    true
  end

  def is_writable?
    accessor = User.accessor
    accessor.is_super_user? or self.is_admin?(accessor)
  end

  def check_readable
    if !self.is_readable?
      raise Group::PermissionDenied
    end
  end

  def check_writable
    if !self.is_writable?
      raise Group::PermissionDenied
    end
  end

  def check_guest_user
    if User.accessor.is_guest?
      raise Group::GuestUser
    end
  end

  def add_initial_user
    Membership.new(:group => self, :user => User.accessor, :is_admin => true).save!
  end

  def self.bang
    puts "BANG!  I am fucking Emeril!"
  end
end
