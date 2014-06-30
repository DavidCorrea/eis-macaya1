class Partido
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  belongs_to :torneo
  property :fecha, Date
  property :id_equipo_local, Integer
  property :resultado_local, Integer
  property :id_equipo_visitante, Integer
  property :resultado_visitante, Integer
  
#  belongs_to :equipo_local, 'Equipo', :key => true
#  belongs_to :equipo_visitante, 'Equipo', :key => true

#  validates_presence_of :fecha
  validates_uniqueness_of :torneo, :scope => [:fecha, :id_equipo_local, :id_equipo_visitante]

  def nombre_equipo_local
	Equipo.nombre_para(id_equipo_local)
  end

  def nombre_equipo_visitante
	Equipo.nombre_para(id_equipo_visitante)
  end

end
