{
3.- Escribir un programa que:
a. Implemente un módulo recursivo que genere una lista de números enteros “random” mayores a 0 y menores a 100. 
Finalizar con el número 0.
b. Implemente un módulo recursivo que devuelva el mínimo valor de la lista. 
c. Implemente un módulo recursivo que devuelva el máximo valor de la lista. 
d. Implemente un módulo recursivo que devuelva verdadero 
si un valor determinado se encuentra en la lista o falso en caso contrario. 
}


program E32Recursion;
const limite = 100;
type
lista = ^nodo;
nodo = record
       dato:integer;
       sig:lista;
       end;

procedure insertarLista (var p:lista; dato:integer);
var aux:lista;
begin
  
  new(aux);
  aux^.dato:=dato;
  aux^.sig:=p;
  p:=aux;

end;

procedure crearLista(var l:lista);
    procedure cargarLista(var l:lista);
    var n:integer;
    begin
      n:=random(limite);
      if (n <> 0) then begin
         insertarLista(l,n);
         cargarLista(l);
      end;
    end;
begin
  l:=nil;
  randomize;
  cargarLista(l);
end;

procedure imprimirListaOrden(l:lista);
begin
  if (l<>nil) then begin
    write(l^.dato,'|');
    imprimirListaOrden(l^.sig);
    end;
end;

procedure informarMinimo(l:lista);
   procedure minimoRecursivoLista(l:lista; var min:integer);
   begin
      if (l<>nil) then begin
         if (min > l^.dato) then begin
           min:=l^.dato;
           minimoRecursivoLista(l^.sig,min);
           end
         else minimoRecursivoLista(l^.sig,min);
      end;
   end;
var min:integer;
begin
  min:=10000;
  minimoRecursivoLista(l,min);
  writeln('El minimo de la lista es: ', min);
end;

function minimo(l: lista): integer;
var mini:integer;
begin
	if (l^.sig<>nil) then begin
		mini:=minimo(l^.sig);
		if (l^.dato < mini) then minimo:=l^.dato else minimo:=mini;
	end
	else minimo:=l^.dato; {Este es el PRIMER valor que va a tomar la variable MINI
	al final de abrir recursivamente la función cuando l^.sig sea nil. Recién ahí se comenzará a 
	evaluar el minimo hasta encontrarlo.}
	
end; 

procedure informarMaximo(l:lista);
   procedure maximoRecursivoLista(l:lista; var max:integer);
   begin
      if (l<>nil) then begin
         if (max < l^.dato) then begin
           max:=l^.dato;
           maximoRecursivoLista(l^.sig,max);
           end
         else maximoRecursivoLista(l^.sig,max);
      end;
   end;
var max:integer;
begin
  max:=-1;
  maximoRecursivoLista(l,maX);
  writeln('El minimo de la lista es: ', max);
end;

function maximo(l: lista): integer;
var maxi:integer;
begin
	if (l^.sig<>nil) then begin
		maxi:=maximo(l^.sig);
		if (l^.dato>maxi) then maximo:=l^.dato else maximo:=maxi;
	end
	else maximo:=l^.dato; {Este es el PRIMER valor que va a tomar la variable MAXI 
	al final de abrir recursivamente la función cuando l^.sig sea nil. Recién ahí se comenzará a 
	evaluar el maximo hasta encontrarlo.}
	
end; 

function esta(l:lista; x: integer): boolean;
begin
	if ((l<>nil) and (l^.dato<>x)) then begin
		esta:=esta(l^.sig,x);
	end
	else esta:=((l<>nil) and (l^.dato=x));
end;

var l:lista; x:integer;
begin
crearLista(l);
imprimirListaOrden(l);
writeln();
informarMinimo(l);
writeln('El minimo en la funcion es: ', minimo(l));
informarMaximo(l);
writeln('El maximo en la funcion es: ', maximo(l));
writeln('Ingrese el dato a buscar');
readln(x);
if (esta(l,x)) then writeln ('El valor ', x,' se encuentra en la lista')
else writeln('El valor ', x,' no se encuentra en la lista');
end.