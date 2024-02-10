package galeriaArte;

public class Catalogo {
    
    private Artista artistas [];
    private int diml;
    private final int dimF = 15;
    
    public Artista[] getArtistas() {
        return artistas;
    }

    public int getDiml() {
        return diml;
    }

    public void setDiml(int diml) {
        this.diml = diml;
    } 
    
    int i;
    
    private void inicializarArtista (){
        for (i = 0; i < dimF; i = i+1){
            artistas[i] = null;
        }
    }
    
//Inicializo el vector. Queda vacío.
    public Catalogo() {
        this.diml = 0;
        this.artistas = new Artista [dimF];
        this.inicializarArtista();
    }
    
    public void agregarArtista (Artista a){
        
        if (diml <dimF) {
            
            artistas[diml] = a;
            this.setDiml(diml+1);
            
        }
        
    }
    
    public String buscarArtista (String nombre){
        String x = "El nombre del artista no coincide con ninguno entre los datos registrados";
        i = 0;
        while ((i<diml) && (!(artistas[i].getNombre().equals(nombre)))) {
             
            i++;
        }
        
        if (artistas[i].getNombre().equals(nombre)) {
            
            x = artistas[i].getSeDestaca();
        }
        
        return x;
    }

    
    @Override
    public String toString (){
        String x = "No hay artistas cargados";
        
        for (i = 0; i < diml; i = i+1){
            
            x = "Artista " + (i+1) + ": "+ "\n" + artistas[i].toString() + "\n";
            
        }
        
        return x;
    }
    
}
