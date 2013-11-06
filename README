Acts As Noteable
=================

Allows for notes to be added to multiple and different models.

== Resources

Install
 * Run the following command:
 
 script/plugin install http://acts-as-noteable.googlecode.com/svn/trunk/acts_as_noteable/
 
 * Create a new rails migration and add the following self.up and self.down methods
 
  def self.up
    create_table "notes", :force => true do |t|
      t.column "from", :string, :limit => 50, :default => ""
      t.column "body", :text, :default => ""
      t.column "created_at", :datetime, :null => false
      t.column "noteable_id", :integer, :default => 0, :null => false
      t.column "noteable_type", :string, :limit => 15, :default => "", :null => false
    end
  
  end

  def self.down
    drop_table :notes
  end

== Usage
 
 * Make you ActiveRecord model act as noteable.
 
 class Model < ActiveRecord::Base
 	acts_as_noteable
 end
 
 * Add a note to a model instance
 
 model = Model.new
 note = Comment.new
 note.body = 'Some comment'
 model.notes << note
 
 * Each note references a noteable object
 
 model = Model.find(1)
 model.notes.get(0).noteable == model

== Helper method for views

Here’s how the helper works.

In the view you want to display notes in put the following:

<%= display_notes(object) %>

This will create a div filled with the note entries for the object and a AJAX form to add new notes to the object as well as delete notes from the object. The add and delete methods are stored in the notes_controller.rb that gets copied over into your app/controllers directory.

The full implementation for this method is:

<%= display_notes(obj, partial_name = "notes/note", controller_name = "notes") %>

I added the partial name and controller name in case you have multiple controllers in different folders, this way you can display notes for objects whose controllers are buried deep in a folder.

== Credits

Jake V - This plugin is heavily influenced by Acts As Commentable (by Juixe).

== More

http://blog.djdossiers.com/articles/2007/05/09/another-new-rails-plugin-acts-as-noteable

