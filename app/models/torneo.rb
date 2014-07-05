class Torneo
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :name, String, :unique => true
  property :tipo, String
  property :cantidad_de_fechas, Integer

  validates_presence_of :name
  validates_presence_of :tipo

  has n, :partidos

  has n, :puntajes
  has n, :equipos, :through => :puntajes

end
