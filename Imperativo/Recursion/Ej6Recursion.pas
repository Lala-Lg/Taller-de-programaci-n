{
6.- Realizar un programa que lea números 
y que utilice un procedimiento recursivo que 
escriba el equivalente en binario de un número decimal. 
El programa termina cuando el usuario ingresa el número 0 (cero). 
}


program E6Recursion;

procedure equivaleteBinario (decimal:integer);
begin
  
   if (decimal <> 0) then begin
     equivaleteBinario(decimal div 2);
     write(decimal mod 2);
   end;          
    
end;

var num:integer;

begin

 writeln('Ingrese numero para saber su equivalente binario');
 readln(num);
 
 while (num <>0) do begin
 
  writeln('El numero binario es: ');
 
  equivaleteBinario(num);
  
  writeln('');
  
  writeln('Ingrese numero para saber su equivalente binario');
  
  readln(num);
 end;
 
end.