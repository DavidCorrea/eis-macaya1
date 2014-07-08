class Fecha
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  property :numero, Integer
  belongs_to :torneo

  has n, :partidos

  validates_presence_of :numero
  validates_presence_of :torneo

end
