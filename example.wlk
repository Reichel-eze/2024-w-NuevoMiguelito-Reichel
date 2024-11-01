class Comida {
  //var peso
  method peso()
  
  method esEspecial() = self.peso() > 250      // metodo general
  method esAptoCeliaco() 
  method valoracion()                   // indica que tan bueno es el plato

  method precio() = self.valoracion() * 300 + if(self.esAptoCeliaco()) 1200 else 0
}

class Provoleta inherits Comida {
  var peso
  var empanado 
 
  //method tieneEmpanado()

  override method peso() = peso

  override method esAptoCeliaco() = not(empanado) // Las provoletas son aptas para celíacos si no tienen empanado

  override method esEspecial() = super() and empanado 

  override method valoracion() = if(self.esEspecial()) 120 else 80 

}

class Hamburguesa inherits Comida {
  var pesoMedallon
  var pan             // puede ser industrial, casero o de maiz

  override method peso() = pesoMedallon + pan.peso()

  override method esAptoCeliaco() = pan.esAptoCeliaco() // la hamburguesa es celiaca segun el pan con el que esten hechas!!

  override method valoracion() = self.peso() / 10

  //override method esEspecial() = super()   // Nuevamente, se considera especial cuando su peso es mayor a 250 gramos. --> PUEDO PONERLO COMO EL METODO GENERAL EN COMIDA

}

/*
object industrial {
  method peso() = 60
  method esAptoCeliaco() = false 
}

object casero {
  method peso() = 100
  method esAptoCeliaco() = false 
}

object deMaiz {
  method peso() = 30
  method esAptoCeliaco() = true 
}
*/

// Lo puedo hacer asi, para si quiero crear mas panes en un futuro

class Pan {
  var property peso
  var property aptoCeliaco = false  // pongo false como generico
}

const industrial = new Pan (peso = 60)
const casero = new Pan (peso = 100)
const deMaiz = new Pan (peso = 30, aptoCeliaco = true)

class HamburguesaDoble inherits Hamburguesa {
  
  override method peso() = 2 * super() // porque tiene dos medallones de carne
  override method esEspecial() = self.peso() > 500
  // su valoracion se calcula como su peso / 10 (ES DECIR IGUAL QUE LA HAMBURGUESA SIMPLE)
}

class CorteDeCarne inherits Comida {
  var peso
  var property estadoDeCoccion = "aPunto"   // Puede ser jugoso, a punto o cocido.
  
  override method peso() = peso

  override method esEspecial() = super() and (estadoDeCoccion == "aPunto")

  override method esAptoCeliaco() = true

  override method valoracion() = 100

}

class Parrillada inherits Comida {
  const comidas = []  // esta compuesta por varias comidas

  override method peso() = comidas.sum({comida => comida.peso()}) 
  override method esEspecial() = super() and comidas.size() >= 3

  // Si alguna de las cosas que incluye no es apta para celíacos, la parrillada tampoco lo es. 
  override method esAptoCeliaco() = comidas.all({comida => comida.esAptoCeliaco()})
  
  // Su valoración es la mayor valoración de todo lo que la compone. 
  override method valoracion() = comidas.map({comida => comida.valoracion()}).max()

}

class Comensal {
  var dinero

  method leAgrada(comida)
  method darUnGusto() = miguelito.platoConMaximaValoracion()

  method pagar(comida) {
    dinero = dinero - comida.precio()
  }


}

class Celiaco inherits Comensal{
  override method leAgrada(comida) = comida.aptoCeliaco() 
}

class PaldarFino inherits Comensal{
  override method leAgrada(comida) = comida.esEspecial() or comida.valoracion() > 100
}

class TodoTerreno inherits Comensal{
  override method leAgrada(comida) = true   // todo les agrada 
}

object miguelito {
  const platos = []

  method platoConMaximaValoracion() = platos.map({plato => plato.valoracion()}).max() 
}