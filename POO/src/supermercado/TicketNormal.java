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
public class TicketNormal extends Ticket{

    public TicketNormal(int nroTicke, String fecha) {
        super(nroTicke, fecha);
    }
    
    int i;
    @Override
    void inicializarProductos() {
        for (i = 0; i< super.getDiml(); i = i+1){
            super.getProductos()[i] = null;
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
    public void cargarProducto(Producto p) {
        if (super.getDiml()<super.dimf){       
            super.getProductos()[super.getDiml()] = p; 
            super.setDiml(super.getDiml()+1);
        }
    }
    
    @Override
    public double precioFinal(){
        double aux = 0;
         if (super.getDiml() != 0){
             for (i=0;i<super.getDiml(); i = i+1){
                 aux = aux + super.getProductos()[i].getPrecio();
             }
         }
        return aux;
    }
    
}
