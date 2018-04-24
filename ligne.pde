class ligne {
  String numero=new String();
  color couleur;
  StringList extremites=new StringList();
  JSONArray liste_station=new JSONArray();
  ArrayList<station> Stations=new ArrayList<station>();


  ligne(String numero, String extremite1, String extremite2, color couleur) {
    this.numero=numero;
    this.extremites.append(extremite1);
    this.extremites.append(extremite2);
    this.couleur=couleur;
  }
}
#Adding new comment
