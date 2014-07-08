Feature: Agregar resultado a un partido no jugado

	Background:
		Given que tengo ya creado el equipo "equipo1"
		And que tengo ya creado el equipo "equipo2"
		And un torneo "torneoA" con los equipos "equipo1" y "equipo2"
        And que no existan partidos
		And creo un partido para el "torneoA" con fecha "2014-07-20"
		And defino equipo local "equipo1"
		And defino equipo visitante "equipo2"
        And defino fecha "1"
        And creo el partido

	Scenario: Creacion exitosa
		Given tengo un partido que no se jugo
		When completo el resultado del equipo local con "5"
		And completo el resultado del equipo visitante con "1"
		And se juega el partido
		Then se ve el partido con su resultado
		And se ve el equipo "equipo1" en la posicion "1" de la tabla

	Scenario: Creacion fallida por valor negativo
		Given tengo un partido que no se jugo
		When completo el resultado del equipo local con "-5"
        And completo el resultado del equipo visitante con "-3"
        And se juega el partido
		Then muestra error por cargar un valor negativo

	Scenario: Creacion fallida por campos vacios
		Given tengo un partido que no se jugo
		When se juega el partido
		Then muestra error por no completar los campos

	Scenario: Creacion fallida por caracter como resultado
		Given tengo un partido que no se jugo
		When completo el resultado del equipo local con "5"
		And completo el resultado del equipo visitante con "a"
		And se juega el partido
		Then muestra error por cargar un valor invalido
