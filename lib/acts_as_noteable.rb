# ActsAsNoteable
module Flvorful
  module Acts #:nodoc:
    module Noteable #:nodoc:

      def self.included(base)
        base.extend ClassMethods  
      end

      module ClassMethods
        def acts_as_noteable
          has_many :notes, :as => :noteable, :dependent => :destroy, :order => 'created_at ASC'
          include DJDossiers::Acts::Noteable::InstanceMethods
          extend DJDossiers::Acts::Noteable::SingletonMethods
        end
      end
      
      # This module contains class methods
      module SingletonMethods
        # Helper method to lookup notes for a given object.
        # This method is equivalent to obj.notes.
        def find_notes_for(obj)
          noteable = ActiveRecord::Base.send(:class_name_of_active_record_descendant, self).to_s
         
          Note.find(:all,
            :conditions => ["noteable_id = ? and noteable_type = ?", obj.id, noteable],
            :order => "created_at DESC"
          )
        end
        
        # Helper class method to lookup notes for
        # the mixin noteable type written by a given user's name (`from` column).  
        def find_notes_by_user(user) 
          noteable = ActiveRecord::Base.send(:class_name_of_active_record_descendant, self).to_s
          
          Note.find(:all,
            :conditions => ["from = ? and noteable_type = ?", user, noteable],
            :order => "created_at DESC"
          )
        end
      end
      
      # This module contains instance methods
      module InstanceMethods
        # Helper method to sort notes by date
        def notes_ordered_by_submitted
          Note.find(:all,
            :conditions => ["noteable_id = ? and noteable_type = ?", id, self.type.name],
            :order => "created_at DESC"
          )
        end
        
        # Helper method that defaults the submitted time.
        def add_note(note)
          notes << note
        end
      end
      
    end
  end
end
