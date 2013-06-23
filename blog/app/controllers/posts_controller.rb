# coding: utf-8

class PostsController < ApplicationController

	def index
		@posts = Post.all(:order => "created_at DESC")
	end

	def show
		@post = Post.find(params[:id])
		@comment = Post.find(params[:id]).comments.build
	end

	def new
		@post = Post.new
	end

	def create
		#parameterからPostオブジェクトを作成する。
		@post = Post.new(params[:post])
		#保存する。出来た場合、posts_pathへ。できなかった場合、newのところへ遷移
		if @post.save
			redirect_to posts_path, notice: '作成されました！'
		else
			render action: 'new'
		end
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])
		if @post.update_attributes(params[:post])
			redirect_to posts_path, notice: '更新されました！'
		else
			render action: 'edit'
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		#redirect_to posts_path, notice: '削除されました'
		render json: { post: @post}
	end

end
