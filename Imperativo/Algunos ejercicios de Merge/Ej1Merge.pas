program Ej1Merge;
const 
    dimf = 12;
    valorGrande = 9999;
type
    rangoDia = 1..30;
    rangoMes = 1..12;
    f = record
          dia:rangoDia;
          mes:rangoMes;
          end;
    //Como el vector ordenará la información por mes, no hace falta guardarlo
    prestamoConMes = record
                      ISBN:integer;
                      numSocio:integer;
                      fecha:f;
                      cantDias:integer;
                      end;
    //Este registro nuevo será solo para guardar, el anterior, para leer.
    prestamo = record
                ISBN:integer;
                numSocio:integer;
                cantDias:integer;
                dia:rangoDia;
                end;
listaPrestamos = ^nodo;
nodo = record
        dato:prestamo;
        sig:listaPrestamos;
        end;
    
vectorMes = array [1..dimf] of listaPrestamos;

listaMerge = ^nodito;
nodito = record
         dato:prestamo;
         sig:listaMerge;
         end;

    prestamoAcumulador = record
                          ISBN:integer;
                          cantTotal:integer;
                          end;
listaAcumulador = ^nodon;
nodon = record
         dato:prestamoAcumulador;
         sig:listaAcumulador;
         end;

procedure cargarVector (var v:vectorMes);
//-- proceso encapsulado
procedure leerPrestamoConMes (var p:prestamoConMes);
begin
    p.ISBN:=random(30);
    //El random nunca elige -1 por eso puse que el corte sea 0
    if (p.ISBN <> 0) then begin
         p.numSocio:=random(300);
         p.fecha.dia:=random(30)+1;
         p.fecha.mes:=random(12)+1;
         p.cantDias:=random(90);
      end;
end;
//-- proceso encapsulado
procedure inicializarVector (var v: vectorMes);
   var i: integer;
   begin
     for i:= 1 to dimf do
        v [i]:= nil;
   end;
//-- proceso encapsulado
procedure insertarOrdenado(var l: listaPrestamos; p:prestamo);
   var ant, nuevo, act: listaPrestamos;
   begin
     new (nuevo);
     nuevo^.dato := p;
     act := l;
     {Recorro mientras no se termine la lista y no encuentro la posición correcta}
     while (act <> NIL) and (act^.dato.ISBN < p.ISBN) do begin
        ant := act;
        act := act^.sig ;
     end;
     if (act = l)  then l:= nuevo   {el dato va al principio}
                   else ant^.sig  := nuevo; {va entre otros dos o al final}
     nuevo^.sig := act ;
   end;
//-- proceso encapsulado
procedure copiarRegistro (var p:prestamo; pMes:prestamoConMes);
begin
  p.ISBN:=pMes.ISBN;
  p.numSocio:=pMes.numSocio;
  p.cantDias:=pMes.cantDias;
  p.dia:=pMes.fecha.dia;
end;
//-- cuerpo de cargarVector
var p: prestamo; pMes: prestamoConMes;
begin
  randomize;
  inicializarVector (v);
  leerPrestamoConMes (pMes);
   while (pMes.ISBN <> 0) do 
   begin
     copiarRegistro (p, pMes);
     insertarOrdenado (v[pMes.fecha.mes], p);
     leerPrestamoConMes (pMes);
   end;
end;

procedure imprimirVectorListas (v: vectorMes);
//-- proceso encapsulado
procedure imprimirLista(l: listaPrestamos);
  begin
     if (l <> nil) then 
     begin
        writeln('      ISBN: ', l^.dato.ISBN, '  Numero de socio: ', l^.dato.numSocio,' Dia: ',l^.dato.dia);
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
     writeln ('Mes ', i);
     if (v[i] = nil ) 
       then writeln ('En el mes ',i,' no hubo prestamos de libros.')
     else imprimirLista (v[i]);
  end;
end;
//-- Minimo para los MERGE
procedure minimo (var v: vectorMes; var prestamoMin: prestamo);
var indiceMin,i:integer;
begin
   //Esta bueno utilizar una constante para el valor con el que inicio el minimo en merge, así no hay error.
   prestamoMin.ISBN:= valorGrande;
   for i:= 1 to dimf do
   begin
       if (v[i] <> nil) then
            if (v[i]^.dato.ISBN <= prestamoMin.ISBN) 
            then begin
                   indiceMin:= i;
                   prestamoMin:= v[i]^.dato;  
            end; 
   end;
   if (prestamoMin.ISBN <> valorGrande) then
        v[indiceMin]:= v[indiceMin]^.sig;
end;
//-- MERGE
procedure Merge (v: vectorMes; var l: listaMerge; ult:listaMerge);
   
   procedure agregarAtras (var l, ult: listaMerge; p: prestamo); 
   var  nuevo: listaMerge;
   begin 
     new (nuevo); nuevo^.dato:= p; nuevo^.sig := nil;
     if (l = nil) then l:= nuevo
                  else ult^.sig := nuevo;
     ult := nuevo;
   end;

var prestamoMin: prestamo;
begin
   l:= nil;
   minimo (v, prestamoMin);
   while (prestamoMin.ISBN <> valorGrande) do
   begin
     agregarAtras(l, ult, prestamoMin);
     minimo (v, prestamoMin);
   end;
end;  

procedure imprimirEstructuraMerge (l: listaMerge);
//-- proceso encapsulado
procedure imprimirLista(l: listaMerge);
  begin
     if (l <> nil) then 
     begin
        writeln('      ISBN: ', l^.dato.ISBN, '  Numero de socio: ', l^.dato.numSocio,' Dia: ',l^.dato.dia);
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

procedure MergeAcumulador (v: vectorMes; var l: listaAcumulador; var ult:listaAcumulador);

   procedure agregarAtras2 (var l, ult: listaAcumulador; p:prestamoAcumulador); 
   var  nuevo: listaAcumulador;
   begin 
     new (nuevo); nuevo^.dato:= p; nuevo^.sig := nil;
     if (l = nil) then l:= nuevo
                  else ult^.sig := nuevo;
     ult := nuevo;
   end;

var prestamoMin: prestamo; 
    actual: prestamoAcumulador;
begin
  l:= nil;
  minimo (v, prestamoMin); 
  while (prestamoMin.ISBN <> valorGrande) do
  begin
    actual.ISBN:= prestamoMin.ISBN; actual.cantTotal:= 0;
    while (actual.ISBN = prestamoMin.ISBN) do
    begin
       actual.cantTotal:= actual.cantTotal + 1;
       minimo (v, prestamoMin);
    end;
    agregarAtras2 (l, ult, actual);
  end;
end;

procedure imprimirEstructuraMergeAcumulador (l: listaAcumulador);

  procedure imprimirListaAcumulador (l: listaAcumulador);
  begin
     if (l <> nil) then 
     begin
        writeln('      ISBN: ', l^.dato.ISBN, '  Cantidad prestamos: ', l^.dato.cantTotal);
        imprimirListaAcumulador (l^.sig);
     end;
  end;
  
begin
  writeln;
  writeln ('----- Estructura merge acumulador ----->');
  writeln;
  if (l = nil ) 
     then writeln ('      Sin elementos')
     else imprimirListaAcumulador (l);
end;


//-- Programa Principal
var v:vectorMes;lMerge,ultMerge:listaMerge;lAcumulador,ultAcumulador:listaAcumulador;
begin
  cargarVector(v);
  imprimirVectorListas(v);
  Merge(v,lMerge,ultMerge);
  imprimirEstructuraMerge(lMerge);
  MergeAcumulador(v,lAcumulador,ultAcumulador);
  imprimirEstructuraMergeAcumulador(lAcumulador);
end.