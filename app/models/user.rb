class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :validatable

  # Setup accessible (or protected) attributes for your model
  #attr_accessible :email, :password, :password_confirmation, :remember_me, :first_name, :last_name

  has_many :contents
  has_many :submissions, :foreign_key => :moderator_id
  has_many :memberships, :dependent => :destroy
  has_many :groups, :through => :memberships

  #Validations
  validates :email, :presence => true, :uniqueness => true
  validates :first_name, :presence => true
  validates :last_name, :presence => true

  #before_update :check_writable

  # A simple name, combining the first and last name
  # We should probably expand this so it doesn't look stupid
  # if people only have a first name or only have a last name
  def name
    (first_name || "") + " " + (last_name || "")
  end

  def is_guest?
    self.id == nil
  end

  # Quickly test if a user belongs to a group (this breaks if either is nil)
  def in_group?(group)
    groups.include?(group)
  end

  #check if the parameter user can write to this user object
  def is_writable?
    accessor = User.accessor
    self == accessor or accessor.is_super_user?
  end

  #check if the parameter user can read this user object
  def is_readable?
    self.is_writable?
  end

  #def in_group?(group)
  #  group.is_member?(self)
  #end
  
  def self.accessor
    Thread.current[:accessor]
  end
  
  #used to fetch the current user (accessor) in models
  def self.accessor=(user)
    Thread.current[:accessor] = user
  end   
end
