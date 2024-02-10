{
1.- Implementar un programa que invoque a los siguientes módulos.
a. Implementar un módulo recursivo que permita leer una secuencia de caracteres terminada en punto y los almacene en un vector con dimensión física igual a 10.
b. Implementar un módulo que imprima el contenido del vector.
c. Implementar un módulo recursivo que imprima el contenido del vector.
d. Implementar un módulo recursivo que permita leer una secuencia de caracteres terminada en punto y retorne la cantidad de caracteres leídos. 
El programa debe informar el valor retornado.
e. Implementar un módulo recursivo que permita leer una secuencia de caracteres terminada en punto y retorne una lista con los caracteres leídos.
f. Implemente un módulo recursivo que reciba la lista generada en d. e imprima los valores de la lista en el mismo orden que están almacenados.
g. Implemente un módulo recursivo que reciba la lista generada en d. e imprima los valores de la lista en orden inverso al que están almacenados.
}


program Ej1Recursion;

const dimf=10;

type 
vector = array [1..dimf] of char;
lista = ^nodo;
nodo = record
       dato:char;
       sig:lista;
       end;

procedure secuenciaCaracteres (var diml:integer; var v:vector);
var c:char;
begin
  writeln('Ingrese un caracter');
  readln(c);
  if ((diml <= dimf) and (c <> '.')) then begin
    diml:=diml+1;
    v[diml]:= c;
    secuenciaCaracteres(diml,v);
  end;
  
end;

procedure leerSecuencia (v:vector; diml:integer);
begin
  if (diml>0) then begin
   leerSecuencia(v,diml-1);
   write (v[diml],'|');
  end;
end;

procedure agregarOrdenadamente(var l,ult:lista; c:char);
var aux:lista;
begin
	new(aux);
	aux^.dato:=c;
	aux^.sig:=nil;
	if l=nil then l:=aux
	else ult^.sig:=aux;
	ult:=aux;
end; 

procedure secuenciaLista (var l,ult:lista);
var c:char;
begin
  writeln('Ingrese un caracter');
  readln(c);
  if (c <> '.') then begin 
    agregarOrdenadamente(l,ult,c);
    secuenciaLista(l,ult);
    end;
end;

procedure imprimirListaOrden(l:lista);
begin
  if (l<>nil) then begin
    write(l^.dato,'|');
    imprimirListaOrden(l^.sig);
    end;
end;

procedure imprimirListaDesordenada(l:lista);
begin
  if (l<>nil) then begin
    imprimirListaDesordenada(l^.sig);
    write(l^.dato,'|');
    end;
end;

var diml:integer; v:vector; l:lista; ult:lista;

begin
  l:=nil;
  secuenciaCaracteres(diml,v);
  writeln('Vector: ');
  leerSecuencia(v,diml);
  writeln('');
  secuenciaLista(l,ult);
  writeln('Lista: ');
  writeln('Lista Ordenada');
  imprimirListaOrden(l);
  writeln('');
  writeln('Lista Desordenada');
  imprimirListaDesordenada(l);
end.