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
	    @partidos = Partido.all(:torneo_id => torneo_actual.id)
        render 'torneos/show'
	end

	post :create do
        @equipos = Equipo.all
		@torneo = Torneo.new
        @torneo.name = (params[:torneo][:name])
        if params[:crear]
			if @torneo.save
			  equipos_a_agregar.each do | equipo_name |
				@equipo = Equipo.first(:name => equipo_name)
			  	@puntaje = Puntaje.new
            	@puntaje.torneo = @torneo
           	 	@puntaje.equipo = @equipo
            	@puntaje.puntaje = 0
           	 	@puntaje.save
			  end
              borrar_equipos_a_agregar
			  flash[:success] = 'EL TORNEO FUE CREADO'
			  redirect '/'
			else
			  flash.now[:error] = 'NO SE PUDO CREAR EL TORNEO'
			  render 'torneos/new'
		    end
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
