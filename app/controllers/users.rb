get '/users/new' do
  erb :'/users/new_user'
end

post '/users' do
  new_user = User.new(username: params[:username], password: params[:password])
  if new_user.save
    redirect '/'
  else
    redirect '/errors=couldnt_make_a_user'
  end
end

get '/users/:id' do
  @user = User.find_by(id: session[:user_id])
  erb :'/users/show_user'
end
