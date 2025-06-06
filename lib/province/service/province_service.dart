import '../model/province.dart';
import '../../data/provinces_data.dart';

class ProvinceNotFoundException implements Exception {
  final String message;

  ProvinceNotFoundException(this.message);

  @override
  String toString() => 'ProvinceNotFoundException: $message';
}

class ProvinceService {
  List<Province> getAllProvinces() {
    return provincesAngolaises;
  }

  Province getProvinceById(int id) {
    // Note: Return type changed to non-nullable Province
    try {
      return provincesAngolaises.firstWhere(
            (province) => province.id == id,
      );
    } catch (e) {
      throw ProvinceNotFoundException('Province avec id $id non trouvé');
    }
  }
}