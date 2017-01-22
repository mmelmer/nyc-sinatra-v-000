class FiguresController < ApplicationController
  
  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'/figures/new'
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end

  post '/figures' do
    @figure = Figure.create(params["figure"])
       if params[:landmark][:name] != nil
        @figure.landmarks << Landmark.create(params[:landmark])
      end
      if params[:title][:name] != nil
        @figure.titles << Title.create(params[:title])
      end
    @figure.save
    redirect "figures/#{@figure.id}"
  end

  get '/figures/:id/edit' do 
    @figure = Figure.find(params[:id])
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'/figures/edit'
  end

  patch '/figures/:id' do
    @figure = Figure.id(params[:id])
    @figure.update(params[:figure])
    @figure.landmark = Landmark.find_or_create_by(name: params[:landmark][:name])
    @figure.title = Title.find_or_create_by(name: params[:title][:name])
    @figure.save
    redirect "/figures/#{@figure.id}"
  end

end