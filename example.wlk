object joaquin {

  const habilidadBase = 20
  var grupo = "Pimpinela"

  method habilidad() = if (self.estaEnGrupo()) habilidadBase + 5 else habilidadBase

  method estaEnGrupo() = not grupo.isEmpty()

  method interpretaBien(cancion) = cancion.duracion() > 300

  method cuantoCobra(presentacion) = if (presentacion.tocaSolo(self)) 100 else 50

  method abandonarGrupo() {
    grupo = ""
  }

}

object lucia {

  const habilidadBase = 70
  var grupo = "Pimpinela"
  /*
  interpreta bien unax canción que diga la palabra “familia” 
  (sin importar mayúsculas o minúsculas)
  cobra 500 pesos la presentación si es en un lugar concurrido 
  (cuya capacidad es mayor a 5.000 personas) o 400 en caso contrario
  */
  method habilidad() = if (self.estaEnGrupo()) habilidadBase - 20 else habilidadBase

  method estaEnGrupo() = not grupo.isEmpty()

  method interpretaBien(cancion) = cancion.contieneFrase("familia")

  method abandonarGrupo() {
    grupo = ""
  }

}

object luisAlberto {
  var guitarra = fender
  /*
  cobra 1.000 pesos por presentación hasta Noviembre del 2020, después cobra $ 1.200
  */
  method habilidad() = (8 * guitarra.valor()).min(100)
  method interpretaBien(cancion) = true
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

object bardo {
  method componer(duracion, unaLetra) = 
    object {
        const letra = unaLetra
        method duracion() = duracion
        method contieneFrase(frase) = letra.toLowerCase().contains(frase.toLowerCase())
    }
} 

object presentacionFactory {

  method crear(unaFecha, unLugar, unosInterpretes) = 
    object {
      const fecha = unaFecha
      const lugar = unLugar
      var interpretes = unosInterpretes

      method tocaSolo(interprete) = #{interprete} == interpretes

      method interpretes(nuevosInterpretes) {
        interpretes = nuevosInterpretes
      } 
    }

}

object lunaPark {

  method capacidad(fecha) = 9290

}

object laTrastienda {

  method capacidad(fecha) = 400 //400 o 400 + 300 ?
  
}