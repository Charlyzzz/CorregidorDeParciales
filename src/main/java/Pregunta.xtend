import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class Pregunta<T> {

	new(int valorPregunta2, String enunciado2, T respuestaCorrecta2, boolean importante, (Pregunta)=>int bloque) {

		this.valorPregunta = valorPregunta2
		this.enunciado = enunciado2
		this.respuestaCorrecta = respuestaCorrecta2
		this.bloquePuntajeIncorrecto = bloque
		this.esImportante = importante

	}

	Boolean esImportante
	(Pregunta)=>int bloquePuntajeIncorrecto
	int valorPregunta
	String enunciado

	T respuesta
	T respuestaCorrecta

	def corregir() {
		if (respuestaCorrecta == respuesta)
			valorPregunta
		else
			bloquePuntajeIncorrecto.apply(this)
	}

	def copiar() {
		new Pregunta(this.valorPregunta, this.enunciado, this.respuestaCorrecta,this.esImportante, this.bloquePuntajeIncorrecto)
	}

	def esCorrecta() {
		corregir == valorPregunta
	}
}

class PuntajeIncorrectoFactory {

	static def devuelveMenosUno() {
		[Pregunta p|-1]
	}

	static def devuelveCero() {
		[Pregunta p|0]
	}

	static def devuelveMitadValorTotal() {
		[Pregunta p|-(p.valorPregunta / 2)]
	}

}

 

