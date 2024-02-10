program parcial41SucursalesyVentasMatriz;

const dimF = 5; dimC = 200;
      corte = -1;
type

venta = record 
        codProducto:integer;
        cantidadVendida:integer;
        montoTotal:real;
        end;
        
ventas = array[1..dimC] of venta;
        
firulai = record
          v:ventas;
          diml:integer;
          end;

sucursales = array [1..dimF] of firulai;

lista = ^nodo;
nodo = record
       dato:real;
       sig:lista;
       end;

procedure leerVenta (var v:venta);
begin
     
     readln(v.codProducto);
     
     if (v.codProducto <> corte) then begin
     
       readln(v.cantidadVendida);
       readln(v.montoTotal);
      
     end;
     
end;

procedure cargarVector(var ve:ventas;var s:sucursales);
var v:venta; j:integer; i:integer;
begin

   for i:=1 to dimF do begin
     
     j:=1;
     
     repeat 
      
      leerVenta(v);
      
      s[i].v[j]:= v;
      
      j:=j+1;
      
     until((v.codProducto = corte) OR (j < dimC));
     
     s[i].dimL:= j;
     
   end;

end;

Procedure Minimo(var s:sucursales; var min:venta);
var
    j:integer;
	i:integer;
	posF:integer;
	posC:integer;
begin
	posF:=-1;
	posC:=-1;
	min.codProducto:=9999;
	for i:=1 to dimF do begin
	  j:=1;
	  while (j < s[i].dimL) do begin
			if (s[i].v[j].codProducto < min.codProducto) then begin
				posF:=i;
				PosC:=j;
				min.codProducto:= s[i].v[j].codProducto;
		    end;
		    j:=j+1;
	   end;
	end;
	if(min.codProducto<>9999)then begin
	 	for i:=posF to dimF do 
	 	  for j:=posC to s[i].dimL-1 do begin
               s[i].v[j]:= s[i].v[j+1];
               s[i].dimL:= s[i].dimL-1;
          end;
	end;
end;

Procedure AgregarAdelante(var l:lista; cant:real);
var 
	nue:lista;
begin
  new(nue);
  nue^.dato:=cant;
  nue^.sig:=l;
  l:=nue;
end;

Procedure Merge(s:sucursales; var l:lista);
var
	actual:integer;
	min:venta;
    totalVendida:real;
    i:integer;
    j:integer;
begin 
		l:=nil;
		Minimo(s,min);
		i:=1; j:=1;
		
		while((min.codProducto <> 9999) AND (i<dimF)) do begin
		    actual:=s[i].v[j].codProducto; totalVendida:=0;
			while ((min.codProducto <> 9999) AND (j < s[i].diml) AND (actual = s[i].v[j].codProducto)) do begin
			       totalVendida:= totalVendida + s[i].v[j].cantidadVendida;
				   Minimo(s,min);
				   j:=j+1;
			end;
			
			AgregarAdelante(l,totalVendida);
			
			i:=i+1;
			
		end;
end;

function cantidadQueSupera(l:lista):integer;
begin
      if (l = nil) then begin
      
        cantidadQueSupera:=0;
      
      end
      else if(l^.dato > 500) then 
           
           cantidadQueSupera:=1+cantidadQueSupera(l^.sig);
      
end;

var v:ventas;s:sucursales;l:lista;

begin

cargarVector(v,s); 

merge(s,l);

writeln('la cantidad de productos para los cuales la cantidad vendida supera 500 es', cantidadQueSupera(l));

end.
