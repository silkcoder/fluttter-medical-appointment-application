import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:doctor_appointment/bloc/signup/signup_form_status.dart';
import 'package:doctor_appointment/data/models/form/confirm_password.dart';
import 'package:doctor_appointment/data/models/form/email.dart';
import 'package:doctor_appointment/data/models/form/name.dart';
import 'package:doctor_appointment/data/models/form/password.dart';
import 'package:doctor_appointment/data/models/user.dart';
import 'package:doctor_appointment/data/repositories/auth_repository.dart';
import 'package:doctor_appointment/network/dio_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  AuthRepository authRepository;
  SignupBloc({required this.authRepository})
      : super((SignupState(
            name: Name.initial(),
            email: Email.initial(),
            password: Password.initial(),
            confirmPassword: ConfirmPassword.initial(),
            formStatus: const SignupFormInitial()))) {
    on<NameChanged>((event, emit) {
      state.name.value = event.name;
      state.name.validate();
      emit(state.copyWith(name: state.name));
    });

    on<EmailChanged>((event, emit) {
      state.email.value = event.email;
      state.email.validate();
      emit(state.copyWith(email: state.email));
    });

    on<PasswordChanged>((event, emit) {
      state.password.value = event.password;
      state.password.validate(confirmPassword: state.confirmPassword);
      emit(state.copyWith(password: state.password));
    });

    on<ConfirmPasswordChanged>((event, emit) {
      state.confirmPassword.value = event.confirmPassword;
      state.confirmPassword.validate(state.password.value);
      emit(state.copyWith(confirmPassword: state.confirmPassword));
    });

    on<SignupSubmitted>((event, emit) async {
      emit(state.copyWith(formStatus: const SignupFormSubmitting()));

      await Future.delayed(const Duration(seconds: 1));

      state.email.validate();
      state.password.validate();
      state.name.validate();
      state.confirmPassword.validate(state.password.value);

      if (!state.email.isValid ||
          !state.password.isValid ||
          !state.name.isValid ||
          !state.confirmPassword.isValid) {
        emit(
          state.copyWith(
              email: state.email,
              password: state.password,
              name: state.name,
              formStatus: const SignupFormSubmitted()),
        );
        return;
      }

      try {
        User user = await authRepository.signUpWithEmailAndPassword(state.name.value, state.email.value, state.password.value);
        String token = user.token;

        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);

        emit(state.copyWith(formStatus: const SignupFormSuccess()));        
      } on DioError catch (e) {
        String errorMessage = DioException.fromDioError(e).errorMessage;
        emit(state.copyWith(
          formStatus: SignupFormFailure(errorMessage),
        ));
      } catch (e) {

        print(e);

        emit(state.copyWith(
          formStatus: const SignupFormFailure('Something went wrong'),
        ));
      }
    });
  }
}
