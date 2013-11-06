# $Id$
# $LastChangedDate$
# $LastChangedRevision$
#
# acts_as_noteable rails plugin
# Allows ActiveRecord models to have associated notes.
#
# Copyright (c) 2008 Flvorful, Inc.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
# associated documentation files (the "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the
# following conditions:
#
# The above copyright notice and this permission notice shall be included in all copies or substantial
# portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
# LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN
# NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
# WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

module Flvorful #:nodoc:
  module Noteable #:nodoc:
    module Helper #:nodoc:
      # Generates the notes and an AJAXified form to add more to the current object.
      #
      # The first argument is the ActiveRecord object.
      #
      # The second argument is the name of the partial for each note entry.  The plugin contains a
      # partial for you to use called _note.rhtml.  I have tried to layout the HTML in the helper
      # in a way that can easily be read.  If you are familiar with HTML you should be able to style
      # the notes and the form and way you like.
      #
      # Example:
      # 
      # <%= display_notes(@object, partial_name) %>
      #
      # will return a vertical list of notes and at the bottom will be a section to add
      # more for the current object.
      # 
      # Available options:
      #
      # :obj: The object to get the notes from.
      # :partial_name (default: "notes/note") : This is the full partial path/name of "_note.rhtml".
                           
			def display_notes(obj, partial_name = "notes/note", controller_name = "notes")
				content_tag(:div, :id => "notes") do
					content_tag(:h2, "Notes") +
					content_tag(:div, :id => "the_notes") do
						render(:partial => partial_name, :collection => obj.notes, :locals => { :controller_name => controller_name })  
					end +
					link_to_function("Add Note", "$('#add_note').slideToggle(500);") + 
					content_tag(:div, :id => "add_note", :style => "display:none") do
						form_remote_tag( :url => { :controller => controller_name, :action => "add_note", :id => obj.id, :class_name => obj.class.to_s } ) +
						text_area("note", "body", "rows" => 5) + "<br />" + 
						submit_tag("Add Note", :class => "submit") + "<br />" 
					end
				end
			end     
    end
  end
end