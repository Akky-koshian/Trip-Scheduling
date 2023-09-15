#トリップスケジューリング
require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require 'sinatra/activerecord'
require './models'

enable :sessions

helpers do
    def current_user
        User.find_by(id: session[:user])
    end
end


before '/schedules' do
    if current_user.nil?
        redirect '/'
    end
    @title = ""
    
end


get '/' do
    if $title.nil?
        $title = ""
    end
    
	if current_user.nil?
	@schedules = Schedule.none
	else
	@schedules = current_user.schedules
	end
	erb :index
end




get '/signup' do
    erb :sign_up
end

post '/signup' do
    user = User.create(
        name: params[:name],
        password: params[:password],
        password_confirmation: params[:password_confirmation]
    )
    if user.persisted?
        session[:user] = user.id
    end
    redirect '/'
end


get '/signin' do
    erb :sign_in
end

post '/signin' do
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
        $pass = params[:password]
        session[:user] = user.id
    end
    redirect '/'
end


get '/signout' do
    session[:user] = nil
    redirect '/'
end


post '/title' do
    $title = params[:title]
    redirect '/'
end




get '/schedules/new' do
    erb :new
end


post '/schedules' do 
    current_user.schedules.create(
        date: params[:date],
        time: params[:time],
        place: params[:place],
        schedule: params[:schedule],
        note: params[:note]
        )
    redirect '/'
end


post '/schedules/:id/delete' do
    schedule = Schedule.find(params[:id])
    schedule.destroy
    redirect '/'
end


get '/schedules/:id/edit' do
    @schedule = Schedule.find(params[:id])
    erb :edit
end

post '/schedules/:id' do
    schedule = Schedule.find(params[:id])
    schedule.date = params[:date]
    schedule.time = params[:time]
    schedule.place = params[:place]
    schedule.schedule = params[:schedule]
    schedule.note = params[:note]
    schedule.save
    redirect '/'
end



get '/startpage' do
    erb :startpage
end