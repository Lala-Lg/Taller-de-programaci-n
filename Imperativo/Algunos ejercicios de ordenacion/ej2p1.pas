program ej4p1;

type
sub:1..8;
producto = record
codigoProducto:integer;
codigoRubro:sub;
precio:real;
end;
lista = nodo^;
nodo= record
      dato:producto;
      sig:lista;
      end;
vector = array sub of lista;

procedure inicializarVector(var v:vector);
begin
end;

procedure agruparCodigoProducto(var g: vector_genero);

var p:pelicula; ult:lista; i:integer;

begin
 
  inicializarVector(g);
   
    leerPelicula(p); 
  
    while(p.cod_pelicula <> -1) do begin 
  
      agregarAlFinal(g[p.cod_genero],ult,p);
  
      leerPelicula(p);
  
    end;

end;
