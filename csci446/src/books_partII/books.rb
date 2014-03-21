require 'sinatra'
require 'data_mapper'
require_relative 'Book'

get '/' do
	redirect '/list'
end

get '/list' do
	@sortby = params[:sort]
	if @sortby == nil
		@sortby = 'id'
	end
	erb :books_list
end