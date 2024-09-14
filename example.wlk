class Musico {
  const habilidadBase
  const property albumes = #{}
  var property grupo
  const property diferenciaDeHabilidad  

  method habilidad() = 
    if (self.estaEnGrupo()) habilidadBase + self.diferenciaDeHabilidad() 
    else habilidadBase
  /*
  Todos los músicos interpretan bien las canciones de su autoría
  Todos los músicos con habilidad mayor a 60 ejecutan bien cualquier canción
  */
  method interpretaBien(cancion) = self.esAutorDe(cancion) or self.esMuyHabil()

  method esAutorDe(cancion) = cancion.autor() == self
  method esMuyHabil() = self.habilidad() > musico.habilidadOptima()
  
  method cuantoCobra(presentacion) 

  method estaEnGrupo() = not grupo.isEmpty()
  method abandonarGrupo() {
    grupo = ""
  }
}
object musico {
  var property habilidadOptima = 60
}

class MusicoDeGrupo inherits Musico {
  override method interpretaBien(cancion) = 
    super(cancion) or cancion.duracion() > 300
  override method cuantoCobra(presentacion) = if (presentacion.tocaSolo(self)) 100 else 50
}

class MusicoVocalistaPopular inherits Musico(diferenciaDeHabilidad = -20) {
  const palabraClave

  override method interpretaBien(cancion) = cancion.contieneFrase(palabraClave)
  override method cuantoCobra(presentacion) = if (presentacion.enLugarConcurrido()) 500 else 400
}


// Iteracion 1

object luisAlberto inherits Musico(habilidadBase = 8, grupo = "", diferenciaDeHabilidad = 0){
  var guitarra = fender
  const fechaLimite = new Date(year=2020, month=12, day=1)
  /*
  cobra 1.000 pesos por presentación hasta Noviembre del 2020, después cobra $ 1.200
  */
  override method habilidad() = (habilidadBase * guitarra.valor()).min(100)
  override method interpretaBien(cancion) = true
  override method cuantoCobra(presentacion) = if (presentacion.esAntesDe(fechaLimite)) 1000 else 1200
  method guitarra(nuevaGuitarra) {
    guitarra = nuevaGuitarra
  }
}

object fender {
  method valor() = 10
}
object gibson {
  var estaSana = true
  method valor() = if (estaSana) 15 else 5
  method romper() {
    estaSana = false
  }
}

class Cancion {
  const letra
  const property duracion
  const property autor

  method contieneFrase(frase) = letra.toLowerCase().contains(frase.toLowerCase())
}

class Presentacion {
  const fecha
  const lugar
  var interpretes

  method tocaSolo(interprete) = #{interprete} == interpretes

  method enLugarConcurrido() = lugar.capacidad(fecha) > 5000

  method esAntesDe(unaFecha) = fecha < unaFecha

  method costo() = interpretes.sum{ 
    interprete => interprete.cuantoCobra(self)
  }

  method interpretes(nuevosInterpretes) {
    interpretes = nuevosInterpretes
  } 
}

object lunaPark {
  method capacidad(fecha) = 9290
}

object laTrastienda {
  const capacidadBase = 400

  method capacidad(fecha) = capacidadBase + self.extraPorFecha(fecha) 
  method extraPorFecha(fecha) = if (fecha.dayOfWeek()=="saturday") 300 else 0
}