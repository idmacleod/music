require("pg")

require_relative("../db/sql_runner")
require_relative("album")

class Artist

    attr_accessor :name
    attr_reader :id

    def initialize(options)
        @id = options["id"].to_i if options["id"]
        @name = options["name"]
    end

    def save()
        sql = "INSERT INTO artists (name) VALUES ($1) RETURNING id"
        values = [@name]
        @id = SqlRunner.run(sql, values)[0]["id"].to_i
    end

    def albums()
        sql = "SELECT * FROM albums WHERE artist_id = $1;"
        values = [@id]
        albums_array = SqlRunner.run(sql, values)
        return albums_array.map {|album_hash| Album.new(album_hash)}
    end

    def update()
        sql = "UPDATE artists SET name = $1 WHERE id = $2;"
        values = [@name, @id]
        SqlRunner.run(sql, values)
    end

    def delete()
        sql = "DELETE FROM artists WHERE id = $1;"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    def self.delete_all()
        SqlRunner.run("DELETE FROM artists;")
    end
    
    def self.all()
        sql = "SELECT * FROM artists;"
        artists_array = SqlRunner.run(sql)
        return artists_array.map {|artist_hash| Artist.new(artist_hash)}
    end

    def self.find(id)
        sql = "SELECT * FROM artists WHERE id = $1;"
        values = [id]
        artist_hash = SqlRunner.run(sql, values).first()
        return Artist.new(artist_hash) if artist_hash
    end

end