Feature: Seleccion de fecha para un partido 

	Background:
		Given que tengo ya creado el equipo "equipo1"
		And que tengo ya creado el equipo "equipo2"
		And un torneo "torneoA" con los equipos "equipo1" y "equipo2"

	Scenario: Creación exitosa de partido con fecha
		Given que no existan partidos
		When creo un partido para el "torneoA" con fecha "2014-07-20"
		And defino equipo local "equipo1"
		And defino equipo visitante "equipo2"
		And defino fecha "1"
		And creo el partido
		Then se visualiza el partido en el fixture

	Scenario: Creación fallida de partido con fecha
		Given que no existan partidos
		When creo un partido para el "torneoA" con fecha "2014-07-20"
		And defino equipo local "equipo1"
		And defino equipo visitante "equipo2"
		And defino fecha "1"
		And creo el partido
		And creo un partido para el "torneoA" con fecha "2014-07-20"
		And defino equipo local "equipo1"
		And defino equipo visitante "equipo2"
		And defino fecha "1"
		And creo el partido
		Then muestra un error que el partido ya existe
