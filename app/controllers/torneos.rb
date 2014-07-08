Macaya::App.controllers :torneos do

	get :all do
	    @torneos = Torneo.all
	    render 'torneos/torneo_manager'
	end

	get :new do
        asignar_equipos_a_agregar []
	    @torneo = Torneo.new
        @equipos = Equipo.all(:order => [:name.asc])
	    render 'torneos/new'
	end

	get :table do
		@posicion = 0
        @equipos = Equipo.all
        @puntajes = Puntaje.all(:torneo_id => torneo_actual.id, :order => [:puntaje.desc])
	    render 'torneos/table'
	end

	get :show, :with => :torneo_id do
	    @torneo = Torneo.get(params[:torneo_id])
	    asignar_torneo_actual @torneo
        @fecha_actual = 1
	    #@partidos = Partido.all(:fecha.torneo => torneo_actual.id)
		@fechas = torneo_actual.fechas
        render 'torneos/show'
	end

	post :create do
        @equipos = Equipo.all
		@torneo = Torneo.new
        @torneo.name = (params[:torneo][:name])
        @torneo.tipo = (params[:torneo][:tipo])
        if params[:crear]
            @cantidad_de_equipos = equipos_a_agregar.size
            @cantidad_de_fechas_a_crear = 0
            if @cantidad_de_equipos.odd?
                if !params[:torneo][:tipo].eql? 'IDA'
					 @cantidad_de_fechas_a_crear = @cantidad_de_equipos * 2
				end
			else
				if params[:torneo][:tipo].eql?'IDA'
					 @cantidad_de_fechas_a_crear = @cantidad_de_equipos - 1
				else
					 @cantidad_de_fechas_a_crear = (@cantidad_de_equipos - 1) * 2
				end
			end
			#if @cantidad_de_equipos >= 2
				if !@torneo.name.empty?
                    if !@torneo.tipo.empty?
						if @torneo.save
						  #Se crean las relaciones de puntaje
						  equipos_a_agregar.each do | equipo_name |
							@equipo = Equipo.first(:name => equipo_name)
						  	@puntaje = Puntaje.new
							@puntaje.torneo = @torneo
					   	 	@puntaje.equipo = @equipo
							@puntaje.puntaje = 0
					   	 	@puntaje.save
						  end   
						  #Se crean las fechas  
						  @numero_fecha = 1
						  while  @cantidad_de_fechas_a_crear > 0 do
								@fecha = Fecha.create(:numero => @numero_fecha, :torneo => @torneo)
								@numero_fecha = @numero_fecha + 1
                                 @cantidad_de_fechas_a_crear =  @cantidad_de_fechas_a_crear - 1
						  end                    
						  borrar_equipos_a_agregar
						  flash[:success] = 'EL TORNEO FUE CREADO'
						  redirect '/'
						else
						  flash.now[:error] = 'NO SE PUDO CREAR EL TORNEO'
						  render 'torneos/new'
						end
					else
						flash.now[:error] = 'DEBE ELEGIR UN TIPO DE TORNEO'
						  render 'torneos/new'
					end
				else
					flash.now[:error] = 'DEBE INGRESAR UN NOMBRE'
					render 'torneos/new'
				end
			#else
			#	flash.now[:error] = 'DEBE ELEGIR AL MENOS DOS EQUIPOS'
			#	render 'torneos/new'
			#end
        else
            @equipo = Equipo.first(:name => params[:torneo][:equipos])
            if equipos_a_agregar.include? @equipo.name
				flash.now[:error] = 'EL EQUIPO YA ESTA AGREGADO'
			else
				equipos_a_agregar << @equipo.name
            	flash.now[:success] = 'SE AGREGO AL EQUIPO "' + @equipo.name + '"'
			end
			render 'torneos/new'            
        end           
	end

end
