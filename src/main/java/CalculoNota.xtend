import java.util.HashMap
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

interface CalculoNota {

	def int calcularNota(Examen examen)
}

class RestarNPuntos implements CalculoNota {

	int puntosResta

	override calcularNota(Examen examen) {

		examen.puntosResueltos - puntosResta
	}

}

class ReglaDeTres implements CalculoNota {

	override calcularNota(Examen examen) {

		examen.puntosResueltos * 10 / examen.puntosTotales
	}

}

class Tabla implements CalculoNota {

	HashMap<Integer, Integer> tablaNotas

	override calcularNota(Examen examen) {
		tablaNotas.get(examen.puntosResueltos)
	}
}

class CriteriosNotaMasAlta implements CalculoNota {

	List<CalculoNota> criterios

	override calcularNota(Examen examen) {
		criterios.map[calcularNota(examen)].max
	}

}

class CriterioPromedio implements CalculoNota {

	List<CalculoNota> criterios

	override calcularNota(Examen examen) {
		criterios.map[calcularNota(examen)].reduce[numero, suma|numero + suma] / criterios.size
	}

}

























