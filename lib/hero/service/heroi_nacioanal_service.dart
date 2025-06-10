import 'package:Kilumbu/data/heroi_nacionai_data.dart';
import 'package:Kilumbu/hero/model/heroi_nacional.dart';

class HeroiNacionalService {

  List<HeroiNacional> getHeroisNacionais() {
    return heroiNacionalAngola.where((heroi) => heroi.reconhecidoOficialmente== false).toList();

  }

  HeroiNacional getHeroiNacionalById(int id) {
    return heroiNacionalAngola.firstWhere((heroi) => heroi.id == id);
  }

  List<HeroiNacional> getHeroisOficiais() {
    return heroiNacionalAngola.where((heroi) => heroi.reconhecidoOficialmente== true).toList();
  }


}