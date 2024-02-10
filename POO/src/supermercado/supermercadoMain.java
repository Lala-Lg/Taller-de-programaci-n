/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package supermercado;

/**
 *
 * @author laule
 */
public class supermercadoMain {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        TicketNormal t1 = new TicketNormal (290,"2 de Noviembre");
        
        t1.inicializarProductos();
        
        Producto p1 = new Producto (20,800);
        Producto p2 = new Producto (19,500);
        t1.cargarProducto(p1);
        t1.cargarProducto(p2);
        
        System.out.println("Lleva 100 productos en total: " + t1.estaCompleto());
        System.out.println("El precio final es: " + t1.precioFinal());
        
        TicketDescuento t2 = new TicketDescuento (300,"13 de Octubre", 20);
        Producto p3 = new Producto (10,250);
        Producto p4 = new Producto (12,1200);
        
        t2.cargarProducto(p3);
        t2.cargarProducto(p4);
        
        System.out.println("Lleva 100 productos en total: " + t2.estaCompleto());
        System.out.println("El precio final es: " + t2.precioFinal());
        
    }
    
}
