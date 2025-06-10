import 'package:Kilumbu/data/parc_naturel_data.dart';
import 'package:Kilumbu/parque_naturel/model/parcnaturel.dart';

class ParcNaturelService{
 List<ParcNaturel> getParcsNaturels(){
    return parcsNaturelsAngola;
  }

  ParcNaturel getParcNaturelById(int id){
    return parcsNaturelsAngola.firstWhere((parc) => parc.id == id);
  }



}