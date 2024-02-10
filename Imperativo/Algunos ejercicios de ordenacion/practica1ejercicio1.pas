{1.- Implementar un programa que procese la información de las ventas de productos de un comercio (como máximo 20). 
De cada venta se conoce código del producto (entre 1 y 15) y cantidad vendida (como máximo 99 unidades).  El ingreso de las ventas finaliza con el código 0 (no se procesa).
a. Almacenar la información de las ventas en un vector. El código debe generarse automáticamente (random) y la cantidad se debe leer. 
b. Mostrar el contenido del vector resultante.
c. Ordenar el vector de ventas por código.
d. Mostrar el contenido del vector resultante.
e. Eliminar del vector ordenado las ventas con código de producto entre dos valores que se ingresan como parámetros. 
f. Mostrar el contenido del vector resultante.
g. Generar una lista ordenada por código de producto de menor a mayor a partir del vector resultante del inciso e., sólo para los códigos pares.
h. Mostrar la lista resultante.
}
program practica1ejercicio1;
const 
	dimf=20;
type
	venta=record
		codproducto:integer;
		cantvendida:integer;
	end;
	
	vector_ventas= array [1..dimf] of venta;
	
	Lista=^nodo;
	nodo=record
		dato:venta;
		sig:lista;
	end;
/////////////////////////////////////////////////////////////////////////////LEER DATOS////////////////////////////////////////////////////////////////////////		
procedure Leer(var v:venta);
begin
	v.codproducto:= random(16);
	if(v.codproducto <> 0) then begin
		writeln('*ingresar cantidad vendida :');
		readln(v.cantvendida);
	end;
end;
/////////////////////////////////////////////////////////////////////////////CARGAR VECTOR/////////////////////////////////////////////////////////////////////
procedure CargarVector(var Vector:vector_ventas; var diml:integer);
var 
	v:venta;
begin
	Leer(v);
	while (diml<dimf)and (v.codproducto <> 0) do begin
		diml:= diml + 1;
		Vector[diml]:= v;
		Leer(v);
	end;
end;
////////////////////////////////////////////////////////////////////////////IMPRIMIR VECTOR////////////////////////////////////////////////////////////////////		
procedure ImprimirVector(Vector:vector_ventas;diml:integer);
var 
	i:integer;
begin
	for i:= 1 to diml do begin
		writeln('*Nro de producto :', i,'| * Codigo de producto :', Vector[i].codproducto, '| *Cantidad de ventas:', Vector[i].cantvendida);
	end;
end;
///////////////////////////////////////////////////////////////////////////ORDENAR VECTOR//////////////////////////////////////////////////////////////////////
procedure OrdenarPorInsercion(var Vector: vector_ventas; diml: integer);
var i, j : integer;
	actual: venta;
begin
	for i:= 2 to diml do begin
	    actual := Vector[i];{guardo el elemento a ordenar}
        j:= i-1;	    
        
        while((j>0) and (Vector[j].codproducto> actual.codproducto)) do begin
            Vector[j+1] := Vector[j];
            j:= j-1;        
        end;
        
        Vector[j+1]:= actual; {guarda el elemento en el lugar}
	end;
end;

//////////////////////////////////////////////////////////////////////////ELIMINAR DEL VECTOR//////////////////////////////////////////////////////////////////
procedure Eliminar(var Vector:vector_ventas; var diml:integer; num1:integer; num2:integer);
var 
	pos_ini:integer;
	cant:integer;
	i:integer;
begin
	i:=1;
	
	{--------Obtenemos las posiciones--------}
	while((diml<dimf) and (Vector[i].codproducto< num1)) do 
		i:=i+1;
	{A partir del num1}
	pos_ini:=i;
		
	
	while((diml<dimf) and (Vector[i].codproducto<= num2)) do 
		i:=i+1;
	{Contando el num2}
	cant:=i-pos_ini;
		
		
	{--------Corrimiento--------}
	for i:=(pos_ini+cant) to diml do 
		Vector[i-cant]:=Vector[i];
	diml:=diml-cant;
	
end;

/////////////////////////////////////////////////////////////////////////GENERAR LISTA ORDENADA CON CODIGOS PARES/////////////////////////////////////////////
Procedure AgregarAtras(var L,ult:Lista; v:venta);
var nue:lista;
begin
    New(nue);
    nue^.dato:=v;
    nue^.sig:=nil;
    if L=nil then 
		l:=nue
    else 
		ult^.sig:=nue;
    ult:=nue;
end;

procedure GenerarLista(var L:lista; Vector:vector_ventas; diml:integer);
var
	i:integer; ult:lista;
begin
	ult:=nil;
	for i:=1 to diml do begin 
		if(Vector[i].codproducto mod 2 = 0 ) then
			AgregarAtras(L,ult,Vector[i]);
	end;
end;
/////////////////////////////////////////////////////////////////////////IMPRIMIR LISTA//////////////////////////////////////////////////////////////////////	
procedure ImprimirLista(L:lista);
begin
	while(L <> nil) do begin
		writeln('Codigo de producto: ',L^.dato.codproducto, ' | Cantidad de ventas: ', L^.dato.cantvendida);
		L:=L^.Sig;
	end;
end;
////////////////////////////////////////////////////////////////////////PROGRAMA PRINCIPAL//////////////////////////////////////////////////////////////////
var
	L:lista; Vector:vector_ventas; diml:integer;
	num1,num2:integer;
{Programa Principal}
begin
 Randomize;
 L:=nil;
 diml:=0;
 CargarVector(Vector,diml);
 writeln('Vector Completo:');
 ImprimirVector(Vector,diml);
 OrdenarPorInsercion(Vector,diml);
 writeln('Vector Ordenado');
 ImprimirVector(Vector,diml);
 Writeln('ingresar un numero inf');
 readln(num1);
 Writeln('ingresar un numero sup');
 readln(num2);
 Eliminar(Vector,diml,num1,num2);
 writeln('Reducido por codigos:');
 ImprimirVector(Vector,diml);
 GenerarLista(L,Vector,diml);
 writeln('Lista impresa: ');
 ImprimirLista(L)
end.	
