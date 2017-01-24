class LandmarksController < ApplicationController

  get '/landmarks' do
    @landmarks = Landmark.all
    erb :'/landmarks/index'
  end

  get '/landmarks/new' do
    @titles = Title.all
    @figures = Figure.all
    erb :'/landmarks/new'
  end

  get '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    erb :"/landmarks/show"
  end

  post '/landmarks' do
    @landmark = Landmark.create(params[:landmark])
    if params[:figure][:name] != nil
      @landmark.figures << Figure.create(params[:figure])
    end
    if params[:title][:name] != nil
      @landmark.title << Title.create(params[:title])
    end
    @landmark.save
    redirect "/landmarks/#{landmark.id}"
  end

  get '/landmarks/:id/edit' do
    @landmark = Landmark.find(params[:id])
    @figures = Figure.all
    @titles = Title.all
    erb :"/landmarks/edit"
  end

  post '/landmarks/:id' do
    @landmark = Landmark.find(params[:id])
    @landmark.name = params["landmark"]["name"] 
    @landmark.year_completed = params["landmark"]["year_completed"]
    @landmark.save
    redirect "/landmarks/#{@landmark.id}"
  end

end
