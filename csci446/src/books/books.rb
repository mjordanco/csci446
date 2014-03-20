require 'rack'

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

	end

	def call(env)
		request = Rack::Request.new(env)
		response = Rack::Response.new

		books = []

		rank = 1
		File.open("books.txt", "r") do |file|
			file.each_line do |line|
				tokens = line.split(", ")
				books.push Book.new(rank, tokens[0], tokens[1], tokens[2], tokens[3].to_i, tokens[4].split()[0].to_i)
				rank += 1
			end
		end

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
		      	books.sort_by! &:rank
	      	when /sort=title/
		      	puts "sorting by title"
		      	books.sort_by! &:title
	      	when /sort=author/
		      	puts "sorting by author"
		      	books.sort_by! &:author
	      	when /sort=language/
		      	puts "sorting by language"
		      	books.sort_by! &:language
	      	when /sort=year/
		      	puts "sorting by year"
		      	books.sort_by! &:year
	      	when /sort=sold/
		      	puts "sorting by sold"
		      	books.sort_by! &:sold

      	end
    end

		response.write("<table>")
    books.each do |book|
			response.write("<tr>")
			response.write("<td>#{book.rank}</td>")
			response.write("<td>#{book.title}</td>")
			response.write("<td>#{book.author}</td>")
			response.write("<td>#{book.language}</td>")
			response.write("<td>#{book.year}</td>")
			response.write("<td>#{book.sold} million</td>")
			response.write("</tr>")
		end
		response.write("</table>")


		File.open("book_list_footer.html", "r") { |head| response.write(head.read) }
		response.finish
	end

end

Signal.trap('INT') {
	Rack::Handler::WEBrick.shutdown
}

Rack::Handler::WEBrick.run Books.new, :Port => 8080