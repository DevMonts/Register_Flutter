import 'package:group_system_app/core/network/dio_client.dart';
import 'package:group_system_app/features/login/data/model/login_model.dart';

class LoginRepository {
  final _dioClient = DioClient();
  Future<LoginModel> login(
      {required String email, required String password}) async {
    final response = await _dioClient.post("login", data: {
      "email": email,
      "password": password,
    });
    // print(response.data);
    if (response.statusCode == 200) {
      return LoginModel.fromMap(response.data["data"]);
    } else {
      print("Erro ao fazer login: ${response.statusCode}");
      print("Erro ao fazer login: ${response.data}");
      throw Exception("Erro ao fazer login!");
    }
  }
}
