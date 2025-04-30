import 'package:group_system_app/core/network/dio_client.dart';
import 'package:group_system_app/features/register/data/model/register_model.dart';

class RegisterRepository {
  final _dioClient = DioClient();
  Future<void> register(RegisterModel registerModel) async {
    final response =
        await _dioClient.post("register", data: registerModel.toMap());
    if (response.statusCode == 400) {
      throw Exception("UserAlreadyExists");
    }
  }
}
