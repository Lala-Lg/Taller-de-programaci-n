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
public class estanteriaMain {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        
        Estanteria e = new Estanteria (5,3);
        Libros l1 = new Libros ("A","AutorA",100);
        Libros l2 = new Libros ("B","AutorB",200);
        Libros l3 = new Libros ("C","AutorC",150);
        Libros l4 = new Libros ("D","AutorD",250);
        Libros l5 = new Libros ("E","AutorE",400);
        Libros l6 = new Libros ("F","AutorF",120);
        Libros l7 = new Libros ("G","AutorG",175);
        Libros l8 = new Libros ("H","AutorH",110);
        
        e.almacenarLibro(l1, 1, 1);
        e.almacenarLibro(l2, 1, 1);
        e.almacenarLibro(l3, 1, 2);
        e.almacenarLibro(l4, 1, 3);
        e.almacenarLibro(l5, 2, 1);
        e.almacenarLibro(l6, 2, 3);
        e.almacenarLibro(l7, 2, 2);
        e.almacenarLibro(l8, 5, 1);
        
        System.out.println(e.sacarLibro("AutorE"));
        System.out.println(e.calcular());
    }
    
}
