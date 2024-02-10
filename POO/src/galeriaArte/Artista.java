package galeriaArte;

public class Artista {
    private String nombre;
    private String seDestaca;
    private String obrasExhibidas [];
    private int diml;
    private final int dimF = 5;

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getSeDestaca() {
        return seDestaca;
    }

    public void setSeDestaca(String seDestaca) {
        this.seDestaca = seDestaca;
    }

    public int getDiml() {
        return diml;
    }

    public void setDiml(int diml) {
        this.diml = diml;
    }
    
    int i;
    
    private void inicializarObras (){
        for (i = 1; i < dimF; i = i+1){
            obrasExhibidas[i] = null;
        }
    }
//Constructor
    public Artista(String nombre, String seDestaca) {
        
        this.nombre = nombre;
        this.seDestaca = seDestaca;
        this.obrasExhibidas = new String [dimF];
        this.diml = 0;
        //El nombre de 1 obra.
        obrasExhibidas [0] = "Obra ejemplo";
        inicializarObras();
        
    }
    
    public void agregarObra (String obra){
        
        if (diml<dimF){           
            obrasExhibidas[diml] = obra;                
            this.setDiml(diml+1);
        }
        
    }
    
    @Override
    public String toString (){
        String x;
        
        
        x = "Artista: " + this.getNombre() + "\n" + "Destacado en el arte "  +  this.getSeDestaca() + "\n";
        
        x = x + "Obras exhibidas: " + "\n";
        
        for (i = 0; i<diml ; i =i+1) {  
          x = x + obrasExhibidas [i] + "\n";
        }
        
        return x;
    }
    
}
