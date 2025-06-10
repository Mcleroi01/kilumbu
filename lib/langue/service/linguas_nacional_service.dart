import 'package:Kilumbu/data/languas_nacioanl_data.dart';
import 'package:Kilumbu/langue/model/linguas_nacional.dart';

class LinguaNacionalService {

  List<LinguaNacional> getLinguasOficiais() {
    return linguanacional;
  }

  LinguaNacional getLinguaNacionalById(int id) {
    return linguanacional.firstWhere((lingua) => lingua.id == id);
  }




}
