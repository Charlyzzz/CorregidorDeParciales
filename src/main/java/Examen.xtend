import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors
import java.util.ArrayList

@Accessors
class Examen {

	List<Pregunta> preguntas
	CalculoNota formaDeCalculo

	int notaMinima

	def calcularNota() {

		formaDeCalculo.calcularNota(this)
	}

	def estaAprobado() {
		calcularNota >= notaMinima && contestoTodasLasPreguntasImportantes()
	}

	def contestoTodasLasPreguntasImportantes() {
		preguntasImportantes.forall[esCorrecta]

	}

	def preguntasImportantes() {
		preguntas.filter[esImportante]
	}

	def puntosResueltos() {
		preguntas.map[corregir].reduce[numero, suma|numero + suma]
	}

	def puntosTotales() {
		preguntas.map[valorPregunta].reduce[numero, suma|numero + suma]
	}
}

@Accessors
class ExamenBuilder {

	int notaMinima
	CalculoNota formaDeCalculo

	ArrayList<Pregunta> preguntas

	def buildear() {

		val nuevoExamen = new Examen

		nuevoExamen.notaMinima = notaMinima
		nuevoExamen.formaDeCalculo = formaDeCalculo
		nuevoExamen.preguntas = copiarPreguntas()

		nuevoExamen
	}

	def copiarPreguntas() {

		val nuevasPreguntas = new ArrayList<Pregunta>

		preguntas.forEach[pregunta|nuevasPreguntas.add(pregunta.copiar)]

		nuevasPreguntas

	}

}