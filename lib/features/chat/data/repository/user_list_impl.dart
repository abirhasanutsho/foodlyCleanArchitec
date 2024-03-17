import 'package:cleanarchitec/core/resources/datastate.dart';
import 'package:cleanarchitec/features/chat/data/datasources/userListApi.dart';
import 'package:cleanarchitec/features/chat/data/model/userModel.dart';
import 'package:cleanarchitec/features/chat/domain/repository/user_list.dart';

class UserRepositoryImpl extends UserRepository {
  @override
  Future<DataState<UserModel>> getUserList() async {
    try {
      UserModel? userModel = await UserListApi.getUserList();
      return DataSuccess(userModel!);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
