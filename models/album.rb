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

end