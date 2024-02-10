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
public class TicketDescuento extends Ticket{

    private double descuento;
    
    public TicketDescuento(int nroTickes, String fecha, double descuento) {
        super(nroTickes, fecha);
        this.descuento = descuento;
    }

    public double getDescuento() {
        return descuento;
    }

    public void setDescuento(double descuento) {
        this.descuento = descuento;
    }
    
    int i;
    @Override
    void inicializarProductos() {
        for (i = 0; i< super.getDiml(); i = i+1){
            super.getProductos()[i] = null;
        }
    }

    @Override
    public void cargarProducto(Producto p) {
        if (super.getDiml()<super.dimf){       
            super.getProductos()[super.getDiml()] = p; 
            super.setDiml(super.getDiml()+1);
        }
    }

    @Override
    boolean estaCompleto() {
        boolean aux = false;
        if (super.getDiml() == dimf){
                aux = true;
        }       
        return aux;
    }
    
    @Override
    public double precioFinal(){
        double aux = 0;
         if (super.getDiml() != 0){
             for (i=0;i<super.getDiml(); i = i+1){
                 aux = aux + super.getProductos()[i].getPrecio();
             }
             aux = ((aux * 20) / 100);
         }
        return aux;
        
    }

}
