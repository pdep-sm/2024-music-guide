// Iteracion 2
class MusicoDeGrupo {
  const property aumentoHabilidadEnGrupo

  method diferenciaDeHabilidad() = self.aumentoHabilidadEnGrupo()
  method interpretaBien(cancion) = cancion.duracion() > 300
  method cuantoCobra(presentacion, musico) = if (presentacion.tocaSolo(musico)) 100 else 50
}

class MusicoVocalistaPopular {
  const palabraClave
  const property diferenciaDeHabilidad = -20

  method interpretaBien(cancion) = cancion.contieneFrase(palabraClave)
  method cuantoCobra(presentacion, musico) = if (presentacion.enLugarConcurrido()) 500 else 400
}

class Musico {
  var habilidadBase
  var estiloDeMusico
  const albumes = #{}
  var grupo

  method habilidad() = 
    if (self.estaEnGrupo()) habilidadBase + estiloDeMusico.diferenciaDeHabilidad() 
    else habilidadBase

  method estaEnGrupo() = not grupo.isEmpty()
  method abandonarGrupo() {
    grupo = ""
  }
  method interpretaBien(cancion) = estiloDeMusico.interpretaBien(cancion)
  method cuantoCobra(presentacion) = estiloDeMusico.cuantoCobra(presentacion, self)
}

// Iteracion 1

object luisAlberto {
  var guitarra = fender
  const fechaLimite = new Date(year=2020, month=12, day=1)
  /*
  cobra 1.000 pesos por presentación hasta Noviembre del 2020, después cobra $ 1.200
  */
  method habilidad() = (8 * guitarra.valor()).min(100)
  method interpretaBien(cancion) = true
  method cuantoCobra(presentacion) = if (presentacion.esAntesDe(fechaLimite)) 1000 else 1200
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

      method enLugarConcurrido() = lugar.capacidad(fecha) > 5000

      method esAntesDe(unaFecha) = fecha < unaFecha

      method costo() = interpretes.sum{ 
        interprete => interprete.cuantoCobra(self)
      }

      method interpretes(nuevosInterpretes) {
        interpretes = nuevosInterpretes
      } 
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