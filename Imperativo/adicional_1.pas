program adicional_1;
const 
  dimf = 300;
type
  oficina = record
            identificacion:integer;
            dni:String;
            expensa:real;
            end;
   vectorOficinas = array [1..dimf] of oficina;

procedure cargarVector (var v:vectorOficinas; var diml:integer);
//---------------------------------------------------------//
procedure lecturaOficina (var o:oficina);
begin
   with o do begin
     writeln('Codigo de identificacion: ');
     readln(identificacion);
     if (identificacion <> -1) then begin
       writeln('Dni del propietario: ');
       readln(dni);
       writeln('Valor de la expensa: ');
       readln(expensa);
     end;
   end;
end;
//---------------------------------------------------------//
var o:oficina;
begin
  lecturaOficina(o);
  while ((diml<dimf) and (o.identificacion <>-1)) do begin
    diml:=diml+1;
    v[diml]:=o;
    lecturaOficina(o);
  end;
end;

procedure ordenarInsercion (var v:vectorOficinas; diml:integer);
var i,j:integer; actual:oficina;
begin
  for i:=2 to diml do begin
    actual:=v[i];
    j:=i-1;
    while((j>0) AND (v[j].identificacion>actual.identificacion)) do begin
      v[j+1]:=v[j];
      j:=j-1;
    end;
    v[j+1]:=actual;
  end;
end;

procedure incisoC (v:vectorOficinas;diml:integer);
//---------------------------------------------------------//
procedure busquedaDicotomica (v:vectorOficinas;inicio,fin:integer;codigo:integer;var pos:integer);
var medio:integer;
begin
  if (inicio>fin) then pos:=-1
  else begin
    medio:=(inicio+fin) div 2;
    if (codigo = v[medio].identificacion) then pos:=medio
    else begin
           if (codigo < v[medio].identificacion) then
             busquedaDicotomica(v,inicio,medio-1,codigo,pos)
           else 
             busquedaDicotomica(v,medio+1,fin,codigo,pos);
         end;
  end;
end;
//---------------------------------------------------------//
var inicio,fin,pos,codigo:integer;
begin
  inicio:=1;
  fin:=diml;
  writeln('Ingrese un codigo de identificacion para buscar coincidencia');
  readln(codigo);
  busquedaDicotomica(v,inicio,fin,codigo,pos);
  if (pos = -1) then writeln('El codigo buscado no existe')
  else writeln('El dni del propietario con codigo ',codigo,'es: ',v[pos].dni);
end;

procedure incisoD (v:vectorOficinas;diml:integer);
//---------------------------------------------------------//
function montoTotalExpensas (v:vectorOficinas;diml:integer):real;
begin
  if (diml = 0) then montoTotalExpensas:=0
  else montoTotalExpensas:=montoTotalExpensas(v,diml-1) + v[diml].expensa;
end;
//---------------------------------------------------------//
begin 
  writeln('La suma total de las expensas es: ', montoTotalExpensas(v,diml):0:1);
end;

procedure imprimirVector(v:vectorOficinas;diml:integer);
var i:integer;
begin
	for i:= 1 to diml do begin
		writeln('Codigo de identificacion: ', v[i].identificacion);
		writeln('Dni del propietario: ', v[i].dni);
		writeln('Expensas: ',v[i].expensa:0:1);
	end;
end;

var
  diml:integer;
  v:vectorOficinas;
begin
  cargarVector(v,diml);
  imprimirVector(v,diml);
  writeln('Vector ordenado');
  ordenarInsercion(v,diml);
  imprimirVector(v,diml);
  incisoC(v,diml);
  incisoD(v,diml);
end.
