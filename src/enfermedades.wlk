import personas.*

class Enfermedad {
	var celulasAmenazadas
	
	method celulasAmenazadas() = celulasAmenazadas
	method atenuarEnfermedad(cantidadDeDosis){
		celulasAmenazadas = 0.max(celulasAmenazadas - cantidadDeDosis)
	}
	method estaCurado() = self.celulasAmenazadas() == 0
}

class EnfermedadInfecciosa inherits Enfermedad {
	method producirEfecto(unaPersona){
		unaPersona.aumentarTemperatura(celulasAmenazadas/1000)
	}
	method reproducir(){
		celulasAmenazadas = celulasAmenazadas * 2
	}
	method esAgresiva(unaPersona) = celulasAmenazadas >= unaPersona.celulas() * 0.1
}

class EnfermedadAutoInmune inherits Enfermedad {
	var cantidadDeDiasConEfectoDeEnfermedad = 0
	method producirEfecto(unaPersona){
		unaPersona.destruirCelulas(celulasAmenazadas)
		cantidadDeDiasConEfectoDeEnfermedad += 1
	}
	method esAgresiva(unaPersona) = cantidadDeDiasConEfectoDeEnfermedad > 30
}

object muerte {
	method atenuarEnfermedad(dosis){}
	method estaCurado() = false
	method producirEfecto(unaPersona){
		unaPersona.temperaturaMortalFATALITY()
	}
	method esAgresiva() = true
}