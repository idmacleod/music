require("pry")

require_relative("../models/album")
require_relative("../models/artist")

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({"name" => "Blur"})
artist1.save()
artist2 = Artist.new({"name" => "Oasis"})
artist2.save()

album1 = Album.new({"title" => "Parklife", "genre" => "Indie", "artist_id" => artist1.id})
album1.save()
album2 = Album.new({"title" => "The Great Escape", "genre" => "Britpop", "artist_id" => artist1.id})
album2.save()
album3 = Album.new({"title" => "Definitely Maybe", "genre" => "Pop", "artist_id" => artist2.id})
album3.save()

albums = Album.all()
artists = Artist.all()

binding.pry
nil