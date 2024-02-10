package galeriaArte;

public class galeriaArte {

    public static void main(String[] args) {
        
        Catalogo catalogo = new Catalogo();
     
        Artista a1 = new Artista ("Da Vinci","realista");
        Artista a2 = new Artista ("Vincent Van Gogh","abstracto");
        Artista a3 = new Artista ("Bruno","de rascarse los huevos");
        
        catalogo.agregarArtista(a1);
        
        a1.agregarObra("La Gioconda");
        a1.agregarObra("La ultima cena");
        
        catalogo.agregarArtista(a2);
        
        a2.agregarObra("La noche estrellada");
        a2.agregarObra("Los Girasoles");
        
        catalogo.agregarArtista(a3);
        
        a3.agregarObra("Vagancia");
        a3.agregarObra("Procrastinacion");
        
        System.out.println("La cantidad de artistas agregados fueron: " + catalogo.getDiml());

        System.out.println("El siguiente artista se destaca en el arte: "+catalogo.buscarArtista("Bruno"));
        
        System.out.println(catalogo.toString());
    }
    
}
