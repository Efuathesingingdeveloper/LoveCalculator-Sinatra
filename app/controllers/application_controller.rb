require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret,"secret_session"
  end

  get "/" do
    erb :welcome
    # "Georgette is Beautiful"
  end

end
