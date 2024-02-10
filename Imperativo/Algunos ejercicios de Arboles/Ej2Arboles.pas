program Ej2Arboles;

const finLectura = 0;

type 
  
  f = record
    dia:1..30;
    mes:1..12;
    end;
    
  registro1 = record
    codProd:integer;
    fecha:f;
    cantVendida:integer;
    end;
  
  registro2 = record
    codProd:integer;
    cantVendida:integer;
    end;
 
 arbol = ^nodo;
 nodo = record
         venta:registro1;
         hi:arbol;
         hd:arbol;
         end;
         
 arbol2 = ^nodo2;
 nodo2 = record
         venta:registro2;
         hi:arbol2;
         hd:arbol2;
         end;

procedure crearArbol(var a:arbol);
//.
procedure leerRegistro1(var r:registro1);
//.
procedure leerFecha(var fe:f);
begin
  with fe do begin
    dia:=random(30);
    mes:=random(12);
    end;
end;
//.
begin
  with r do begin
    codProd:=random(100);
    if (codProd <> finLectura) then begin
      leerFecha(fecha);
      cantVendida:=random(20);
    end;
  end;
end;
//.
procedure insertarHijo(var a:arbol;r:registro1);
begin
  if (a = nil) then begin
    new(a);
    a^.venta:=r;
    a^.hi:=nil;
    a^.hd:=nil;
  end
  else begin
         if (r.codProd < a^.venta.codProd) then begin
            insertarHijo(a^.hi,r);
            end
         else insertarHijo(a^.hd,r);
        end;
end;
//.
var r:registro1;
begin
  a:=nil;
  leerRegistro1(r);
  while (r.codProd <> 0) do begin
    insertarHijo(a,r);
    leerRegistro1(r);
    end;
end;

procedure recorrerArbol (a:arbol;var a2:arbol2);
//---------------------------------------------------------//
procedure copiarRegistro(r1:registro1; var r2:registro2);
begin
  r2.codProd:=r1.codProd;
  r2.cantVendida:=r1.cantVendida;
end;
//---------------------------------------------------------//
procedure insertarHijo2(var a2:arbol2;r2:registro2);
begin
  if (a2 = nil) then begin
    new(a2);
    a2^.venta:=r2;
    a2^.hi:=nil;
    a2^.hd:=nil;
  end
  else begin
         if (r2.codProd < a2^.venta.codProd) then begin
            insertarHijo2(a2^.hi,r2);
            end
         else if (r2.codProd > a2^.venta.codProd) then begin
                 insertarHijo2(a2^.hd,r2);
                 end;
        end;
end;
//---------------------------------------------------------//
var r2:registro2;
begin
  if (a <> nil) then begin
    copiarRegistro(a^.venta,r2);
    insertarHijo2(a2,r2);
    recorrerArbol(a^.hd,a2);
    recorrerArbol(a^.hi,a2);
  end;
end;

procedure imprimirArbol(a:arbol);
begin
 if(a<>nil) then begin
  imprimirArbol(a^.HI);
  write('CodProd: ',a^.venta.CodProd,'| ');
  write('Cantidad vendida por unidad: ',a^.venta.cantVendida,'| ');
  write('Fecha de venta: ',a^.venta.fecha.dia,'/',a^.venta.fecha.mes);
  writeln('');
  imprimirArbol(a^.HD);
  end;
end;

procedure imprimirArbol2(a:arbol2);
begin
 if(a<>nil) then begin
  imprimirArbol2(a^.HI);
  write('CodProd: ',a^.venta.CodProd,'| ');
  write('Cantidad vendida por unidad: ',a^.venta.cantVendida,'| ');
  writeln('');
  imprimirArbol2(a^.HD);
  end;
end;

procedure InformarCantidadTotalUnidades(a:arbol);
//---------------------------------------------------------//
function sumaTotal (a:arbol;codigo:integer):integer;
begin
  if(a = nil) then sumaTotal:=0
  else begin if (a^.venta.CodProd = codigo) then sumaTotal:=a^.venta.cantVendida+sumaTotal(a^.HI,codigo)+sumaTotal(a^.HD,codigo)
             else sumaTotal:=sumaTotal(a^.HI,codigo)+sumaTotal(a^.HD,codigo);
       end;
end;
//---------------------------------------------------------//
//El último inciso es lo mismo solo que para el segundo arbol.
//---------------------------------------------------------//
var codigo:integer;
begin
  writeln('Ingrese un codigo de producto: ');
  readln(codigo);
  writeln('La cantidad total de unidades ventidas del producto con codigo ', codigo, ' es: ',sumaTotal(a,codigo));
  writeln('');
end;
var a:arbol;a2:arbol2;
begin
  crearArbol(a);
  writeln('-------------------------------->');
  writeln('Lectura del primer arbol: ');
  writeln('-------------------------------->');
  imprimirArbol(a);
  writeln('-------------------------------->');
  writeln('Se recorrerá el primero..');
  recorrerArbol(a,a2);
  writeln('-------------------------------->');
  writeln('Lectura del segundo arbol: ');
  writeln('-------------------------------->');
  imprimirArbol2(a2);
  writeln('-------------------------------->');
  InformarCantidadTotalUnidades(a);
end.
