class Nave {

	var property velocidad = 0

	method incrementarVelocidad(cantidad) {
		velocidad = (velocidad + cantidad).min(300000)
	}

	method propulsar() {
		self.incrementarVelocidad(20000)
	}

	method prepararParaViaje() {						///////4. Preparación para el viaje
		self.incrementarVelocidad(15000)
		self.accionAdicionalDePreparacion()
	}

	method accionAdicionalDePreparacion() {
	}

	method encontrarEnemigo() {
		self.recibirAmenaza()
		self.propulsar()
	}

	method recibirAmenaza()
}

class NaveDeCarga inherits Nave {

	var property carga = 0

	method sobrecargada() = carga > 100000

	method excedidaDeVelocidad() = velocidad > 100000

	method enFalta() = self.sobrecargada() and self.excedidaDeVelocidad()

	override method recibirAmenaza() {
		carga = 0
	}

	method acercamientoDeControl() {
		if (self.enFalta()) {
			self.recibirAmenaza()
		}
	}
}

class NaveDePasajeros inherits Nave {

	var property alarma = false
	const cantidadDePasajeros = 0

	method tripulacion() = cantidadDePasajeros + 4

	method velocidadMaximaPermitida() = 300000 / self.tripulacion() - if (cantidadDePasajeros > 100) 200 else 0

	method estaEnPeligro() = velocidad > self.velocidadMaximaPermitida() or alarma

	override method recibirAmenaza() {
		alarma = true
	}
}

class NaveDeCombate inherits Nave {

	var property modo = reposo
	const property mensajesEmitidos = []

	method emitirMensaje(mensaje) {
		mensajesEmitidos.add(mensaje)
	}

	method ultimoMensaje() = mensajesEmitidos.last()

	method estaInvisible() = velocidad < 10000 and modo.invisible()

	override method accionAdicionalDePreparacion() {			///////4. Preparación para el viaje
		modo.prepararParaViaje(self)
	}

	override method recibirAmenaza() {
		modo.recibirAmenaza(self)
	}
}
////////////////////3. Residuos radioactivos ////////////////////


class NaveDeResiduosRadioactivos inherits NaveDeCarga {

	var property selladoAlVacio = false

	override method accionAdicionalDePreparacion() { 						//4. Preparación para el viaje
		selladoAlVacio = true
	}

	override method recibirAmenaza() {
		velocidad = 0
	}

}

object reposo {

	method invisible() = false

	method recibirAmenaza(nave) {
		nave.emitirMensaje("¡RETIRADA!")
	}

	method prepararParaViaje(nave) {						//4. Preparación para el viaje
		nave.emitirMensaje("Saliendo en misión")
		nave.modo(ataque)
	}
}

object ataque {

	method invisible() = true

	method recibirAmenaza(nave) {
		nave.emitirMensaje("Enemigo encontrado")
	}

	method prepararParaViaje(nave) {
		nave.emitirMensaje("Volviendo a la base")
	}

}



