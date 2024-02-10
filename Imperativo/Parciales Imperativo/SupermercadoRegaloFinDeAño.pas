program SupermercadoRegaloFinDeAnio;

const 
 
 sucursales = 20;
 clientes = 5000;
 
type 
  
  str = string [20];
  
  venta = record
          dia:integer;
          dni:integer;
          factura:real;
          monto:real;
          end;
  
  lista = ^nodo;
  nodo = record
         dato:venta;
         sig:lista;
         end;
  
  vector1 = array [1..sucursales] of lista;
  
  cliente = record
            dni:integer;
            email:str;
            telefono:integer;
            end;
            
  vector2 = array [1..clientes] of cliente;
  
procedure leerVenta(var v:venta);//Se dispone
begin 
end;
procedure insertarOrdenado (Var l:lista;v:venta);//Se dispone
begin
end;
procedure cargarVector1(var v1:vector1); //Se dispone
begin
end;

procedure leerCliente(var c:cliente); //Se dispone
begin 
end;
procedure cargarVector2(var v2:vector2); //Se dispone
begin
end;

Procedure ordenarPorInsercion (var v2:vector2);
var 
  i,j:integer; 
  actual:cliente;
begin
  for i:=2 to clientes do begin
     actual:= v2[i]; 
     j:= i-1;  
     while (j > 0) and (v2[j].dni > actual.dni) do begin
        v2[j+1]:= v2[j];
        j:= j- 1;
     end;
     v2[j+1]:=actual;
   end;
end;

procedure busquedaDicotomica (v2:vector2; inicio,fin:integer; dni:integer; var pos: integer);
var
  medio:integer;
begin
  if (inicio>fin)then
    pos:=-1
  else
    begin
      medio:=(inicio+fin)div 2;
      if (dni = v2[medio].dni)then
        pos:=medio
      else
       begin
        if (dni<v2[medio].dni)then
          busquedaDicotomica(v2,inicio,medio-1,dni,pos)
        else
          busquedaDicotomica(v2,medio+1,fin,dni,pos);
       end;
         
    end;
end;

procedure maximo(var v1: vector1; var max: venta); 
var
  i, indiceMax: integer;
begin
  max.monto:= -1;
  for i:= 1 to sucursales do begin 
     if (v1[i] <> nil) and (v1[i]^.dato.monto < max.monto) then begin 
  	    max:=v1[i]^.dato;
        indiceMax:=i;
     end;
  end;
  if (max.monto <> -1) then 
     v1[indiceMax]:=v1[indiceMax]^.sig;
end;

procedure mergePeliculas (v1:vector1; v2:vector2; inicio,fin:integer; dni:integer; pos: integer);
var max:venta;  diaActual:integer;
begin 
  maximo(v1,max);
  
  while(max.dni>999)do begin
  
   diaActual:= max.dia;
   
   while(max.dni <>999) and (diaActual = max.dia) do begin
   
    maximo(v1,max);
    max.dni:= dni;
    
   end;
   
   writeln('Para el dia ', max.dia, 'el mayor monto fue ', max.monto);
   writeln(' Dni: ', max.dni);
   
   busquedaDicotomica (v2,inicio,fin,max.dni,pos);
   
   if (pos <> -1) then begin
   
     writeln('Email del cliente: ', v2[pos].email);
     writeln('Telefono : ', v2[pos].telefono);
   
  end
  else writeln('premio vacante');
  
  end;
  
end;

Var 
 v2:vector2;
 v1:vector1;

Begin

cargarVector1(v1);
cargarVector2(v2);

End.
