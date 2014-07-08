class Partido
  include DataMapper::Resource

  # property <name>, <type>
  property :id, Serial
  belongs_to :fecha
  property :dia, Date
  property :id_equipo_local, Integer
  property :resultado_local, Integer
  property :id_equipo_visitante, Integer
  property :resultado_visitante, Integer

  validates_presence_of :fecha
  validates_uniqueness_of :fecha, :scope => [:id_equipo_local, :id_equipo_visitante]

  def es_valido_para(torneo)
	@fechas = torneo.fechas
	@es_valido = true
	@fechas.each do | f |
		f.partidos.each do | p |
			## TODO: Llevar criterio por redefinicion de igualdad entre partidos.
			if self.id_equipo_local.eql?p.id_equipo_local and self.id_equipo_visitante.eql?p.id_equipo_visitante				
				@es_valido = false
				break
			end
		end
	end
	@es_valido
  end

  def nombre_equipo_local
	Equipo.nombre_para(id_equipo_local)
  end

  def nombre_equipo_visitante
	Equipo.nombre_para(id_equipo_visitante)
  end

end
