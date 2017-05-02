float max_lat;
float min_lat;
float max_lon;
float min_lon;
JSONArray values;
JSONObject json;
float fact_lon;
float fact_lat;
String[] repertoire_data_ligne = new String[] {
  "RATP_GTFS_METRO_1", 
  "RATP_GTFS_METRO_2", 
  "RATP_GTFS_METRO_3", 
  "RATP_GTFS_METRO_3b", 
  "RATP_GTFS_METRO_4", 
  "RATP_GTFS_METRO_5", 
  "RATP_GTFS_METRO_6", 
  "RATP_GTFS_METRO_7", 
  "RATP_GTFS_METRO_7b", 
  "RATP_GTFS_METRO_8", 
  "RATP_GTFS_METRO_9", 
  "RATP_GTFS_METRO_10", 
  "RATP_GTFS_METRO_11", 
  "RATP_GTFS_METRO_12", 
  "RATP_GTFS_METRO_13", 
  "RATP_GTFS_METRO_14"
};
color [] ligne_color = new color[] {
  #ffcd00, 
  #003ca6, 
  #837902, 
  #6ec4e8, 
  #cf009e, 
  #ff7e2e, 
  #6eca97, 
  #fa9aba, 
  #6eca97, 
  #e19bdf, 
  #b6bd00, 
  #c9910d, 
  #704b1c, 
  #007852, 
  #6ec4e8, 
  #62259d
};
ArrayList<ligne> Ligne= new ArrayList<ligne>();


void setup() {
  fullScreen();
  background(0);
  //values = loadJSONArray("positions-geographiques-des-stations-du-reseau-ratp-metro_only.json");
  //for (int i=0; i<values.size(); i++) {
  //  JSONObject station_arret = values.getJSONObject(i);
  //  JSONObject station_field = station_arret.getJSONObject("fields");
  //  //JSONObject station_geometry = station_arret.getJSONObject("geometry");
  //  //print ("Station : ", station_field.getString("stop_name"), "\n");
  //  //print ("Arrêt :", station_field.getString("stop_desc"), "\n");
  //  //float lat=station_field.getString("stop_lat");
  //  //float lon=station_field.getString("stop_lon");
  //  //print ("Localisation : lattitude ", station_field.getFloat("stop_lat"), ", longitude ", station_field.getFloat("stop_lon"), "\n");
  //  if (i==0) {
  //    min_lat=station_field.getFloat("stop_lat");
  //    max_lat=station_field.getFloat("stop_lat");
  //    min_lon=station_field.getFloat("stop_lon");
  //    max_lon=station_field.getFloat("stop_lon");
  //  } else {
  //    min_lat=min(min_lat, station_field.getFloat("stop_lat"));
  //    max_lat=max(max_lat, station_field.getFloat("stop_lat"));
  //    min_lon=min(min_lon, station_field.getFloat("stop_lon"));
  //    max_lon=max(max_lon, station_field.getFloat("stop_lon"));
  //  }
  //  //fact_lon=width/(max_lon-min_lon);
  //  //fact_lat=height/(max_lat-min_lat);
  //  //print ("min_lat=", min_lat, " max_lat=", max_lat, "\n");
  //  //print ("min_lon=", min_lon, " max_lon=", max_lon, "\n");
  //  //print ("fact_lon ", fact_lon, " : fact_lat ", fact_lat, "\n");
  //  //delay(20000);
  //}
  //print ("fact_lon ", fact_lon, " : fact_lat ", fact_lat, "\n");
  //delay(10000);
  for (int i=0; i<repertoire_data_ligne.length; i++) {
    Ligne.add(loadLigne(repertoire_data_ligne[i], ligne_color[i]));
  }
  //fact_lon=width/(max_lon-min_lon);
  //fact_lat=height/(max_lat-min_lat);
  //print ("min_lat=", min_lat, " max_lat=", max_lat, "\n");
  //print ("min_lon=", min_lon, " max_lon=", max_lon, "\n");
  //print ("fact_lon ", fact_lon, " : fact_lat ", fact_lat, "\n");
  //for (int i=0; i<repertoire_data_ligne.length; i++) {
  //  Ligne.get(i).Stations=loadStation(repertoire_data_ligne[i]);
  //  //print("ligne ", i, " : ", Ligne.get(i).Stations.size(), " stations\n");
  //  //for (int j=0; j<Ligne.get(i).Stations.size(); j++) {
  //  //  print(Ligne.get(i).Stations.get(j).nom, "\n");
  //  //}
  //}
  find_correspondance();
  setScreen_parameters();

  noLoop();
}

void draw() {
  drawLignes();

  //for (int i=0; i<values.size(); i++) {
  //  float x;
  //  float y;
  //  JSONObject station_arret = values.getJSONObject(i);
  //  JSONObject station_field = station_arret.getJSONObject("fields");
  //  x=(station_field.getFloat("stop_lon")-min_lon)*fact_lon;
  //  y=(station_field.getFloat("stop_lat")-min_lat)*fact_lat;
  //  print ("Arrêt ", i, " : x=", x, ", y=", y, "\n");
  //  //print ("min_lat=",min_lat," max_lat=",max_lat,"\n");
  //  //print ("min_lon=",min_lon," max_lon=",max_lon,"\n");
  //  //print ("fact_lon ", fact_lon, " : fact_lat ", fact_lat, "\n");
  //  fill(#27699C, 30);
  //  stroke(#19C0F8);

  //  ellipse(x, y, 10, 10);
  //}
}

ligne loadLigne(String filename, color color_ligne) {
  ligne Ligne;
  Table table=new Table();
  String [] numero=split(filename, "_");
  table = loadTable(filename+"/routes.txt", "header, csv");
  TableRow row=table.getRow(0);
  String fromto=row.getString("route_long_name");
  int debfromto=fromto.indexOf("(");
  int endfromto=fromto.indexOf(")");
  fromto=fromto.substring(debfromto+1, endfromto);
  String [] destination1 = split(fromto, " <-> ");
  print("ligne n°", numero[3], " fromto : ", fromto, ", From : \"", destination1[0], "\" to : \"", destination1[1], "\"\n");
  Ligne=new ligne(numero[3], destination1[0], destination1[1], color_ligne);
  Ligne.Stations=new ArrayList<station>();
  Ligne.Stations=loadStation(filename,Ligne.Stations);
  for (int j=0; j<Ligne.Stations.size(); j++) {
    //print ("Ligne color=", ligne_color, " station : ", Ligne.Stations.get(j).nom, " : x=", x, ",y=", y, "\n");
    print ("Ligne color=", ligne_color, " station : ", Ligne.Stations.get(j).nom, " : x=", Ligne.Stations.get(j).position_gps.x, ",y=", Ligne.Stations.get(j).position_gps.y, "\n");
  }


  return(Ligne);
}

ArrayList<station> loadStation(String filename,ArrayList<station> tmp_Stations) {
  StringList list_name_station=new StringList();
  Table table=new Table();
  String stop_name=new String();
  PVector position=new PVector();
  table = loadTable(filename+"/stops.txt", "header, csv");
  for (TableRow row : table.rows()) {
    stop_name=row.getString("stop_name");
    //print("loadStation stop_name = ", stop_name, "\n");
    //print(list_name_station, "\n");
    if (list_name_station.hasValue(stop_name)) {
      for (int i=0; i<tmp_Stations.size(); i++) {
        if (!tmp_Stations.get(i).nom.equals(stop_name)) {
          continue;
        }
        tmp_Stations.get(i).stop_ids.append(row.getInt("stop_id"));
      };
      //print (tmp_Stations.get(i), "\n");//
    } else {
      list_name_station.append(stop_name);
      position.set(row.getFloat("stop_lon"), row.getFloat("stop_lat"));
      tmp_Stations.add(new station(stop_name, position, row.getInt("stop_id")));
      print ("tmp_Stations.size()=",tmp_Stations.size(),",station : ", tmp_Stations.get(tmp_Stations.size()-1).nom, " : x=", tmp_Stations.get(tmp_Stations.size()-1).position_gps.x, ",y=", tmp_Stations.get(tmp_Stations.size()-1).position_gps.y, "\n");
      tmp_Stations.get(tmp_Stations.size()-1).stop_ids.append(row.getInt("stop_id"));
    }
  }
  return(tmp_Stations);
}

void drawLignes() {
  for (int i=0; i<Ligne.size(); i++) {
    for (int j=0; j<Ligne.get(i).Stations.size(); j++) {
      stroke(ligne_color[i]);
      fill(ligne_color[i], 60);
      float x=Ligne.get(i).Stations.get(j).position_screen.x;
      float y=Ligne.get(i).Stations.get(j).position_screen.y;
      //print ("Ligne color=", ligne_color[i], " station : ", Ligne.get(i).Stations.get(j).nom, " : x=", x, ",y=", y, "\n");
      //print ("Ligne color=", ligne_color[i], " station : ", Ligne.get(i).Stations.get(j).nom, " : x=", Ligne.get(i).Stations.get(j).position_gps.x, ",y=", Ligne.get(i).Stations.get(j).position_gps.y, "\n");
      ellipse(x, y, 10, 10);
    }
  }
}

void find_correspondance() {
  for (int ligne_idx=0; ligne_idx<Ligne.size(); ligne_idx++) {
    for (int station_idx=0; station_idx<Ligne.get(ligne_idx).Stations.size(); station_idx++) {
      for (int ligne_idx2=ligne_idx+1; ligne_idx2<Ligne.size(); ligne_idx2++) {
        for (int station_idx2=0; station_idx2<Ligne.get(ligne_idx2).Stations.size(); station_idx2++) {
          //print(lignes.get(ligne_idx).Stations.get(station_idx).nom," versus ",lignes.get(ligne_idx2).Stations.get(station_idx2).nom,"\n");
          if (Ligne.get(ligne_idx).Stations.get(station_idx).nom.equals(Ligne.get(ligne_idx2).Stations.get(station_idx2).nom)) {
            Ligne.get(ligne_idx).Stations.get(station_idx).correspondances.append(ligne_idx2);
            Ligne.get(ligne_idx2).Stations.get(station_idx2).correspondances.append(ligne_idx);
            //print("Correspondance entre les lignes ", Ligne.get(ligne_idx).numero, " et ", Ligne.get(ligne_idx2).numero, " station ", Ligne.get(ligne_idx).Stations.get(station_idx).nom, "\n");
          }
        }
      }
    }
  }
}

void setScreen_parameters() {
  for (int ligne_idx=0; ligne_idx<Ligne.size(); ligne_idx++) {
    for (int station_idx=0; station_idx<Ligne.get(ligne_idx).Stations.size(); station_idx++) {
      if (ligne_idx==0 && station_idx==0) {
        min_lat=Ligne.get(ligne_idx).Stations.get(station_idx).position_gps.y;
        max_lat=Ligne.get(ligne_idx).Stations.get(station_idx).position_gps.y;
        min_lon=Ligne.get(ligne_idx).Stations.get(station_idx).position_gps.x;
        max_lon=Ligne.get(ligne_idx).Stations.get(station_idx).position_gps.x;
      } else {
        min_lat=min(min_lat, Ligne.get(ligne_idx).Stations.get(station_idx).position_gps.y);
        max_lat=max(max_lat, Ligne.get(ligne_idx).Stations.get(station_idx).position_gps.y);
        min_lon=min(min_lon, Ligne.get(ligne_idx).Stations.get(station_idx).position_gps.x);
        max_lon=max(max_lon, Ligne.get(ligne_idx).Stations.get(station_idx).position_gps.x);
      }
    }
  }
  fact_lon=width/(max_lon-min_lon);
  fact_lat=height/(max_lat-min_lat);
  print ("min_lat=", min_lat, " max_lat=", max_lat, "\n");
  print ("min_lon=", min_lon, " max_lon=", max_lon, "\n");
  print ("fact_lon ", fact_lon, " : fact_lat ", fact_lat, "\n");

  for (int ligne_idx=0; ligne_idx<Ligne.size(); ligne_idx++) {
    for (int station_idx=0; station_idx<Ligne.get(ligne_idx).Stations.size(); station_idx++) {
      Ligne.get(ligne_idx).Stations.get(station_idx).setScreenPosition();
    }
  }
}