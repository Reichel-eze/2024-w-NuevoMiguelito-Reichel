class Comida {
  //var valoracion
  
  //method esEspecial()
  method esAptoCeliaco() 
  method valoracion()

  method precio() = self.valoracion() * 300 + if(self.esAptoCeliaco()) 1200 else 0
}

class Provoleta inherits Comida {
  var peso
  var empanado 
 
  method tieneEmpanado()
  override method esAptoCeliaco() = not(empanado)

  method esEspecial() = peso > 250 and empanado 

  override method valoracion() = if(self.esEspecial()) 120 else 80 

}

class Hamburguesa inherits Comida {
  var pesoMedallon
  var pan             // puede ser industrial, casero o de maiz

  method peso() = pesoMedallon + pan.peso()

  override method esAptoCeliaco() = pan.esAptoCeliaco() // la hamburguesa es celiaca segun el pan utilizado!!

  override method valoracion() = self.peso() / 10

  method esEspecial() = self.peso() > 250
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

// Lo puedo hacer asi, para si quiero crear mas panes

class Pan {
  var property peso
  var property aptoCeliaco = false  // pongo false como generico
}

const industrial = new Pan (peso = 60)
const casero = new Pan (peso = 100)
const deMaiz = new Pan (peso = 30, aptoCeliaco = true)

