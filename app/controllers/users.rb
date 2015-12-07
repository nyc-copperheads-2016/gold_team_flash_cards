get '/users/new' do
  erb :'/users/new_user'
end

post '/users' do
  # If your param keys match your obj attr's, you can pass params directly:
  #new_user = User.new(username: params[:username], password: params[:password])
  new_user = User.new(params)
  if new_user.save
    redirect '/'
  else
    erb :'/users/new_user', locals: { errors: new_user.errors.full_messages }
  end
end

get '/users/:id' do
  @user = User.find_by(id: session[:user_id])
  erb :'/users/show_user'
end
