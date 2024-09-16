import 'package:bloc/bloc.dart';
import 'package:doctor_appointment/bloc/login/login_form_status.dart';
import 'package:doctor_appointment/data/models/form/email.dart';
import 'package:doctor_appointment/data/models/form/password.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc()
      : super(LoginState(
            email: Email.initial(),
            password: Password.initial(),
            formStatus: const InitialLoginFormStatus())) {
    on<EmailChanged>((event, emit) {
      state.email.value = event.email;
      state.email.validate();
      emit(state.copyWith(email: state.email));
    });

    on<PasswordChanged>((event, emit) {
      state.password.value = event.password;
      state.password.validate();
      emit(state.copyWith(password: state.password));
    });

    on<LoginSubmitted>((event, emit) async {
        emit(state.copyWith(formStatus: const LoginFormSubmitting()));

        state.email.validate();
        state.password.validate();


        if (!state.email.isValid || !state.password.isValid) {
          emit(state.copyWith(
            email: state.email,
            password: state.password,
            formStatus: const LoginFormSubmitted()));
            return;
        }

        emit(state.copyWith(
            email: state.email,
            password: state.password,
            formStatus: const LoginFormSubmitted()));
      
        // await Future.delayed(const Duration(seconds: 1));


      // emit(state.copyWith(
      // email: state.email, password: state.password, formStatus: const LoginFormSuccess()));
    });
  }
}