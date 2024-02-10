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
public abstract class Ticket {
    
    private int nroTicke;
    private String fecha;
    private Producto productos [];
    private int diml;
    int dimf = 100;

    public Ticket(int nroTickes, String fecha) {
        this.nroTicke = nroTickes;
        this.fecha = fecha;
        this.productos = new Producto [dimf];
        this.diml = 0;
    } 

    public int getNroTickes() {
        return nroTicke;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public Producto[] getProductos() {
        return productos;
    }

    public void setProductos(Producto[] productos) {
        this.productos = productos;
    }

    public int getDiml() {
        return diml;
    }

    public void setDiml(int diml) {
        this.diml = diml;
    }
    
    abstract void inicializarProductos();
    
    abstract void cargarProducto(Producto p);
    
    abstract boolean estaCompleto();
    
    abstract double precioFinal();

}
