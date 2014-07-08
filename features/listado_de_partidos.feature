Feature: Listado de Partidos
    Background:
        Given que tengo ya creado el equipo "equipo1"
	    And que tengo ya creado el equipo "equipo2"
	    And un torneo "torneoA" con los equipos "equipo1" y "equipo2"


    Scenario: Listado de Partidos
        Given que no existan partidos
        When creo un partido para el "torneoA" con fecha "2014-07-20"
        And defino equipo local "equipo1"
        And defino equipo visitante "equipo2"
        And defino fecha "1"
        And creo el partido
        When creo un partido para el "torneoA" con fecha "2014-07-21"
        And defino equipo local "equipo1"
        And defino equipo visitante "equipo2"
        And defino fecha "1"
        And creo el partido
        Then se visualizan los partidos en el fixture

    Scenario: No existen partidos
        Given que no existan partidos
        Then la lista de partidos esta vacia
