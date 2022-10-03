import 'package:shared_preferences/shared_preferences.dart';

setJwt(String jwtString) async {
  try {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt', jwtString);
  } catch (e) {
    print(e);
  }
}

getJWt() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final jwt = prefs.getString('jwt');
    return jwt;
  } catch (e) {
    print(e);
  }
}
