/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package estanteriaLibros;

/**
 *
 * @author laule
 */
public final class Estanteria {
    private Libros estanterias [][];
    private int n_estantes;
    private int m_libros;
    
    private int cantLibros;
    private int estantesOcupados;
    
    int i; int j;
    
    public void inicializarEstantes (){
        for(i=0;i<this.n_estantes;i=i+1){
            for(j=0;j<this.m_libros;j=j+1){
                estanterias[i][j] = null;
            }
        }
    }

    public Estanteria(int n_estantes, int m_libros) {
        this.n_estantes = n_estantes;
        this.m_libros = m_libros;
        this.estanterias = new Libros [n_estantes][m_libros];
        this.cantLibros = 0;
        this.estantesOcupados = 0;
        this.inicializarEstantes();
    }

    public int getCantLibros() {
        return cantLibros;
    }

    public void setCantLibros(int cantLibros) {
        this.cantLibros = cantLibros;
    }

    public int getEstantesOcupados() {
        return estantesOcupados;
    }

    public void setEstantesOcupados(int estantesOcupados) {
        this.estantesOcupados = estantesOcupados;
    }
    
    public int getN_estantes() {
        return n_estantes;
    }

    public void setN_estantes(int n_estantes) {
        this.n_estantes = n_estantes;
    }

    public int getM_libros() {
        return m_libros;
    }

    public void setM_libros(int m_libros) {
        this.m_libros = m_libros;
    }

    public Libros[][] getEstanterias() {
        return estanterias;
    }  
    
    public void almacenarLibro(Libros l, int estante, int lugar){
        estanterias [estante-1][lugar-1] = l;
    }
    
    public String sacarLibro (String titulo){
        i = 0; j= 0;
        String aux = "No se encontró un libro con ese titulo"; boolean corte = true;
          while ((i<n_estantes)&&(corte)){
             while ((j<m_libros)&&(i<n_estantes)&&(corte)){
                 if (estanterias[i][j] != null){
                   if (estanterias[i][j].getTitulo().equals(titulo)){
                    corte = false;
                   } 
                 }
               j++;
             }
             i++;
             j=0;
          }
        if (!corte) {
            aux = estanterias[i][j].getTitulo();
            estanterias[i][j] = null;
        }
        return aux;
    }
    
    public String calcular (){
        String aux = "No hay datos cargados "; double max = -1; int fila = 0,columna = 0;
        i = 0; j = 0;
        while ((i<n_estantes)&&(estanterias[i][j] != null)){
            while ((j<m_libros)&&(i<n_estantes)&&(estanterias[i][j] != null)){{
                if (estanterias[i][j].getPeso()>max){
                    max = estanterias[i][j].getPeso();
                    fila = i;
                    columna = j;
                }
                j++;
            }
            i++;
            j=0;
        }
        
        if (max != -1){
        aux = estanterias[fila][columna].toString();
        }
    
        }
        
        return aux;
    } 
}   
