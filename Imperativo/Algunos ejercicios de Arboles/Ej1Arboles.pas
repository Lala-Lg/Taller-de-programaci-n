{
a. Implemente un modulo que lea informacion de socios de un club y las almacene en un arbol binario de busqueda.
De cada socio se lee numero de socio, nombre y edad.
La lectura finaliza con el numero de socio 0 y el arbol debe quedar ordenado por numero de socio.
b. Una vez generado el arbol, realice modulos independientes que reciban el arbol como parametro y: 
    i. Informe el numero de socio mas grande. Debe invocar a un modulo recursivo que retorne dicho valor. 
    ii. Informe los datos del socio con el numero de socio mas chico. Debe invocar a un modulo recursivo que retorne dicho socio. 
    iii. Informe el numero de socio con mayor edad. Debe invocar a un modulo recursivo que retorne dicho valor. 
    iv. Aumente en 1 la edad de todos los socios.
    v. Lea un valor entero e informe si existe o no existe un socio con ese valor. Debe invocar a un modulo recursivo que reciba el valor lei­do y
       retorne verdadero o falso.
    vi. Lea un nombre e informe si existe o no existe un socio con ese valor. Debe invocar a un modulo recursivo que reciba el nombre lei­do y 
        retorne verdadero o falso.
    vii. Informe la cantidad de socios. Debe invocar a un modulo recursivo que retorne dicha cantidad.
    viii. Informe el promedio de edad de los socios. Debe invocar a un modulo recursivo que retorne dicho promedio.
    ix. Informe, a partir de dos valores que se leen, la cantidad de socios en el arbol cuyo numero de socio se encuentra entre 
        los dos valores ingresados. Debe invocar a un modulo recursivo que reciba los dos valores leÃ­dos y retorne dicha cantidad. 
    x. Informe los numeros de socio en orden creciente. 
    xi. Informe los numeros de socio pares en orden decreciente.
}


program Ej1Arboles;
const AA = 100; BB = 1; CorteLectura = 0;
type
socio = record
        numSocio:integer;
        nombre:String;
        edad:integer;
        end;
        
arbol=^nodo;
   nodo = record
          dato:socio;
          HD:arbol;
          HI:arbol;
          end;
procedure crearArbol (var a:arbol);
  procedure leerSocio(var s:socio);
  begin
    with s do begin
         writeln('Numero de socio');
         readln(numSocio);
         if (numSocio <> 0) then begin
             writeln('Nombre: ');
             readln(nombre);
              writeln('Edad: ');
             readln(edad);
         end;
    end;
  end;

  procedure insertarHoja(Var a:arbol;dato:socio);
  begin 
    if (a = nil) then begin
      new(a);
      a^.dato:=dato;
      a^.HI:=nil;
      a^.HD:=nil;
    end
    else begin if (dato.numSocio<a^.dato.numSocio) then begin 
               writeln('Entre al HI');//Solo para ver como funciona y ver con ejemplos.
               insertarHoja(a^.HI,dato);
               writeln('Sali del HI'); end
               else If (dato.numSocio>a^.dato.numSocio) then begin
                    writeln('Entre al HD');
                    insertarHoja(a^.HD,dato);
                    writeln('Sali del HD');
                    end;
          end;
end;

var s:socio;
begin
     leerSocio(s);
     while (s.numSocio<>0) do begin
         insertarHoja(a,s);
         leerSocio(s);
     end;
end;

//Numero de socio mas chico
procedure InformarDatosSocioNumeroMasChico (a: arbol);
  
  function SocioMasChico (a: arbol): arbol;
  begin
    if ((a = nil) or (a^.HI = nil))
    then SocioMasChico:= a
    else SocioMasChico:= SocioMasChico (a^.HI);
  end;
   
var minSocio: arbol;
begin
  writeln;
  writeln ('----- Informar Datos Socio Numero Mas Chico ----->');
  writeln;
  minSocio:= SocioMasChico (a);
  if (minSocio = nil) then writeln ('Arbol sin elementos')
  else begin
         writeln;
         writeln ('Socio con numero mas chico: ', minSocio^.dato.numSocio, ' Nombre: ', minSocio^.dato.nombre, ' Edad: ', minSocio^.dato.edad); 
         writeln;
       end;
end;
	
//Numero de socio mas grande
procedure InformarNumeroSocioMasGrande (a: arbol);

  function NumeroMasGrande (a: arbol): integer;
  begin
    if (a = nil) then NumeroMasGrande:= -1
    else if (a^.HD = nil) then NumeroMasGrande:= a^.dato.numSocio
                          else NumeroMasGrande:= NumeroMasGrande (a^.HD);
  end;
   
var max: integer;
begin
  writeln;
  writeln ('----- Informar Numero Socio Mas Grande ----->');
  writeln;
  max:= NumeroMasGrande (a);
  if (max = -1) then writeln ('Arbol sin elementos')
  else begin
         writeln;
         writeln ('Numero de socio mas grande: ', max);
         writeln;
       end;
end;

procedure InformarNumeroSocioConMasEdad (a: arbol);
//---------------
procedure buscarMayorEdad(a:arbol; var max:integer; var numSocio:integer);
begin
 if (a <> nil) then begin
    if(a^.dato.edad> max) then begin
               max:=a^.dato.edad;
               numSocio:=a^.dato.numSocio;
    end;
 buscarMayorEdad(a^.HI,max,numSocio);
 buscarMayorEdad(a^.HD,max,numSocio);
 end;// Si el arbol esta vacio, que devuelva en un proceso cascara un writeln diciendolo.
end;
//-----------------
var maxEdad, maxNum: integer;
begin
  writeln;
  writeln ('----- Informar Numero Socio Con Mas Edad ----->');
  writeln;
  maxEdad:=-1;
  buscarMayorEdad(a, maxEdad, maxNum);
  if (maxEdad = -1) then writeln ('Arbol sin elementos')
  else begin
         writeln;
         writeln ('Numero de socio con mas edad: ', maxNum);
         writeln;
       end;
end;

procedure aumentarEdad(a:arbol);
begin
  if (a <> nil) then begin
    a^.dato.edad:=a^.dato.edad+1;
    aumentarEdad(a^.HI);
    aumentarEdad(a^.HD);
  end;// Si el arbol esta vacio, que devuelva en un proceso cascara un writeln diciendolo.
end;

procedure InformarExistenciaNumeroSocio (a: arbol);
//--------------
function encontrarX(a:arbol; x:integer):boolean;
begin
 If(a=nil) then encontrarX:=false
 else begin if(x=a^.dato.numSocio) then encontrarX:=true
            else If(x<a^.dato.numSocio) then encontrarX:=encontrarX(a^.HI,x)
            else encontrarX:=encontrarX(a^.HD,x);
      end;
end;
//--------------
var numABuscar: integer;
begin
  writeln;
  writeln ('----- Informar Existencia Numero Socio ----->');
  writeln;
  write ('Ingrese numero de socio a buscar: ');
  readln (numABuscar);
  writeln;
  if (encontrarX(a, numABuscar)) 
  then writeln ('El numero ', numABuscar, ' existe')
  else writeln ('El numero ', numABuscar, ' no existe');
  writeln;
end;

procedure InformarExistenciaNombreSocio(a:arbol);
//----------------------------
function buscarNombre(a:arbol;nombre:string):boolean;
begin
 
 if (a = nil) then buscarNombre:= false
 else buscarNombre := (a^.dato.nombre = nombre) or buscarNombre(a^.hd,nombre) or buscarNombre(a^.hi,nombre) 
 end; 
//----------------------------
var nombreX:String;
begin
  writeln;
  writeln ('----- Informar Existencia Nombre Socio ----->');
  writeln;
  write ('Ingrese nombre de socio a buscar: ');
  readln (nombreX);
  writeln;
  if (buscarNombre(a, nombreX)) 
  then writeln ('El nombre ', nombreX, ' existe')
  else writeln ('El nombre ', nombreX, ' no existe');
  writeln;
end;

function cantElementos (a:arbol):integer;
begin
 if (a = nil) then cantElementos:=0
 else  cantElementos:=1+cantElementos(a^.HI)+cantElementos(a^.HD);
end;

procedure InformarCantidadSocios (a:arbol);
begin
writeln;
writeln ('----- Cantidad de socios ----->');
writeln;
writeln('La cantidad total de socios es: ', cantElementos(a));
end;

procedure InformarPromedioDeEdad (a:arbol);
//-----------------------
function sumaTotal (a:arbol):integer;
begin
  if(a = nil) then sumaTotal:=0
  else sumaTotal:=a^.dato.edad+sumaTotal(a^.HI)+sumaTotal(a^.HD);
end;
//-----------------------
var promedio:real;
begin
writeln;
writeln ('----- Promedio de edad de los socios ----->');
writeln;
promedio := sumaTotal(a)/cantElementos(a);
writeln('El promedio de edad es de: ', promedio:1:1);
end;

procedure InformarCantidadSociosEnRango (a:arbol);
function rango(a:arbol):integer;
begin
  if (a <> nil) then begin
    if ((AA>a^.dato.numSocio) and (a^.dato.numSocio>BB)) then  rango:= 1+rango(a^.HI)+rango(a^.HD)
    else if (AA<a^.dato.numSocio) then  rango:=rango(a^.HI) 
         else if (a^.dato.numSocio<BB) then rango:=rango(a^.HD); 
  end
  else rango:=0;
end;
begin
writeln;
writeln ('La cantidad de socios en el arbol cuyo numero de socio se encuentra entre los dos valores ingresados es: ', rango(a));
end;

procedure imprimirArbol(a:arbol);
begin
 if(a<>nil) then begin
  write('Numero de socio: ',a^.dato.numSocio,'|');
  write('Nombre: ',a^.dato.nombre,'|');
  write('Edad: ',a^.dato.edad,'|');
  writeln('');
  imprimirArbol(a^.HI);
  imprimirArbol(a^.HD);
  end;
end;

procedure ordenCreciente (a:arbol);
  begin
   If ( a<> nil ) then begin
    ordenCreciente (a^.HI);
    write('Numero de socio: ',a^.dato.numSocio,'|');
    write('Nombre: ',a^.dato.nombre,'|');
    write('Edad: ',a^.dato.edad,'|');
    writeln('');
    ordenCreciente (a^.HD);
   end;
end;

procedure ordenDecreciente (a:arbol);
  begin
   If ( a<> nil ) then begin
    ordenDecreciente (a^.HD);
    write('Numero de socio: ',a^.dato.numSocio,'|');
    write('Nombre: ',a^.dato.nombre,'|');
    write('Edad: ',a^.dato.edad,'|');
    writeln('');
    ordenDecreciente (a^.HI);
   end;
end;


var a: arbol; 
Begin
  crearArbol(a);
  InformarNumeroSocioMasGrande (a);
  InformarDatosSocioNumeroMasChico (a);
  InformarNumeroSocioConMasEdad (a);
  AumentarEdad(a);
  writeln;
  writeln ('Socios');
  writeln;
  imprimirArbol(a);
  InformarExistenciaNumeroSocio (a);
  InformarExistenciaNombreSocio (a);
  InformarCantidadSocios (a);
  InformarPromedioDeEdad (a);
  InformarCantidadSociosEnRango (a);
  writeln;
  writeln ('Socios en orden decreciente');
  writeln;
  ordenDecreciente(a);
  writeln;
  writeln ('Socios en orden creciente');
  writeln;
  ordenDecreciente(a);
End.
