require('pg')

require_relative('../db/sql_runner')
require_relative('artist')

class Album

    attr_accessor :title, :genre, :artist_id
    attr_reader :id

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @title = options['title']
        @genre = options['genre']
        @artist_id = options['artist_id'].to_i
    end

    def save()
        sql = "INSERT INTO albums (title, genre, artist_id) VALUES ($1, $2, $3) RETURNING id;"
        values = [@title, @genre, @artist_id]
        @id = SqlRunner.run(sql, values)[0]['id'].to_i
    end

    def artist()
        sql = "SELECT * FROM artists WHERE id = $1;"
        values = [@artist_id]
        artist_hash = SqlRunner.run(sql, values).first()
        return Artist.new(artist_hash)
    end

    def update()
        sql = "UPDATE albums SET (title, genre, artist_id) = ($1, $2, $3) WHERE id = $4;"
        values = [@title, @genre, @artist_id, @id]
        SqlRunner.run(sql, values)
    end

    def delete()
        sql = "DELETE FROM albums WHERE id = $1"
        values = [@id]
        SqlRunner.run(sql, values)
    end

    def self.delete_all()
        SqlRunner.run("DELETE FROM albums;")
    end
    
    def self.all()
        sql = "SELECT * FROM albums;"
        albums_array = SqlRunner.run(sql)
        return albums_array.map {|album_hash| Album.new(album_hash)}
    end

    def self.find(id)
        sql = "SELECT * FROM albums WHERE id = $1"
        values = [id]
        album_hash = SqlRunner.run(sql, values).first()
        return Album.new(album_hash) if album_hash
      end

end