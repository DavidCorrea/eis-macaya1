Macaya::App.controllers :partidos do

	get :new do
        @torneo = torneo_actual
        @equipos = torneo_actual.equipos
	    @partido = Partido.new
	    render 'partidos/new'
	end

	post :create do
		@torneo = torneo_actual
		@partido = Partido.new
		@equipos = torneo_actual.equipos
		@equipo_local = Equipo.first(:name => params[:partido][:equipo_local])
        @equipo_visitante = Equipo.first(:name => params[:partido][:equipo_visitante])
        @fecha = (params[:partido][:fecha])

		if !@equipo_local.nil? and !@equipo_visitante.nil?
#			if !@fecha.empty?
				unless @equipo_local.eql? @equipo_visitante
					@partido = Partido.new                
		 			@partido.fecha = @fecha
		            @partido.id_equipo_local = @equipo_local.id
		            @partido.id_equipo_visitante = @equipo_visitante.id
					torneo_actual.partidos << @partido
					if @partido.save
		  				flash[:success] = 'PARTIDO AGREGADO EXITOSAMENTE'
		  				redirect url(:torneos, :show, :torneo_id => torneo_actual.id)
					else
		  				flash.now[:error] = 'EL PARTIDO YA EXISTE'
		  				render 'partidos/new'
		   			end
		   		else
		    		flash.now[:error] = 'LOS EQUIPOS DEBEN SER DISTINTOS'
		    		render 'partidos/new'	
		    	end
#			else
#				flash.now[:error] = 'DEBE INGRESAR UNA FECHA'
#		    	render 'partidos/new'	
#			end 
		else
			flash.now[:error] = 'DEBE SELECCIONAR DOS EQUIPOS'
		    render 'partidos/new'	
		end
	end

	post :update, :with => :partido_id do
		@partido = Partido.first(:id => params[:partido_id])

        @equipo_local = Equipo.first(:id => @partido.id_equipo_local)
		@equipo_visitante = Equipo.first(:id => @partido.id_equipo_visitante)

        @puntaje_actual_local = Puntaje.first(:equipo_id => @equipo_local.id, :torneo_id => torneo_actual.id)
        @puntaje_actual_visitante = Puntaje.first(:equipo_id => @equipo_visitante.id, :torneo_id => torneo_actual.id)

		@resultado_local_s = params[:partido][:resultado_equipo_local]
        @resultado_visitante_s = params[:partido][:resultado_equipo_visitante]

		puts @resultado_local_s

		if !@resultado_local_s.empty? and !@resultado_visitante_s.empty?
			begin
				@resultado_local = Integer @resultado_local_s
				@resultado_visitante = Integer @resultado_visitante_s
				if @resultado_visitante >= 0 and @resultado_local >= 0
				    @partido.update(:resultado_local => @resultado_local, :resultado_visitante => @resultado_visitante)
					if @resultado_local > @resultado_visitante
				       	@puntaje_actual_local.update(:puntaje => (@puntaje_actual_local.puntaje + 3))
				    elsif @resultado_local < @resultado_visitante
				        @puntaje_actual_visitante.update(:puntaje => (@puntaje_actual_visitante.puntaje + 3))
			   	    else
				        @puntaje_actual_local.update(:puntaje => (@puntaje_actual_local.puntaje + 1))
				        @puntaje_actual_visitante.update(:puntaje => (@puntaje_actual_visitante.puntaje + 1))
					end
					redirect url(:torneos, :show, :torneo_id => @partido.torneo.id)
				else
					flash[:error] = 'LOS VALORES DEBEN SER POSITIVOS'
					redirect url(:torneos, :show, :torneo_id => @partido.torneo.id)
				end
			rescue
				flash[:error] = 'DEBE INGRESAR VALORES NUMERICOS'
				redirect url(:torneos, :show, :torneo_id => @partido.torneo.id)
			end		
		else
			flash[:error] = 'DEBE COMPLETAR TODOS LOS CAMPOS'
			redirect url(:torneos, :show, :torneo_id => @partido.torneo.id)
		end
	end
end
