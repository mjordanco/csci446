require 'rack'
require 'ERB'
require 'sqlite3'

class Book

	attr_reader :rank, :title, :author, :language, :year, :sold

	def initialize(rank, title, author, language, year, sold)
		@rank = rank
		@title = title
		@author = author
		@language = language
		@year = year
		@sold = sold
	end

end

class Books

	def initialize()
		db = SQLite3::Database.new( "books.sqlite3.db" )
		@books = []

		db.execute "SELECT * FROM books" do |row|
			@books.push Book.new(row[0], row[1], row[2], row[3], row[4], row[5])
		end
	end

	def call(env)
		request = Rack::Request.new(env)
		response = Rack::Response.new

		File.open("book_list_header.html", "r") { |head| response.write(head.read) }
		puts "this is the path info: #{env["PATH_INFO"]}"
		case env["PATH_INFO"]
      when /.*?\.css/
        # serve up a css file
        # remove leading /
        file = env["PATH_INFO"][1..-1]
        return [200, {"Content-Type" => "text/css"}, [File.open(file, "rb").read]]
      when /\/list.*/
      	puts "this is the request path: #{env["QUERY_STRING"]}"
      	case env["QUERY_STRING"]
	      	when /sort=rank/
		      	puts "sorting by rank"
		      	@books.sort_by! &:rank
	      	when /sort=title/
		      	puts "sorting by title"
		      	@books.sort_by! &:title
	      	when /sort=author/
		      	puts "sorting by author"
		      	@books.sort_by! &:author
	      	when /sort=language/
		      	puts "sorting by language"
		      	@books.sort_by! &:language
	      	when /sort=year/
		      	puts "sorting by year"
		      	@books.sort_by! &:year
	      	when /sort=sold/
		      	puts "sorting by sold"
		      	@books.sort_by! &:sold

      	end
    end

		list = ERB.new(File.read("books_list_list.html.erb")).result(binding)

		response.write(list)

		File.open("book_list_footer.html", "r") { |head| response.write(head.read) }
		response.finish
	end

end

Signal.trap('INT') {
	Rack::Handler::WEBrick.shutdown
}

Rack::Handler::WEBrick.run Books.new, :Port => 8080