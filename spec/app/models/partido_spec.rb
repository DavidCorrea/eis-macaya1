require 'spec_helper'

describe Partido do

	before :each do
		@equipo1 = Equipo.new(:id => 1, :name => 'EquipoA')
		@equipo2 = Equipo.new(:id => 2, :name => 'EquipoB')
		@torneo = Torneo.new(:name => 'TorneoPrueba')
		@torneo.equipos = [@equipo1, @equipo2]
		@fecha1 = Fecha.new(:numero => 1)
		@fecha2 = Fecha.new(:numero => 2)
		@torneo.fechas = [@fecha1, @fecha2]
		
	end

	it 'Deberia dar True si es valido para el Torneo' do
    	@partido1 = Partido.new(:id_equipo_local => @equipo1.id, :id_equipo_visitante => @equipo2.id)
		@partido1.es_valido_para(@torneo).should == true
	end

	it 'Deberia dar False si es valido para el Torneo' do
    	@partido1 = Partido.new(:id_equipo_local => @equipo1.id, :id_equipo_visitante => @equipo2.id, :fecha => @fecha1)
		@fecha1.partidos = [@partido1]
		@partido2 = Partido.new(:id_equipo_local => @equipo1.id, :id_equipo_visitante => @equipo2.id)
		@partido2.es_valido_para(@torneo).should == false
	end
end
