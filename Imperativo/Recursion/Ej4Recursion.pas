{
4.- Escribir un programa que:
a. Implemente un módulo recursivo que genere un vector de 20 números enteros “random” mayores a 0 y menores a 100. 
b. Implemente un módulo recursivo que devuelva el máximo valor del vector. 
c. Implementar un módulo recursivo que devuelva la suma de los valores contenidos en el vector.
}


program E4Recursion;

const 
limite = 100;
dimf = 20;

type 
vector = array [1..dimf] of integer;

procedure crearVector (var v:vector;var diml:integer);
  procedure generarVector(var v:vector; var diml:integer);
  begin
    if (diml <= dimf) then begin
      diml:=diml+1;
      v[diml]:=random(limite);
      generarVector(v,diml);
      end;
  end;
begin
  diml:=0;
  generarVector(v,diml);
end;

procedure imprimirVectorRecursivo(v:vector;diml:integer);
begin
  if (diml > 0) then begin
    imprimirVectorRecursivo(v,diml-1);
    write(v[diml],'|');
    end;
end;

function maximoV(v: vector; dimL: integer): integer;
begin
	if (dimL>1) then begin
		maximoV:=maximoV(v,dimL-1);
		if (v[dimL]>maximoV) then maximoV:=v[dimL];
	end
	else maximoV:=v[dimL];
end;

procedure maximoV2(v:vector;diml:integer;var max:integer);
begin
  if (diml>1) then begin
    maximoV2(v,diml-1,max);
    if(v[diml]>max) then max:=v[dimL];
  end
  else max:=v[dimL];
end;

function suma(v: vector; dimL: integer): integer;
begin
	if (dimL>1) then begin
	    suma:=suma(v,dimL-1);
	    suma:=suma+v[dimL];
	end
	else suma:=v[dimL];
end;

var v:vector; diml:integer; max:integer;
begin
  max:=-1;
  crearVector(v,diml);
  writeln('Lectura recursiva del vector: ');
  imprimirVectorRecursivo(v,diml);
  writeln('');
  writeln('El maximo en el vector es: ', maximoV(v,diml));
  maximoV2(v,diml,max);
  writeln(max);
  writeln('');
  writeln('La suma de todos los elementos del vector es: ',suma(v,dimL));
end.
