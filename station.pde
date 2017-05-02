class station {
  String nom;
  IntList stop_ids= new IntList();
  IntList correspondances=new IntList();
  PVector position_gps = new PVector();
  PVector position_screen = new PVector();
  StringList amene_a = new StringList();
  
  station(String new_nom,PVector new_position_gps, int new_stop_id){
    this.nom=new String(new_nom);
    this.position_gps=new_position_gps;
    this.stop_ids.append(new_stop_id);
  }
  
  void setScreenPosition(){
       this.position_screen.set((this.position_gps.x-min_lon)*fact_lon,(this.position_gps.y-min_lat)*fact_lat);
  }
  void addCorrespondance(int correspondance){
    this.correspondances.append(correspondance);
  }
  
  IntList getCorrespondances(){
    return(this.correspondances);
  }
}