programa LeguizamonLaura
procesos
  proceso calcularEsquinas(ES esquinas:numero)
  comenzar
    si (HayPapelEnLaEsquina)
      esquinas:=esquinas+1
  fin
  proceso pasar50(ES esquinas:numero; E avenida:numero)
  variables
    pasos:numero
    contador:numero
  comenzar
    contador:=0
    pasos:=0
    mientras (contador<50)
      Random(pasos,5,10)
      si (PosCa = 25)
        BloquearEsquina(avenida,25)
        mover
        juntarFlores
        mover
        LiberarEsquina(avenida,25)
      sino
        repetir pasos
          calcularEsquinas(esquinas)
          mover
          contador:=contador+1
  fin
  proceso juntarFlores
  comenzar
    mientras(HayFlorEnLaEsquina)
      tomarFlor
  fin
  proceso calle25
  comenzar
    Pos(1,25)
    derecha
    repetir 98
      si ((PosAv = 54) | (PosAv = 64))
        BloquearEsquina(PosAv+1,25)
        mover
        juntarFlores
        mover
        LiberarEsquina(PosAv+1,25)
      sino 
        juntarFlores
        mover
    juntarFlores
  fin
areas 
  Correador1: AreaPC(55,1,55,51)
  Correador2: AreaPC(65,1,65,51)
  AreaLimpiador: AreaPC(1,25,100,25)
  InicioJefe: AreaP(1,1,1,1)
robots
  robot corredor1
  variables 
    esquinas:numero
  comenzar
    pasar50(esquinas,55)
    EnviarMensaje(1,jefe)
    EnviarMensaje(esquinas,jefe)
  fin
  robot corredor2
  variables 
    esquinas:numero
  comenzar
    pasar50(esquinas,65)
    EnviarMensaje(2,jefe)
    EnviarMensaje(esquinas,jefe)
  fin
  robot limpiador
  comenzar
    calle25
  fin
  robot fiscalizador
  variables
    ID:numero
    esquinas:numero
  comenzar
    repetir 2
      RecibirMensaje(ID,*)
      si ID = 1
        RecibirMensaje(esquinas,c2)
        Informar('El_Ultimo_Corredor_En_Terminar_Fue_ ',2)
        Informar('Las_Esquinas_Con_Solo_Papeles_Fueron_ ',esquinas)
      sino
        RecibirMensaje(esquinas,c1)
        Informar('El_Ultimo_Corredor_En_Terminar_Fue_ ',1)
        Informar('Las_Esquinas_Con_Solo_Papeles_Fueron_ ',esquinas)
  fin  
variables
  c1:corredor1
  c2:corredor2
  L:limpiador
  jefe:fiscalizador
comenzar
  AsignarArea(jefe,InicioJefe)
  AsignarArea(L,AreaLimpiador)
  AsignarArea(c1,Correador1)
  AsignarArea(c2,Correador2)
  Iniciar(L,100,25)
  Iniciar(c1,55,1)
  Iniciar(c2,65,1)
  Iniciar(jefe,1,1)
fin