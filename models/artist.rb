require('pg')

require_relative('../db/sql_runner')
require_relative('album')

class Artist

    attr_accessor :name
    attr_reader :id

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @name = options['name']
    end

    def save()
        sql = "INSERT INTO artists (name) VALUES ($1) RETURNING id"
        values = [@name]
        @id = SqlRunner.run(sql, values)[0]['id'].to_i
    end

    def self.delete_all()
        SqlRunner.run("DELETE FROM artists;")
    end
    
    def self.all()
        sql = "SELECT * FROM artists;"
        artists_array = SqlRunner.run(sql)
        return artists_array.map {|artist_hash| Artist.new(artist_hash)}
    end
       
end