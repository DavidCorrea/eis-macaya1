class Torneo
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :name, String, :unique => true
  property :tipo, String

  validates_presence_of :name
  validates_presence_of :tipo

  has n, :fechas

  has n, :puntajes
  has n, :equipos, :through => :puntajes

end
