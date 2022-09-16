class Song

  attr_accessor :name, :album, :id

  def initialize(name:, album:, id: nil)
    @id = id
    @name = name
    @album = album
  end

  def self.create_table
    sql = <<-SQL
    create table if not exists songs (
      id INTEGER Primary Key,
      name text,
      album text
    );
    SQL
    DB[:conn].execute(sql)
    end

    def save
      sql = <<-SQL
      insert into songs (name, album)
      values (?,?);
      SQL
      DB[:conn].execute(sql, self.name, self.album)

      self.id = DB[:conn].execute('SELECT last_insert_rowid() FROM songs')[0][0]

      self
    end

    def self.create (name:, album:)
      song = Song.new(name: name, album: album)
      song.save
    end 
end
