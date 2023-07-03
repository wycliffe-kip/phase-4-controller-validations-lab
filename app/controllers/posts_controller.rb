class PostsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_record_invalid_response
rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found_response
  
  def show
    post = Post.find(params[:id])
    render json: post
    render_record_not_found_response
  end

  def update
    post = Post.find(params[:id])
    post.update!(post_params)
    render json: post
  end

  private

  def post_params
    params.permit(:category, :content, :title)
  end

  def render_record_not_found_response
    render json: { errors: "Post not found" }, status: :not_found
  end 

  def render_record_invalid_response(invalid)
    render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
  end
end

