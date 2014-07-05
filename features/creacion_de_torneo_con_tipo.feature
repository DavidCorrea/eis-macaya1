Feature: Creación exitosa de un torneo de ida/ida y vuelta

	Background:
                Given no existen torneos
		And que tengo ya creado el equipo "equipo1"
		And que tengo ya creado el equipo "equipo2"
		And que tengo ya creado el equipo "equipo3"
		And que tengo ya creado el equipo "equipo4"
 
	Scenario: Creación de torneo ida exitosa
		Given quiero crear un torneo con nombre "prueba"
		And agrego al "equipo1" 
		And agrego al "equipo2"
		And agrego al "equipo3"
		And agrego al "equipo4"
		And elijo que sea solo con partidos de ida
		Then el torneo "prueba" se crea exitosamente y tiene "3" fechas.

	Scenario: Creación de torneo ida y vuelta exitosa
		Given quiero crear un torneo con nombre "prueba2"
		And agrego al "equipo1"
		And agrego al "equipo2"
		And agrego al "equipo3"
		And agrego al "equipo4"
		And elijo que sea solo con partidos de ida y vuelta
		Then el torneo "prueba2" se crea exitosamente y tiene "6" fechas.
