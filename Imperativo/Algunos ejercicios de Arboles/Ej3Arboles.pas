program Ej3Arboles;
const anio = 2010;
type

  alumno = record
    legajo:integer;
    dni:integer;
    ingreso:integer;
    end;
    
  arbol = ^nodo;
  nodo = record
         dato:alumno;
         hi:arbol;
         hd:arbol;
         end;
         
procedure crearArbol(var a:arbol);
//.
procedure insertarHijo(var a:arbol;alu:alumno);
begin
  if (a = nil) then begin
    new(a);
    a^.dato:=alu;
    a^.hi:=nil;
    a^.hd:=nil;
  end
  else begin
         if (alu.legajo < a^.dato.legajo) then begin
            insertarHijo(a^.hi,alu);
            end
         else insertarHijo(a^.hd,alu);
        end;
end;
//.
procedure leerAlumno(var a:alumno);
begin
  with a do begin
    writeln('Ingrese un año de ingreso posterior al 2010');
    readln(a.ingreso);
    if (a.ingreso > anio) then begin
      a.dni:=random(5000);
      a.legajo:=random(3000);
      end;
  end;
end;
//.
var alu:alumno;
begin
  a:=nil;
  leerAlumno(alu);
  while (alu.ingreso > 2010) do begin
    insertarHijo(a,alu);
    leerAlumno(alu);
    end;
end;

procedure incisos (a:arbol);
procedure legajoInferior(a:arbol;legajo:integer);
begin
  if(a <> nil) then begin
    if (a^.dato.legajo<=legajo) then begin
         writeln(a^.dato.legajo,'|',a^.dato.dni,'|',a^.dato.ingreso,'| tiene legajo inferior a ', legajo);
         legajoInferior(a^.HI,legajo);
         legajoInferior(a^.HD,legajo);
      end
      else legajoInferior(a^.HD,legajo);
  end;
end;
//.
procedure rango(a:arbol;valorA:integer;valorB:integer);
begin
    if(a <> nil) then begin
        if (valorA <= a^.dato.legajo) then begin
          if (valorB >= a^.dato.legajo) then begin
             writeln(a^.dato.dni,'|',a^.dato.ingreso,'| tiene legajo entre el rango ',valorA,' ',valorB);
             rango(a^.HI,valorA,valorB);
             rango(a^.HD,valorA,valorB);
          end
          else rango(a^.HI,valorA,valorB);
        end
        else 
          rango(a^.HD,valorA,valorB);
  end;
end;
//.
function buscarMayorDNI(a:arbol;max:integer):integer;
begin
 if (a = nil) then buscarMayorDNI:=max
 else if(a^.dato.dni> max) then begin
        buscarMayorDNI:=buscarMayorDNI(a^.HI,a^.dato.dni);
        buscarMayorDNI:=buscarMayorDNI(a^.HD,a^.dato.dni);
      end;
end;
function cantElementos (a:arbol):integer;
begin
 if (a = nil) then cantElementos:=0
 else  begin
         if (a^.dato.legajo mod 2 <> 0) then cantElementos:=1+cantElementos(a^.HI)+cantElementos(a^.HD)
         else cantElementos:=0+cantElementos(a^.HI)+cantElementos(a^.HD);
       end;
end;
//.
var valorA,valorB:integer;max:integer;legajo:integer;
begin
  writeln('Ingrese un numero de legajo para el inciso b ');
  readln(legajo);
  legajoInferior(a,legajo);
  writeln('');
  writeln('Ingrese dos valores, para el inciso c ');
  writeln('Valor A: ');
  readln(valorA);
  writeln('Valor B: ');
  readln(valorB);
  rango(a,valorA,valorB);
  writeln('');
  max:=-1;
  writeln('El dni mas grande es: ',buscarMayorDNI(a,max));
  writeln('');
  writeln('La cantidad de elementos con legajo impar es de: ', cantElementos(a));
end;

procedure imprimirArbol(a:arbol);
begin
 if(a<>nil) then begin
  imprimirArbol(a^.HI);
  write('Legajo: ',a^.dato.legajo,'| ');
  write('Dni: ',a^.dato.dni,'| ');
  write('Año de ingreso: ',a^.dato.ingreso);
  writeln('');
  imprimirArbol(a^.HD);
  end;
end;

var a:arbol;
begin
  crearArbol(a);
  imprimirArbol(a);
  incisos(a);
end.

