import 'package:glutton/glutton.dart';
import 'package:injectable/injectable.dart';

@injectable
class DataCacheManager {
  Future<bool> saveData(String key, dynamic data) async {
    return Glutton.eat(key, data);
  }

  Future<dynamic> retrieveData(String key) async {
    return Glutton.vomit(key);
  }

  Future<bool> doesDataExist(String key) async {
    return Glutton.have(key);
  }

  Future<bool> removeData(String key) async {
    return Glutton.digest(key);
  }

  Future<bool> flushData() async {
    return Glutton.flush();
  }
}
