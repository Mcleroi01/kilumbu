import 'package:Kilumbu/data/president_data.dart';
import 'package:Kilumbu/president/model/president.dart';

class PresidentService {
  List<President> getAllPresident(){
    return presidentAngolaises;
  }

  President getProvinceById(int id){
    try {
      return presidentAngolaises.firstWhere(
            (province) => province.id == id,
      );
    } catch (e) {
      throw PresidentNotFoundException('Province avec id $id non trouvé');
    }
  }
}


class PresidentNotFoundException implements Exception {
  final String message;

  PresidentNotFoundException(this.message);

  @override
  String toString() => 'PresidentNotFoundException: $message';
}