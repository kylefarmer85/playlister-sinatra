class SongsController < ApplicationController

    get "/songs" do
        @songs = Song.all
        erb :"songs/index"
    end

    get "/songs/new" do
        @artists = Artist.all 
        @genres = Genre.all
        erb :"songs/new"
    end

    post '/songs' do
        @song = Song.create(params["song"])
        @song.artist = Artist.find_or_create_by(name: params[:artist][:name])
        @song.genre_ids = params[:genres]
        @song.save
        redirect "/songs/#{@song.slug}"
    end

    get "/songs/:slug" do 
        @song = Song.find_by_slug(params[:slug])
        erb :"songs/show"
    end

end