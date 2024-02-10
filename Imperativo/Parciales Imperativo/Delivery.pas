program delivery;

type 

menu = record
       codMenu:integer;
       cantidad:integer;
       end;

menusPedidos = ^nodoMenu;
nodoMenu = record
           dato:menu;
           sig:menusPedidos;
           end;

entrega = record
          codEntrega:integer;
          dniCliente:integer;
          m: menusPedidos;
          end;
    
entregasRealizadas = ^nodoEntrega;
nodoEntrega = record
              dato:entrega;
              sig:entregasRealizadas;
              end;
            
arbolMenus = ^nodoMenus;
nodoMenus = record 
            dato:menu;
            HI:arbolMenus;
            HD:arbolMenus;
            end;

lNueva = ^nodo;
nodo = record
       dato:integer;
       sig:lNueva;
       end;
       
       //Leer menus
       //leer entregas y para cada entrega cargarMenus
       //posicionar en la lista
procedure cargarEntregas (var e: entregasRealizadas); //Se dispone
begin
end;

       //crearHijo - se ordena por codigo de menu
procedure cargarArbol(var a:arbolMenus);
begin
end;

procedure actualizarStock(var a:arbolMenus; m:menu);
begin
	if(a = nil)then begin
		new(a);
		a^.dato.cantidad:= 0;
		a^.dato.codMenu:= m.codMenu;
		a^.HI:= nil;
		a^.HD:= nil;
	end
	else
		if (a^.dato.codMenu = m.codMenu) then 
			a^.dato.cantidad:= a^.dato.cantidad - m.cantidad
		else 
			if (m.codMenu< a^.dato.codMenu) then
				actualizarStock(a^.HI, m)
			else
				actualizarStock(a^.HD, m);
end;

Procedure recorrerEntregas (e:entregasRealizadas; var a:arbolMenus);

begin

  if (e <> nil) then //Caso base implícito
  
    begin
    
     while( e^.dato.m <> nil ) do begin
        actualizarStock(a,e^.dato.m^.dato);
        e^.dato.m := e^.dato.m^.sig;
        end;
     
     recorrerEntregas (e^.sig,a);
     
    end;
    
 end;
 
procedure insertarAdelante(var l,ult:lNueva; c:integer);
var aux:lNueva;
begin
	New(aux);
	aux^.dato:=c;
	aux^.sig:=nil;
	if l=nil then l:=aux
	else ult^.sig:=aux;
	ult:=aux;
end;
 
procedure retornarLista(a:arbolMenus; codigo:integer; var lNue:lNueva);
var ult:lNueva;
begin
   
   if(a<>nil) then
     
     if(a^.dato.codMenu< codigo) then
     
        if(a^.dato.cantidad = 1) then begin
           
           insertarAdelante(lNue,ult,a^.dato.codMenu);
           
        end
        
        retornarLista(a^.hi,codigo,lNue);
        retornarLista(a^.hd,codigo,lNue);
     
   else retornarLista(a^.hi,codigo,lNue);
   
end;

var e:entregasRealizadas; a:arbolMenus; lNue:lNueva; codigo:integer;
Begin
  
  e:=nil; a:=nil;
  cargarEntregas(e);
  cargarArbol(a);
  
  recorrerEntregas(e,a);
  
  writeln('Ingrese un codigo');
  
  readln(codigo);
  
  lNue:=nil;
  
  retornarLista(a,codigo,lNue);
  
End.
