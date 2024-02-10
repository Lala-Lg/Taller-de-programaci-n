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
public class Libros {
    private String titulo;
    private String primerAutor;
    private double peso;

    public Libros(String titulo, String primerAutor, double peso) {
        this.titulo = titulo;
        this.primerAutor = primerAutor;
        this.peso = peso;
    }
    
    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getPrimerAutor() {
        return primerAutor;
    }

    public void setPrimerAutor(String primerAutor) {
        this.primerAutor = primerAutor;
    }

    public double getPeso() {
        return peso;
    }

    public void setPeso(double peso) {
        this.peso = peso;
    }
    
    public String toString (){
        String aux;
        aux = "Libro: "+ "\n" + this.getTitulo() + "\n" + this.getPrimerAutor() + "\n" + this.getPeso();
        return aux;
    }
}
