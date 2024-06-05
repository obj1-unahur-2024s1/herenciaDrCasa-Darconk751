import enfermedades.*

class Persona {
	const enfermedadesContraidas = []
	var property celulas
	var temperatura = 0
	
	method temperatura() = temperatura
	method enfermedadesContraidas() = enfermedadesContraidas
	method contraerEnfermedad(unaEnfermedad){
		if (enfermedadesContraidas.size() <= 5)
			enfermedadesContraidas.add(unaEnfermedad)
	}
	method aumentarTemperatura(aumentoDeTemperatura){
		temperatura = 45.min(temperatura + aumentoDeTemperatura)
	}
	method destruirCelulas(cantidadDeCelulasDestriudas){
		celulas = 0.max(celulas - cantidadDeCelulasDestriudas)
	}
	method pasarUnDia(){
		enfermedadesContraidas.forEach({enfermedad => enfermedad.producirEfecto(self)})
	}
	method cantidadDeCelulasAmenazadasPorEnfermedadesAgresivas() = enfermedadesContraidas.filter({enfermedad => enfermedad.esAgresiva(self)}).sum({enfermedad => enfermedad.celulasAmenazadas()})
	method enfermedadQueMasCelulasAfecta() = enfermedadesContraidas.max({enfermedad => enfermedad.celulasAmenazadas()})
	method estaEnComa() = self.temperatura() == 45 or self.celulas() < 1000000
	method atenuarEnfermedadesCon(dosis){
		enfermedadesContraidas.forEach({enfermedad => enfermedad.atenuarEnfermedad(dosis * 15)})
		enfermedadesContraidas.removeAll(enfermedadesContraidas.filter({enfermedad => enfermedad.estaCurado()}))
	}
	method temperaturaMortalFATALITY(){
		temperatura = 0
	}
}

class Medico inherits Persona {
	var dosis
	
	method atender(unaPersona){
		unaPersona.atenuarEnfermedadesCon(dosis)
	}
	
	override method contraerEnfermedad(unaEnfermedad){
		super(unaEnfermedad)
		self.atender(self)
	}
}

class JefeMedico inherits Medico {
	const medicos = []
	
	method medicos() = medicos
	method contratarAMedico(unMedico){
		medicos.add(unMedico)
	}
	method elJefeAntiendeA(unaPersona){
		unaPersona.atenuarEnfermedadesCon(dosis)
	}
	override method atender(unaPersona){
		medicos.anyOne().atender(unaPersona)	
	}
	
	/*Tengo mis dudas respecto a esto porque para forzar que la muerte haga su efecto de matar a House pues no tiene que poder automedicarse, tuve que forzar la solucion pero no le encuentro otra forma, faltaba especificar mas yo creo*/
	override method contraerEnfermedad(unaEnfermedad){
		enfermedadesContraidas.add(unaEnfermedad)
	}
}