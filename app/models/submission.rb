class Submission < ActiveRecord::Base
  class PermissionDenied < StandardError; end

  belongs_to :content
  belongs_to :feed
  belongs_to :moderator, :class_name => "User"
  
  #Validations
  validates :feed, :presence => true, :associated => true
  validates :content, :presence => true, :associated => true
  validates :moderator, :presence => { :unless => :is_pending? }, :associated => true
  validates :duration, :numericality => { :greater_than => 0 }
  validates_uniqueness_of :content_id, :scope => :feed_id  #Enforce content can only be submitted to a feed once

  #Scoping shortcuts for active/denied/pending
  scope :approved, where(:moderation_flag => true)
  scope :denied, where(:moderation_flag => false)
  scope :pending, where(:moderation_flag => nil)

  after_find :check_readable
  before_save :check_writable

  def is_readable?
    if self.is_approved?
      self.feed.is_viewable? or self.feed.is_member?(User.accessor)
    else
      self.feed.is_moderator?(User.accessor)
    end
  end

  def is_writable?
    self.feed.is_moderator?(User.accessor)
  end

  def check_readable
    if !self.is_readable?
      raise Submission::PermissionDenied
    end
  end

  def check_writable
    if !self.is_writable?
      raise Submission::PermissionDenied
    end
  end  
  
  # Test if the submission has been approved.
  # (moderation flag is true)
  def is_approved?
    self.moderation_flag == true
  end
  
  # Test if the submission has been denied.
  # (moderation flag is false)
  def is_denied?
    self.moderation_flag == false
  end
  
  # Test if the submission has not yet been moderated.
  # (moderation flag is nil)
  def is_pending?
    self.moderation_flag.nil?
  end
  
  # Approve a piece of content on a feed.  Must be 
  # affilailated with a moderator.  Duration can be
  # overridden as needed.
  def approve(moderator, duration = self.duration)
     if update_attributes({:moderation_flag => true, :duration => duration, :moderator => moderator})
       true
     else
       reload
       false
     end
  end
  
  # Deny a piece of content on a feed.  Must be affiliated
  # with a moderator.  Duration is not changed, because the
  # the content is being denied.
  def deny(moderator)
    if update_attributes({:moderation_flag => false, :moderator => moderator})
      true
    else
      reload
      false
    end
  end
  
  # Resets the moderation state of a content submission to a feed.
  # Must be affialiated with a moderator.  Duration resets on default
  # to the duration specified by the uploader.
  def unmoderate(moderator, duration = self.content.duration)
    update_attributes({:moderation_flag => nil, :duration => duration, :moderator => moderator})
  end
end
