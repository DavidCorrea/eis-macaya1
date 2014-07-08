Macaya::App.controllers :partidos do

	get :new do
        @torneo = torneo_actual
        @equipos = torneo_actual.equipos
		### Se realiza esto por "problemas" con el Select. Debe arreglarse.
		@fechas = []
		torneo_actual.fechas.each do | f |
			@fechas << f.numero.to_s
		end
		###
	    @partido = Partido.new
	    render 'partidos/new'
	end

	post :create do
		@torneo = torneo_actual
		@partido = Partido.new
		@equipos = torneo_actual.equipos
        ### Se realiza esto por "problemas" con el Select. Debe arreglarse.
		@fechas = []
		torneo_actual.fechas.each do | f |
			@fechas << f.numero.to_s
		end
		###
		@equipo_local = Equipo.first(:name => params[:partido][:equipo_local])
        @equipo_visitante = Equipo.first(:name => params[:partido][:equipo_visitante])
        @dia = (params[:partido][:dia])
        @fecha = Fecha.first(:numero => params[:partido][:fecha], :torneo => torneo_actual)

		if !@equipo_local.nil? and !@equipo_visitante.nil?
				unless @equipo_local.eql? @equipo_visitante
					@partido = Partido.new                
		 			@partido.dia = @dia
		            @partido.id_equipo_local = @equipo_local.id
		            @partido.id_equipo_visitante = @equipo_visitante.id
					@fecha.partidos << @partido
					if @partido.es_valido_para(torneo_actual) and @partido.save						
		  				flash[:success] = 'PARTIDO AGREGADO EXITOSAMENTE'
		  				redirect url(:torneos, :show, :torneo_id => torneo_actual.id)
					else
		  				flash.now[:error] = 'EL PARTIDO YA EXISTE PARA OTRA FECHA'
		  				render 'partidos/new'
		   			end
		   		else
		    		flash.now[:error] = 'LOS EQUIPOS DEBEN SER DISTINTOS'
		    		render 'partidos/new'	
		    	end
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

		@dia = (params[:partido][:dia])

		if !@resultado_local_s.empty? and !@resultado_visitante_s.empty?
			begin
				@resultado_local = Integer @resultado_local_s
				@resultado_visitante = Integer @resultado_visitante_s
				if @resultado_visitante >= 0 and @resultado_local >= 0
					# Se comprueba por el posible cambio en la vista
					if @dia.nil?
						@partido.update(:resultado_local => @resultado_local, :resultado_visitante => @resultado_visitante)
					else
				    	@partido.update(:resultado_local => @resultado_local, :resultado_visitante => @resultado_visitante, :dia => @dia)
					end
					if @resultado_local > @resultado_visitante
				       	@puntaje_actual_local.update(:puntaje => (@puntaje_actual_local.puntaje + 3))
				    elsif @resultado_local < @resultado_visitante
				        @puntaje_actual_visitante.update(:puntaje => (@puntaje_actual_visitante.puntaje + 3))
			   	    else
				        @puntaje_actual_local.update(:puntaje => (@puntaje_actual_local.puntaje + 1))
				        @puntaje_actual_visitante.update(:puntaje => (@puntaje_actual_visitante.puntaje + 1))
					end
				else
					flash[:error] = 'LOS VALORES DEBEN SER POSITIVOS'
				end
			rescue
				flash[:error] = 'DEBE INGRESAR VALORES NUMERICOS'
			end		
		else
			flash[:error] = 'DEBE COMPLETAR TODOS LOS CAMPOS'			
		end
		redirect url(:torneos, :show, :torneo_id => @partido.fecha.torneo.id)
	end
end
