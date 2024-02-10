program adicional_2;
type 
  rango = 2010..2018;
  auto = record
           patente:string;
           anioFabricacion:rango;
           marca:string;
           modelo:string;
           end;
  arbol = ^nodo;
  nodo = record
           hi:arbol;
           hd:arbol;
           dato:auto;
         end;
  lista = ^nodito;
  nodito = record
            sig:lista;
            dato:auto;
           end;
  vector = array [rango] of lista;

procedure cargarArbol (var a:arbol);
//---------------------------------------------------------//
procedure lecturaAutos(var a:auto);
begin
  with a do begin
    writeln('Patente: ');
    readln(patente);
    if(patente <> '000') then begin
      writeln('Anio de fabricacion: ');
      readln(anioFabricacion);
      writeln('Marca: ');
      readln(marca);
      writeln('Modelo: ');
      readln(modelo);
      writeln('');
    end;
  end;
end;
//---------------------------------------------------------//
procedure insertarHoja(var a:arbol;auto:auto);
begin
  if (a = nil) then begin
    new(a);
    a^.dato:=auto;
    a^.hi:=nil;
    a^.hd:=nil;
  end
  else begin if (auto.patente < a^.dato.patente) then 
               insertarHoja(a^.hi,auto)
             else if (auto.patente > a^.dato.patente) then 
                    insertarHoja(a^.hd,auto);
       end;
end;
//---------------------------------------------------------//

var au:auto;
begin
  lecturaAutos(au);
  while (au.patente <> '000') do begin
    insertarHoja(a,au);
    lecturaAutos(au);
    end;
end;

function incisoB (marca: string;a:arbol):integer;
begin
  if (a = nil) then incisoB := 0
  else begin 
       if (a^.dato.marca = marca) then incisoB := 1 + incisoB(marca,a^.hd) + incisoB(marca,a^.hi)
       else incisoB := incisoB(marca,a^.hd) + incisoB(marca,a^.hi);
       end;
end;

procedure inicializarVector(var v:vector);
var i:integer;
begin
  for i:=1 to 8 do
    v[i]:=nil;
end;

procedure recorrerArbol (a:arbol;var v:vector);
//---------------------------------------------------------//
procedure agregarOrdenadamente(var l,ult:lista;au:auto);
var aux:lista;
begin
  new(aux);
  aux^.dato:=au;
  aux^.sig:=nil;
  if (l = nil) then l:=aux
  else ult^.sig:=aux;
  ult:=aux;
end;
//---------------------------------------------------------//
var ult:lista;
begin
  if (a <> nil) then begin
    agregarOrdenadamente(v[a^.dato.anioFabricacion],ult,a^.dato);
    recorrerArbol(a^.hd,v);
    recorrerArbol(a^.hi,v);
  end;
end;

procedure ordenDecreciente (a:arbol);
  begin
   if ( a <> nil ) then begin
    ordenDecreciente (a^.hd);
    write('Patente: ',a^.dato.patente,'|');
    write('Anio de fabricacion: ',a^.dato.anioFabricacion,'|');
    write('Marca: ',a^.dato.marca,'|');
    write('Modelo: ',a^.dato.modelo,'|');
    writeln('');
    ordenDecreciente (a^.hi);
   end;
end;

procedure imprimirVector(v:vector);
var i:integer;
begin
    for i:=2010 to 2018 do begin
      if  (v[i] = nil) then writeln('No hay autos con anio de fabricacion ',i);
	  while (v[i] <> nil) do begin
		write('Patente: ',v[i]^.dato.patente,'|');
        write('Anio de fabricacion: ',v[i]^.dato.anioFabricacion,'|');
        write('Marca: ',v[i]^.dato.marca,'|');
        write('Modelo: ',v[i]^.dato.modelo,'|');
		v[i]:=v[i]^.sig;
	  end;
	end;
end;

function buscarPatente(a:arbol;patente:string):integer;
begin
 
 if (a <> nil) then begin 
   if (a^.dato.patente = patente) then buscarPatente:=a^.dato.anioFabricacion
   else if (a^.dato.patente > patente) then buscarPatente:=buscarPatente(a^.hi,patente)
        else buscarPatente:=buscarPatente(a^.hd,patente)
 end
 else buscarPatente:= -1;
end;

procedure cascara (a:arbol; var v:vector);
var marca,patente:string;
begin
  if (a <> nil) then begin
    writeln('');
    writeln('Marca de autos, inciso B: ');
    readln(marca);
    writeln('La cantidad de autos con marca ',marca,' es igual a: ',incisoB(marca,a));
    writeln('');
    writeln('Patente, inciso D: ');
    readln(patente);
    writeln('El anio de fabricacion del auto con patente ',patente,' es: ',buscarPatente(a,patente));
    writeln('');
    writeln('VECTOR DE LISTAS');
    inicializarVector(v);
    recorrerArbol(a,v);
    imprimirVector(v);
  end
  else writeln('El arbol esta vacio');
end;
 
var a:arbol; v:vector;
begin
  a:=nil;
  cargarArbol(a);
  writeln('ARBOL');
  ordenDecreciente(a);
  writeln('------');
  cascara(a,v);
end.
