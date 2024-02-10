program ParcialAerolinia;

const DIMF = 250;

type

sub = 1..20;

empleado = record
            legajo:integer;
            dni:integer;
            categoria:sub;
            ano:integer;
            end;

arbol=^nodo;
   nodo = record
          dato: empleado;
          HD:arbol;
          HI:arbol;
          end;

cumple = record
         dni:integer;
         legajo:integer;
         end;

Nue = Array [1..250] of cumple;

          
Procedure leerEmpleado(var e:empleado);
begin

 writeln('Ingrese dni');
 readln(e.dni);
 if (e.dni <> -1) then begin
 writeln('legajo');
 readln(e.legajo);
 writeln('categoria');
 readln(e.categoria);
 writeln('año de ingreso');
 readln(e.ano);
 end;

end;
          
procedure insertarHoja(Var a:arbol;e:empleado);
Begin 
   If (a=nil) then begin
    new(a);
    a^.dato:=e;
    a^.HI:=nil;
    a^.HD:=nil;
    end
    else begin If (e.dni<a^.dato.dni) then begin 
               writeln('Entre al HI');//Solo para ver como funciona y ver con ejemplos.
               insertarHoja(a^.HI,e);
               writeln('Sali del HI'); end
               else If (e.dni>a^.dato.dni) then begin
                    writeln('Entre al HD');
                    insertarHoja(a^.HD,e);
                    writeln('Sali del HD');
                    end;
          end;
end;

procedure crearArbol (var a:arbol);
var e:empleado;
begin
  
  leerEmpleado(e);
  
  while (e.dni<>-1) do begin

   insertarHoja(a,e);
   leerEmpleado(e);
  
  end;

end;

Procedure ImprimirArbol(a:arbol);
begin
	if ( a<> nil ) then begin
		ImprimirArbol (a^.HI);
		writeln('Dni:',a^.dato.dni);  
		ImprimirArbol (a^.HD);
   end;
end;

//De los anteriores procesos, se dispone.

//Inciso a

procedure OrdenarPorInsercion(var v:Nue; diml: integer);
var 
	i, j : integer;
	actual: cumple;
begin
	for i:= 2 to diml do begin
	    actual := v[i];
        j:= i-1;	    
        
        while((j>0) and (v[j].dni > actual.dni)) do begin
            v[j+1] := v[j];
            j:= j-1;        
        end;
        
        v[j+1]:= actual; 
	end;
end;

procedure crearVector(a:arbol; var v:Nue;AA:integer;B:integer;categoria:integer; var diml:integer);
var
	nodovec: cumple;
begin
	if ((a <> nil)and (diml < DIMF) )then begin
		if(a^.dato.dni <= AA) then 
			crearVector(a^.HD,v,AA,B,categoria,diml)
			
		else if(a^.dato.dni >= B)then
			crearVector(a^.HI,v,AA,B,categoria,diml)

		else begin
			if(a^.dato.categoria = categoria) then begin 
				nodovec.dni := a^.dato.dni;
				nodovec.legajo:= a^.dato.legajo;
				diml:= diml+1;
				v[dimL] := nodovec;
			end;
			crearVector(a^.HI,v,AA,B,categoria,diml);
			crearVector(a^.HD,v,AA,B,categoria,diml);
		end;
	end
	else
		OrdenarPorInsercion(v,dimL);
end;

Procedure ImprimirVector(v:Nue;diml:integer);
var 
	i:integer;
begin
	for i:=1 to diml do begin
		writeln('-----------------');
		writeln('Dni:',v[i].dni);
		writeln('Numero de legajo:',v[i].legajo);
		writeln('-----------------');
	end;
end;

Function promedioLegajo(v:Nue;i:integer;diml:integer):real;
begin
	if( (i>0) and(i<=diml))then 
		promedioLegajo:= (v[i].legajo + promedioLegajo(v,(i+1),diml))
	else 
		promedioLegajo:=0;
end;

var a:arbol;
	v:Nue;
	diml:integer;
	i:integer;

begin

 a:= nil;
 i:=1;
 diml:=0;
 
 crearArbol(a);
 ImprimirArbol(a);
 crearVector(a,v,10,20,15,diml);
 ImprimirVector(v,diml);
 writeln('El promedio de todos los legajOs es', promedioLegajo(v,i,diml) / diml);
 
end.


//con listaaaaaaaaaaaaaaaaaaaaaa
procedure crearVector(a:arbol; var vec:v; dniA:integer; dniB:integer; categoria:integer; var dimL:integer);
var
    nodovec: empleadoVec;
begin
    if ((a <> nil)and (dimL < DIMF) )then begin
        if(a^.dato.dni <= dniA) then 
            crearVector(a^.HD,vec,dniA,dniB,categoria,dimL)

        else if(a^.dato.dni >= dniB)then
            crearVector(a^.HI,vec,dniA,dniB,categoria,dimL)

        else begin
            if(a^.dato.cat = categoria) then begin 
                nodovec.dni := a^.dato.dni;
                nodovec.nroL:= a^.dato.nroL;
                nodovec.cat := a^.dato.cat;
                agregarxd(elementos)
            end;
            crearVector(a^.HI,vec,dniA,dniB,categoria,dimL);
            crearVector(a^.HD,vec,dniA,dniB,categoria,dimL);
        end;
    end
    else
        OrdenarPorInsercion(vec,dimL);
end;

//si tengo que crear una lista a partir del arbol
procedure agregarALista(arbol,lista);
begin
agregarLista(arbol^.HD,lista)
agregar(lista,arbol^.dato)
agregarLista(arbol^.HI,lista)
end.
