#Implemented Comments controller for sendig comments to user 
class CommentsController < ApplicationController
	before_action :find_message, only: [:create, :edit, :update, :destroy]
	before_action :find_comment, only: [:edit, :update, :destroy]
	before_action :authenticate_user!

	def create
		# creates a comment with respect to the message
		@comment = @message.comments.create(comment_params)
		@comment.user_id = current_user.id

		if @comment.save
			UserMailer.comment_update(@message).deliver
			redirect_to message_path(@message)
		
	else
        format.html { render :_comment }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
		end
	end

	def edit
	end

	def update
		if @comment.update(comment_params)
			redirect_to message_path(@message)
		else
			render 'edit'
		end
	end

	def destroy
		@comment.destroy
		redirect_to message_path(@message)
	end

	private

		def comment_params
			params.require(:comment).permit(:content)
		end

		def find_message
			@message = Message.find(params[:message_id])
		end

		def find_comment
			@comment = @message.comments.find(params[:id])
		end

end