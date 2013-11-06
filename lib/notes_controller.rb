class NotesController < ApplicationController
	
	def add_note
		controller_name = get_controller_name_for_notes
    @object = params[:class_name].constantize.find(params[:id])
    @note = Note.new(params[:note])
    @note.from = current_user.first_name
    @note.body = @note.body.gsub(/\r\n/, "<br \/>").gsub(/\n/, "<br \/>")
    if @object.notes << @note
      render :update do |page|
       # Think "inline RJS" 
       page.insert_html :top, 'the_notes', :partial => 'note', :object => @note, :locals => { :controller_name => controller_name }
       page.visual_effect :slide_down, "note_#{@note.id}"
       page.visual_effect :slide_up, "add_note"
      end
    else
      flash[:warning] = "Could not save Note"
    end
  end
  
  def delete_note
    @note = Note.find(params[:id])
    if @note.destroy
      render :update do |page|
      	page.visual_effect :highlight, "note_#{params[:id]}"
       	page.remove  "note_#{params[:id]}"
      end
    else
      flash[:warning] = "Could not delete note"
    end
  end
  
  private
  def get_controller_name_for_notes
  	file_path = File.expand_path(__FILE__)
  	arr = file_path.split("/")
  	path_arr = arr.slice(arr.index("controllers") + 1, arr.size)
  	if path_arr.size == 1
  		return "/notes"
		else
			return "/#{path_arr.slice(0, path_arr.size - 1)}/notes"
		end
  end
end
