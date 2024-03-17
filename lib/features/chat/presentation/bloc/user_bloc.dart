import 'package:bloc/bloc.dart';
import 'package:cleanarchitec/core/resources/datastate.dart';
import 'package:cleanarchitec/features/chat/data/model/userModel.dart';
import 'package:cleanarchitec/features/chat/data/repository/user_list_impl.dart';
import 'package:cleanarchitec/features/chat/domain/repository/user_list.dart';
import 'package:cleanarchitec/features/chat/presentation/bloc/user_event.dart';
import 'package:cleanarchitec/features/chat/presentation/bloc/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repo = UserRepositoryImpl();
  UserBloc() : super(UserStateInitial()) {
    on<UserEventDataFetch>(userDataLoaded);
  }

  void userDataLoaded(UserEventDataFetch event, Emitter<UserState> emit) async {
    emit(UserStateLoading());

    DataState<UserModel>? userList = await repo.getUserList();
    if (userList is DataSuccess) {
      emit(UserDataSuccess(userList.data!));
    } else {
      emit(UserDataFailed(userList.error.toString()));
    }
  }
}
