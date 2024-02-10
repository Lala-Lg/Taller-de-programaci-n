program Ej2Merge;
const dimf = 8; valorGrande = 9999;
type
  genero = 1..8;
  peli = record
             codPeli:integer;
             codGenero:genero;
             puntaje:real;
             end;
  pelicula = record
             codPeli:integer;
             puntaje:real;
             end;

lista = ^nodo;
nodo = record
        dato:pelicula;
        sig:lista;
        end;
        
lista2 = ^nodito;
nodito = record
         dato:pelicula;
         sig:lista2;
         end;

porGenero = array [1..dimf] of lista;

procedure cargarVector (var v:porGenero);
procedure leerPelicula(var p:peli);
begin
  with p do begin
    codPeli := random(20);
    if (codPeli <> 0)  then begin
      codGenero:= random(8) + 1;
      puntaje:= random (10) + 1;
      end;
  end;
end;
procedure inicializarVector (var v: porGenero);
   var i: integer;
   begin
     for i:= 1 to dimf do
        v [i]:= nil;
   end;
procedure insertarOrdenado (var l:lista; p:pelicula);
var ant, nuevo, act: lista;
   begin
     new (nuevo);
     nuevo^.dato := p;
     act := l;
     {Recorro mientras no se termine la lista y no encuentro la posición correcta}
     while (act <> NIL) and (act^.dato.codPeli < p.codPeli) do begin
        ant := act;
        act := act^.sig ;
     end;
     if (act = l)  then l:= nuevo   {el dato va al principio}
                   else ant^.sig  := nuevo; {va entre otros dos o al final}
     nuevo^.sig := act ;
   end;
var p: pelicula; p2:peli;
begin
  randomize;
  inicializarVector (v);
  leerPelicula(p2);
  p.codPeli:=p2.codPeli;
  p.puntaje:=p2.puntaje;
   while (p.codPeli <> 0) do 
   begin
     insertarOrdenado (v[p2.codGenero], p);
     leerPelicula(p2);
     p.codPeli:=p2.codPeli;
     p.puntaje:=p2.puntaje;
   end;
end;

procedure imprimirVectorListas (v: porGenero);
//-- proceso encapsulado
procedure nombreGenero (i:genero);
begin
  case i of 
  1: writeln('Genero acción'); 
  2: writeln('Genero aventura');
  3: writeln('Genero drama');
  4: writeln('Genero suspenso');
  5: writeln('Genero comedia');
  6: writeln('Genero bélica');
  7: writeln('Genero documental');
  8: writeln('Genero terror');
  end;
end;
//-- proceso encapsulado
procedure imprimirLista(l: lista);
  begin
     if (l <> nil) then 
     begin
        writeln('      Codigo de pelicula: ', l^.dato.codPeli, '  Puntaje promedio: ',l^.dato.puntaje:1:1);
        imprimirLista (l^.sig);
     end;
  end;
//-- Cuerpo de imprimirVectorListas
var i: integer;
begin
  writeln;
  writeln ('----- Vector de los prestamos, por mes. ----->');
  writeln;
  for i:= 1 to dimf do
  begin
     writeln;
     nombreGenero(i);
     if (v[i] = nil ) 
       then  begin 
              writeln ('No se encontraron peliculas para este genero');
              end
     else imprimirLista (v[i]);
  end;
end;

procedure minimo (var v: porGenero; var min: pelicula);
var indiceMin,i:integer;
begin
   //Esta bueno utilizar una constante para el valor con el que inicio el minimo en merge, así no hay error.
   min.codPeli:= valorGrande;
   for i:= 1 to dimf do
   begin
       if (v[i] <> nil) then
            if (v[i]^.dato.codPeli <= min.codPeli) 
            then begin
                   indiceMin:= i;
                   min:= v[i]^.dato;  
            end; 
   end;
   if (min.codPeli <> valorGrande) then
        v[indiceMin]:= v[indiceMin]^.sig;
end;

procedure Merge (v: porGenero; var l: lista2; var ult: lista2);
   
   procedure agregarAtras (var l, ult: lista2; p: pelicula); 
   var  nuevo: lista2;
   begin 
     new (nuevo); nuevo^.dato:= p; nuevo^.sig := nil;
     if (l = nil) then l:= nuevo
                  else ult^.sig := nuevo;
     ult := nuevo;
   end;

var min:pelicula;
begin
   l:= nil;
   minimo (v, min);
   while (min.codPeli <> valorGrande) do
   begin
     agregarAtras(l, ult, min);
     minimo (v, min);
   end;
end;  

procedure imprimirEstructuraMerge (l: lista2);
//-- proceso encapsulado
procedure imprimirLista(l: lista2);
  begin
     if (l <> nil) then 
     begin
        writeln('      Codigo de pelicula: ', l^.dato.codPeli, '  Puntaje promedio: ',l^.dato.puntaje:1:1);
        imprimirLista (l^.sig);
     end;
  end;
//-- cuerpo de imprimirEstructuraMerge
begin
   writeln;
   writeln ('----- Estructura merge ----->');
   writeln;
   if (l = nil ) 
     then writeln ('      Sin elementos')
     else imprimirLista (l);
end;


//Programa principal
var v:porGenero; l:lista2; ult:lista2;
begin
  cargarVector(v);
  imprimirVectorListas(v);
  Merge(v,l,ult);
  imprimirEstructuraMerge(l);
end.