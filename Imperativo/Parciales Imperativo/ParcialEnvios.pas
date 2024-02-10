Program ParcialSucursalesEnvioPaquetes;

Const dimf = 4;

Type 
 
  paquete = record 
            tipoP: 1..dimf;
            codPaquete:integer;
            codLocalidad:integer;
            peso:real;
            precio:real;
            end;
           
  lista = ^nodo;
  nodo = record
         dato:paquete;
         sig:lista;
         end;
  
  tipoPaquete = array [1..dimf] of lista;
         
  Nue = record
        codLocalidad:integer;
        totalEnvios:integer;
        end;
      
  arbol = ^nodito;
  nodito = record
           dato:Nue;
           HD:arbol;
           HI:arbol;
           end;
           
procedure leerEnvios(var p:paquete); //SE DISPONE
begin
   writeln('Ingrese codigo de paquete');
     readln(p.codPaquete);
   if(p.codPaquete<>-1) then begin
     writeln('Ingrese tipo de paquete');
     readln(p.tipoP);
     writeln('codigo de localidad');
     readln(p.codLocalidad);
     writeln('peso');
     readln(p.peso);
     writeln('precio');
     readln(p.precio);
   end;
end;          
           
procedure insertarOrdenado(var l:lista;p:paquete); //SE DISPONE
var aux:lista;ant:lista;act:lista;
begin
  
  new(aux);
  aux^.dato := p;
  act:= l;
  ant:= l;
  while(act<>nil) and (act^.dato.codLocalidad<p.codLocalidad) do begin
    ant:=act;
    act:=act^.sig;
    end;
  if (act = l) then l:=aux
  else ant^.sig:=aux;
  aux^.sig:=act;
end;

procedure inicializarVector(var t:tipoPaquete); //SE DISPONE
var i:integer;
begin 
  
  for i:=1 to dimf do begin
     
     t[i]:=nil;
  
  end;
  
end;

procedure vectorDeListas(var t:tipoPaquete); //SE DISPONE
var p:paquete;
begin
 
 inicializarVector(t);
 leerEnvios(p);
 
 while(p.codPaquete <> -1) do begin
   
   insertarOrdenado(t[p.tipoP],p);
   
   leerEnvios(p);
   
   end;
 
end;

procedure insertarHoja(Var a:arbol;n:Nue);
Begin 
   If (a=nil) then begin
    new(a);
    a^.dato:=n;
    a^.HI:=nil;
    a^.HD:=nil;
    end
    else begin If (n.totalEnvios<a^.dato.totalEnvios) then begin 
               writeln('Entre al HI');//Solo para ver como funciona y ver con ejemplos.
               insertarHoja(a^.HI,n);
               writeln('Sali del HI'); end
               else If (n.totalEnvios>a^.dato.totalEnvios) then begin
                    writeln('Entre al HD');
                    insertarHoja(a^.HD,n);
                    writeln('Sali del HD');
                    end;
          end;
end;

procedure minimo (var t:tipoPaquete;var min:paquete);
var indiceMin,i:integer;
begin
  
  min.codLocalidad:= 999;
  
  for i:=1 to dimf do begin
    
    if ((t[i] <> nil) AND (t[i]^.dato.codLocalidad< min.codLocalidad)) then begin
    
      min:= t[i]^.dato;
      indiceMin:=i;
      
      end;

   end;
  
  if(min.codLocalidad <>999) then t[indiceMin]:= t[indiceMin]^.sig;
  
end;

procedure mergeAcumulador(var a:arbol;t:tipoPaquete);
var min:paquete;totalEnvios:integer;actual:integer;n:Nue;
begin
   
   minimo(t,min);
   
   while( min.codLocalidad <>999 )  do begin
   
     actual:= min.codLocalidad; totalEnvios:=0;
    
     while(min.codLocalidad<>999) and (min.codLocalidad = actual) do begin
         
        totalEnvios := totalEnvios + 1;
        
        minimo(t,min);
      end;
    
    n.codLocalidad := actual;
    n.totalEnvios := totalEnvios;
    
    insertarHoja(a,n);
     
   end;

end;

function cantElementos (a:arbol;localidad:integer):integer;
begin

 if (a <> nil) then begin 
    if (a^.dato.codLocalidad = localidad) then
       cantElementos:=1+cantElementos(a^.HI,localidad)+cantElementos(a^.HD,localidad)
    else cantElementos:=cantElementos(a^.HI,localidad)+cantElementos(a^.HD,localidad);
 end
 else cantElementos:=0;

end;
           
Var t:tipoPaquete; a:arbol; localidad:integer;
begin
 vectorDeListas(t);

 mergeAcumulador(a,t);

 writeln('Ingrese localidad para sumar los envios');

 readln(localidad);

 writeln('La cantidad de elementos con la localidad ', localidad, ' son ', cantElementos(a,localidad));

end.
