import 'package:cleanarchitec/core/resources/datastate.dart';
import 'package:cleanarchitec/features/chat/data/model/userModel.dart';

abstract class UserRepository {
  Future<DataState<UserModel>> getUserList();

}
