class Song
  attr_accessor :name, :artist_name, :song
  @@all = [] 

  def self.all
    @@all
  end
  
  def name=(name)
    @name = name
  end

  def artist_name=(artist)
    @artist_name = artist
  end

  def save
    self.class.all << self
  end

  def self.create
   Song.new.save
   @@all[-1]
  end

  def self.new_by_name(title)
    song = Song.new
    song.name = title
    song.save
    song
  end

  def self.create_by_name(title)
    song = Song.new
    song.name = title
    song.artist_name = @artist_name
    song.save
    song
  end

  def self.find_by_name(name)
    @@all.select {|s| s.name == name}[0]
  end

  def self.find_or_create_by_name(name)
    if !(self.find_by_name(name))
      self.create_by_name(name)
    else
      self.find_by_name(name)
    end
  end

  def self.alphabetical
    sorted_songs = @@all.collect{|instance| instance.name}.sort
    sorted_songs.collect{|name|self.find_by_name(name)}
  end

  def self.new_from_filename(file)
    file_array = file.split(/.mp3/).join.split(" - ")
    @artist_name = file_array[0]
    self.create_by_name(file_array[1])
  end

  def self.create_from_filename(file)
    self.new_from_filename(file).save
  end

  def self.destroy_all
    @@all = []
  end
  

end