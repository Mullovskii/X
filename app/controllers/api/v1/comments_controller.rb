module Api
  module V1
    class CommentsController < ApplicationController
      before_action :set_comment, only: [:update, :destroy]
      before_action :authenticate_request!
 
      # POST /comments
      def create
        # @comment = current_user.comments.build(comment_params.merge({ author_id: current_user.id, author_type: current_user.class.to_s }))
        @comment = Comment.new(comment_params)
        if current_user == @comment.author || current_user.employed_in(@comment.author) 
          if @comment.save
            render json: @comment, status: :created
          else
            render json: @comment.errors, status: :unprocessable_entity
          end
        else
          render json: {errors: ['Unauthorized']}, status: :unauthorized
        end
      end

      # PATCH/PUT /comments/1
      def update
        if current_user == @comment.author || current_user.employed_in(@comment.author) 
          if @comment.update(comment_params)
            render json: @comment
          else
            render json: @comment.errors, status: :unprocessable_entity
          end
        else
          render json: {errors: ['Unauthorized']}, status: :unauthorized
        end
      end

      # DELETE /comments/1
      def destroy
        if current_user == @comment.author || current_user.employed_in(@comment.author) 
          @comment.destroy
        else
          render json: {errors: ['Unauthorized']}, status: :unauthorized
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_comment
          @comment = Comment.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def comment_params
          params.require(:comment).permit(:author_id, :author_type, :commented_id, :commented_type, :body, :url)
        end
    end
  end
end
