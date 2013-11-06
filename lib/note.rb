class Note < ActiveRecord::Base
  belongs_to :noteable, :polymorphic => true

  # Helper class method to look up all notes for 
  # noteable class name and noteable id.
  def self.find_notes_for_noteable(noteable_str, noteable_id)
    find(:all,
      :conditions => ["noteable_type = ? and noteable_id = ?", noteable_str, noteable_id],
      :order => "created_at DESC"
    )
  end

  # Helper class method to look up a noteable object
  # given the noteable class name and id 
  def self.find_commentable(noteable_str, noteable_id)
    noteable_str.constantize.find(noteable_id)
  end
end