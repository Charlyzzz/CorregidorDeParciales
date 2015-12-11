import java.util.ArrayList
import org.junit.Before
import org.eclipse.xtend.lib.annotations.Accessors
import org.junit.Assert
import org.junit.Test

class TestExamen {

	ExamenBuilder builder
	Alumno dante
	Alumno maggie

	@Before
	def setUp() {

		builder = new ExamenBuilder

		dante = new Alumno
		maggie = new Alumno
		
		

		val preguntaVoF = new Pregunta<Boolean>(2, ".>> <3 <<.", true, true, PuntajeIncorrectoFactory.devuelveCero)
		val preguntaMultipleChoice = new Pregunta<String>(10, "Quien es la trompeta más linda: *Trompeta, *Una caja",
			"Trompeta", false, PuntajeIncorrectoFactory.devuelveMenosUno)		

		val preguntas = new ArrayList<Pregunta>(#[preguntaVoF, preguntaMultipleChoice])
				
		builder.formaDeCalculo = new ReglaDeTres
		builder.preguntas = preguntas
		builder.notaMinima = 4
		
		maggie.parcial = builder.buildear
		dante.parcial = builder.buildear
	}
	
	@Test
	def testMaggieApruebaYDanteNoPorqueNoContestaLaImportante(){
		
		dante.responder(2,"etiopia")
		
		maggie.responder(1,true)
		maggie.responder(2,"Trompeta")
		
		Assert.assertEquals(dante.aprobo,false)
		Assert.assertEquals(maggie.aprobo,true)		
	}

}


@Accessors
class Alumno {

	Examen parcial
		
	def responder(int numeroDePregunta, String respuesta){
		parcial.preguntas.get(numeroDePregunta-1).respuesta = respuesta
	}
	
	def responder(int numeroDePregunta, boolean respuesta){
		parcial.preguntas.get(numeroDePregunta-1).respuesta = respuesta
	}
	
	def aprobo(){
		parcial.estaAprobado
	}

}


