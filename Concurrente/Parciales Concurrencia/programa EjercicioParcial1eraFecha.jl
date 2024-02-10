programa EjercicioParcial
procesos
  proceso juntarFlores(ES flor:numero)
  comenzar
    mientras (HayFlorEnLaEsquina)
      tomarFlor
      flor:=flor+1
  fin    
  proceso esquinaAleatoria(E oportunidades:numero;ES f:numero)
  variables
    Av:numero  
    Ca:numero
    AvI:numero
    CaI:numero
  comenzar
    AvI:=PosAv
    CaI:=PosCa
    repetir oportunidades
      Random(Av,3,23)
      Random(Ca,3,33)
      BloquearEsquina (Av,Ca)
      Pos(Av,Ca)
      juntarFlores(f)
      Pos (AvI,CaI)
      LiberarEsquina(Av,Ca)
  fin
areas
  rectangulo: AreaPC(3,3,23,33)
  inicioflorero1: AreaP(1,2,1,2)
  inicioflorero2: AreaP(1,3,1,3)
  iniciocoordinador: AreaP(1,1,1,1)
robots 
  robot florero1
  variables
    oportunidades:numero
    flor:numero
    exito:boolean
  comenzar
    RecibirMensaje(oportunidades,jefe)
    esquinaAleatoria(oportunidades,flor)
    EnviarMensaje(1,jefe)
    EnviarMensaje(flor,jefe)
    RecibirMensaje(exito,jefe)
    si (exito) 
      Pos(3,3)
  fin
  robot florero2
  variables
    oportunidades,flor:numero
    exito:boolean
  comenzar
    RecibirMensaje(oportunidades,jefe)
    esquinaAleatoria(oportunidades,flor)
    EnviarMensaje(2,jefe)
    EnviarMensaje(flor,jefe)
    RecibirMensaje(exito,jefe)
    si (exito) 
      Pos(3,3)
  fin
  robot coordinador
  variables
    oportunidades:numero
    flores,id,floresmin,idmax:numero
  comenzar
    floresmin:=100
    Random(oportunidades,3,8)
    EnviarMensaje(oportunidades,robot1)
    Random(oportunidades,3,8)
    EnviarMensaje(oportunidades,robot2)
    repetir 2
      RecibirMensaje(id,*)
      si(id = 1) 
        RecibirMensaje(flores,robot1) 
      sino 
        si (id = 2) 
          RecibirMensaje(flores,robot2) 
      si(flores <= floresmin)
        floresmin:= flores
        idmax := id 
    Informar(floresmin) 
    Informar(idmax)
    si (idmax = 1)
      EnviarMensaje(V,robot1)
      EnviarMensaje(F,robot2)
    sino 
      EnviarMensaje(V,robot2)
      EnviarMensaje(F,robot1)
  fin     
variables 
  robot1: florero1
  robot2: florero2
  jefe: coordinador
comenzar 
  AsignarArea(robot1,inicioflorero1)
  AsignarArea(robot2,inicioflorero2)
  AsignarArea(jefe,iniciocoordinador)
  AsignarArea(robot1,rectangulo)
  AsignarArea(robot2,rectangulo)
  Iniciar(robot1,1,2)
  Iniciar(robot2,1,3)
  Iniciar(jefe,1,1)
fin