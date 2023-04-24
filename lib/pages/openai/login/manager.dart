import 'dart:convert';

import 'package:get/get.dart';
import 'package:luca_flutter_common/luca_storage.dart';

class UserOpenAiUtils {
  UserOpenAiUtils._privateConstructor();
  static final UserOpenAiUtils _instance =
      UserOpenAiUtils._privateConstructor();
  static UserOpenAiUtils get instance {
    return _instance;
  }

  var isLoginObs = false.obs;
  UserModel? user;

  final String _key = "open_ai_user_key";

  Future<void> setup() async {
    String? value = await LucaStorage.instance.getString(_key);
    if (value != null) {
      Map map = json.decode(value);
      user = UserModel(
        token: map["token"],
        proxy: map["proxy"],
      );
      isLoginObs.value = true;
    }
  }

  bool get isLogin {
    return user != null;
  }

  Future<void> login(UserModel userModel) async {
    user = userModel;
    Map map = {
      "token": user?.token,
      "proxy": user?.proxy,
    };
    String value = json.encode(map);
    await LucaStorage.instance.setString(_key, value);
    isLoginObs.value = true;
  }

  Future<void> logout() async {
    user = null;
    await LucaStorage.instance.remove(_key);
    isLoginObs.value = false;
  }
}

class UserModel {
  String? token;
  String? proxy;

  UserModel({
    this.token,
    this.proxy,
  });
}
