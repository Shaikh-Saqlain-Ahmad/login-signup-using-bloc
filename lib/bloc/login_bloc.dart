import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as https;
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<LoginApi>(_loginApi);
  }

  void _onEmailChanged(EmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _loginApi(LoginApi event, Emitter<LoginState> emit) async {
    emit(state.copyWith(loginStatus: LoginStatus.loading));
    Map<String, String> data = {
      'email': state.email,
      'password': state.password
    };
    const String url = "https://reqres.in/api/login";
    try {
      final response = await https.post(Uri.parse(url), body: data);
      if (response.statusCode == 200) {
        emit(state.copyWith(
            message: "Login successful", loginStatus: LoginStatus.success));
      } else {
        emit(state.copyWith(
            message: "Something went wrong!!", loginStatus: LoginStatus.error));
      }
    } catch (e) {
      emit(state.copyWith(
          message: e.toString(), loginStatus: LoginStatus.error));
    }
  }
}
