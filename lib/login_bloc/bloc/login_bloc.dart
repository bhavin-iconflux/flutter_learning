import 'package:bloc/bloc.dart';
import 'package:flutter_learning/network/model/response.dart';
import 'package:flutter_learning/login_bloc/bloc/login_event.dart';
import 'package:flutter_learning/login_bloc/bloc/login_state.dart';

import '../../network/resources/repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(Repository _repository) : super(LoginInitial());

  final _repository = Repository();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is DoLoginWithUserNameAndPassword) {
      yield* mapLoginStateWithEvent(event);
    }
  }

  Stream<LoginState> mapLoginStateWithEvent(
      DoLoginWithUserNameAndPassword event) async* {
    yield LoginLoading();

    Response? response =
        await _repository.loginApiProvider.doLogin(event.username, event.password);

    if (response?.success == true) {
      yield LoginSuccess(response);
    } else {
      if (response?.networkError?.isNotEmpty == true) {
        yield LoginFailure(networkError: response?.networkError);
      } else {
        yield LoginFailure(error: response);
      }
    }
  }
}
