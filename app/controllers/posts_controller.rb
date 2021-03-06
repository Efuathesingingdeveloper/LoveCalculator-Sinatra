class PostsController < ApplicationController

get '/posts' do
    if logged_in?
 @post = Post.all
erb :'posts/index'
    else
flash[:error] ="You Must Be Logged in to view the Artistree!"    
redirect"/"
    end
end 

get "/posts/new" do 
    if logged_in?
erb :"posts/new"
    else
   flash[:error] ="You Must Be Logged in to add a leaf to your Artistree!"    
redirect"/"
    end
end

get '/posts/users' do
@post= current_user.posts
    erb :"posts/index"
end 


post "/posts" do
    post= Post.new(work: params[:work], description: params[:description], link: params[:link], user_id: current_user.id)
if post.save

    flash[:message] ="Congratulations! you added a leaf to your tree"
   redirect "/posts/#{post.id}"
    else
        flash[:error]="your leaf was NOT added to your Artistree sucessfully: #{post.errors.full_messages.to_sentence}"
        redirect "/posts/new"
    end
end

get '/posts/:id' do
    @post = Post.find(params[:id])
    erb :'/posts/show'
end


get '/posts/:id/edit' do
    @post = Post.find(params[:id])
    if authorized_to_edit?(@post)
     erb :'/posts/edit'
    else
   flash[:error]= "You cannot edit another users Artistree!"
   redirect'/posts'
    end
end

patch '/posts/:id' do
    @post = Post.find(params[:id])
    @post.update(work: params[:work], description: params[:description], link: params[:link])
redirect "/posts/#{@post.id}"
end 

delete '/posts/:id' do
    @post = Post.find(params[:id])
    @post.destroy
    redirect '/posts'
    end
end

