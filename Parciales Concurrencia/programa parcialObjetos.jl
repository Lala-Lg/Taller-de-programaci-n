programa parcialObjetos
procesos
  proceso juntarObjetos(ES objetos:numero)
  comenzar
    mientras(HayFlorEnLaEsquina)
      tomarFlor
      objetos:=objetos+1
    mientras(HayPapelEnLaEsquina)
      tomarPapel
      objetos:=objetos+1
  fin
  proceso depositarFlores
  comenzar
    si(HayFlorEnLaBolsa)
      depositarFlor
  fin
  proceso UnPapelMaximo
  comenzar 
    si (HayPapelEnLaEsquina)
      tomarPapel
  fin
  proceso Calle3
  comenzar 
    derecha
    repetir 93
      si((PosAv = 4) | (PosAv = 9) | (PosAv = 14)| (PosAv = 7) | (PosAv = 12) | (PosAv =17))
        BloquearEsquina(PosAv+1,PosCa)
        mover 
        UnPapelMaximo
        mover
        LiberarEsquina(PosAv - 1,PosCa)
      sino
        UnPapelMaximo
        mover
  fin
  proceso recorrido (ES objetos:numero)
  variables 
    alto:numero
    base:numero
  comenzar
    base:=3
    Random(alto,5,60)
    repetir (alto - 3)
      si (PosCa = 2)
        BloquearEsquina(PosAv+1,PosCa)
        mover 
        UnPapelMaximo
        mover
        LiberarEsquina(PosAv - 1,PosCa)
      sino 
        juntarObjetos(objetos)
        mover
    derecha
    repetir base
      juntarObjetos(objetos)
      mover
    derecha
    repetir (alto - 3)
      si (PosCa = 4)
        BloquearEsquina(PosAv - 1,PosCa)
        mover 
        UnPapelMaximo
        mover
        LiberarEsquina(PosAv+1,PosCa)
      sino
        juntarObjetos(objetos)
        mover
    derecha
    repetir base 
      juntarObjetos(objetos)
      mover
    derecha
  fin
areas 
  encuentro: AreaPC(61,61,61,61)
  rectangulo1:AreaP(5,1,8,100)
  rectangulo2:AreaP(10,1,13,100)
  rectangulo3:AreaP(15,1,18,100)
  rectangulo4: AreaP(1,3,100,3)
  inicioJ: AreaP(1,1,1,1)
robots

  robot r1
  variables 
    objetos:numero
    id:numero
    ir:numero
    ir2:numero
    ca:numero
    av:numero
  comenzar
    ca:=PosCa
    av:=PosAv
    id:=1
    recorrido(objetos)
    EnviarMensaje(id,robotJ)
    EnviarMensaje(objetos,robotJ)
    RecibirMensaje(ir,robotJ)
    RecibirMensaje(ir2,robotJ)
    si (id = ir)
      mientras (HayFlorEnLaBolsa)
        BloquearEsquina(61,61)
        Pos(61,61)
        depositarObjetos
        Pos(av,ca)
        LiberarEsquina(61,61)
    sino
      si(id = ir2)
        mientras (HayFlorEnLaBolsa)
          BloquearEsquina(61,61)
          Pos(61,61)
          depositarObjetos
          Pos(av,ca)
          LiberarEsquina(61,61)
  fin
  
  robot r2
  variables 
    objetos:numero
    ca:numero
    av:numero
    id:numero
    ir:numero
    ir2:numero
  comenzar
    id:=2
    ca:=PosCa
    av:=PosAv
    recorrido(objetos)
    EnviarMensaje(id,robotJ)
    EnviarMensaje(objetos,robotJ)
    RecibirMensaje(ir,robotJ)
    RecibirMensaje(ir2,robotJ)
    si (id = ir)
      mientras (HayFlorEnLaBolsa)
        BloquearEsquina(61,61)
        Pos(61,61)
        depositarObjetos
        Pos(av,ca)
        LiberarEsquina(61,61)
    sino
      si(id = ir2)
        mientras (HayFlorEnLaBolsa)
          BloquearEsquina(61,61)
          Pos(61,61)
          depositarObjetos
          Pos(av,ca)
          LiberarEsquina(61,61)
  fin
  
  robot r3
  variables 
    objetos:numero
    id:numero
    ir:numero
    ir2:numero
    ca:numero
    av:numero
  comenzar
    ca:=PosCa
    av:=PosAv
    id:=3
    recorrido(objetos)
    EnviarMensaje(id,robotJ)
    EnviarMensaje(objetos,robotJ)
    RecibirMensaje(ir,robotJ)
    RecibirMensaje(ir2,robotJ)
    si (id = ir)
      mientras (HayFlorEnLaBolsa)
        BloquearEsquina(61,61)
        Pos(61,61)
        depositarObjetos
        Pos(av,ca)
        LiberarEsquina(61,61)
    sino
      si(id = ir2)
        mientras (HayFlorEnLaBolsa)
          BloquearEsquina(61,61)
          Pos(61,61)
          depositarObjetos
          Pos(av,ca)
          LiberarEsquina(61,61)
  fin

  robot callejero
  comenzar
    Calle3
  fin

  robot jefe
  variables
    objetos:numero
    maximo1:numero
    maximo2:numero
    id:numero
    idmax1:numero
    idmax2:numero
  comenzar
    maximo1:=-1
    maximo2:=-2
    repetir 3
      RecibirMensaje(id,*)
      si(id = 1) 
        RecibirMensaje(objetos,robot1) 
      sino 
        si (id = 2) 
          RecibirMensaje(objetos,robot2) 
        sino 
          si (id = 3)
            RecibirMensaje(objetos,robot3)
      si(maximo1 <= objetos)
        maximo2:=maximo1
        idmax2:=idmax1
        maximo1:=objetos
        idmax1 := id 
      sino
        si(maximo2 <= objetos)
          maximo2:=objetos
          idmax2:= id
    
    EnviarMensaje(idmax1,robot1)
    EnviarMensaje(idmax1,robot2)
    EnviarMensaje(idmax1,robot3)
    EnviarMensaje(idmax2,robot1)
    EnviarMensaje(idmax2,robot2)
    EnviarMensaje(idmax2,robot3)
      
  fin
variables
  robot1: r1
  robot2: r2
  robot3: r3
  robotC: callejero
  robotJ: jefe
comenzar 
  AsignarArea(robot1,rectangulo1)
  AsignarArea(robot2,rectangulo2)
  AsignarArea(robot3,rectangulo3)
  AsignarArea(robotC,rectangulo4)
  AsignarArea(robot1,encuentro)
  AsignarArea(robot2,encuentro)
  AsignarArea(robot3,encuentro)
  AsignarArea(robotJ,inicioJ)
  Iniciar(robot1,5,1)
  Iniciar(robot2,10,1)
  Iniciar(robot3,15,1)
  Iniciar(robotC,1,3)
  Iniciar(robotJ,1,1)
fin