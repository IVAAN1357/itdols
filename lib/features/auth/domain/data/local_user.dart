import 'package:hive/hive.dart';
import 'package:itdols/features/auth/domain/models/user_model.dart';
import 'package:path_provider/path_provider.dart';

class LocalUser {
  static Future<UserModel?> getUser() async {
    var path = await getApplicationDocumentsDirectory();
    Hive.init(path.path.toString());
    await Hive.openBox('user');
    var box = Hive.box('user');
    var username = box.get('username') ?? '';
    var token = box.get('token') ?? '';
    if (username == '') {
      return null;
    } else {
      return UserModel(username: username, token: token);
    }
  }

  static Future setUser(UserModel? user) async {
    var path = await getApplicationDocumentsDirectory();
    Hive.init(path.path.toString());
    await Hive.openBox('user');
    var box = Hive.box('user');
    if (user == null) {
      box.put('username', '');
      box.put('token', '');
    } else {
      box.put('username', user.username);
      box.put('token', user.token);
    }
  }
}
