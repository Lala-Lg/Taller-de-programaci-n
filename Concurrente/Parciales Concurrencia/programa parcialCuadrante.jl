programa parcialCuadrante
procesos 
  proceso juntarFlores(ES f:numero) 
  comenzar 
    mientras(HayFlorEnLaEsquina)
      tomarFlor
      f:=f+1
  fin
  proceso juntarPapeles(ES p:numero) 
  comenzar 
    mientras(HayPapelEnLaEsquina)
      tomarPapel
      p:=p+1
  fin
areas
  cuadrante: AreaC(3,3,12,12)
  Ar1: AreaP(1,1,1,1)
  Ar2: AreaP(2,1,2,1)
  Ar3: AreaP(3,1,3,1)
  Ar4: AreaP(4,1,4,1)
  Ar5: AreaP(5,1,5,1)
  Ar6: AreaP(6,1,6,1)
  Ajefe: AreaP(7,1,7,1)
robots
  robot florero 
  variables 
    orCa:numero
    orAv:numero
    Ca:numero
    Av:numero
    f:numero
  comenzar
    f:=0 //IMPORTANTE NO OLVIDARMEEEEEEEEEEEEEEEEE POR CADA ROBOT INICIALIZO SINO NO SIRVE
    orCa:=PosCa
    orAv:=PosAv
    repetir 2
      Random(Ca,3,12)
      Random(Av,3,12)
      BloquearEsquina(Av,Ca)
      Pos(Av,Ca)
      juntarFlores(f)
      Pos(orAv,orCa)
      LiberarEsquina(Av,Ca)
    EnviarMensaje(f,jefe)
  fin

  robot papelero 
  variables 
    orCa:numero
    orAv:numero
    Ca:numero
    Av:numero
    p:numero
  comenzar
    p:=0
    orCa:=PosCa
    orAv:=PosAv
    repetir 3
      Random(Ca,3,12)
      Random(Av,3,12)
      BloquearEsquina(Av,Ca)
      Pos(Av,Ca)
      juntarPapeles(p)
      Pos(orAv,orCa)
      LiberarEsquina(Av,Ca)
    EnviarMensaje(p,jefe)
  fin

  robot buchon
  variables 
    f:numero
    p:numero
    cant:numero
  comenzar
    cant:=0
    repetir 3
      RecibirMensaje(f,*)
      si (f = 0)
        cant:= cant+1
    repetir 3
      RecibirMensaje(p,*)
      si (p = 0)
        cant:=cant+1
    Informar('La_Cantidad_De_Robots_Que_No_Juntaron_Nada_Fueron_',cant)
  fin

variables
  r1:florero
  r2:florero
  r3:florero
  r4:papelero
  r5:papelero
  r6:papelero
  jefe:buchon
comenzar 
  AsignarArea(r1,Ar1)
  AsignarArea(r2,Ar2)
  AsignarArea(r3,Ar3)
  AsignarArea(r4,Ar4)
  AsignarArea(r5,Ar5)
  AsignarArea(r6,Ar6)
  AsignarArea(jefe,Ajefe)
  AsignarArea(r1,cuadrante)
  AsignarArea(r2,cuadrante)
  AsignarArea(r3,cuadrante)
  AsignarArea(r4,cuadrante)
  AsignarArea(r5,cuadrante)
  AsignarArea(r6,cuadrante)
  Iniciar(r1,1,1)
  Iniciar(r2,2,1)
  Iniciar(r3,3,1)
  Iniciar(r4,4,1)
  Iniciar(r5,5,1)
  Iniciar(r6,6,1)
  Iniciar(jefe,7,1)
fin