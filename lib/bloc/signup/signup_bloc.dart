import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:doctor_appointment/bloc/signup/signup_form_status.dart';
import 'package:doctor_appointment/data/models/form/confirm_password.dart';
import 'package:doctor_appointment/data/models/form/email.dart';
import 'package:doctor_appointment/data/models/form/name.dart';
import 'package:doctor_appointment/data/models/form/password.dart';
import 'package:doctor_appointment/data/models/user.dart';
import 'package:doctor_appointment/data/repositories/auth_repository.dart';

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
        print('INSIDE BLOC TRY BLOCK 123');
        User user = await authRepository.signUpWithEmailAndPassword(
            state.name.value, state.email.value, state.password.value);

        print('USER TOKEN: ${user}');
      } catch (e) {
        print('INSIDE BLOC CATCH BLOCK ERROR 2111');

        if (e is DioError) {
          if (e.response!.statusCode == 422) {
            Map<String, dynamic> response = e.response!.data;
            String message = response['message'];

            print('INSIDE BLOC DIO ERROR');

            emit(state.copyWith(
              formStatus: SignupFormFailure(message),
            ));
          } else {
            emit(state.copyWith(
              formStatus:
                  SignupFormFailure('Something went wrong, please try again'),
            ));
          }

          //return Future.error('REPO Sign up failed');
        } else {
          print('INSIDE BLOC ELSE BLOCK ERROR');

          emit(state.copyWith(
            formStatus:
                SignupFormFailure('Something went wrong, please try again'),
          ));
        }

        // emit(state.copyWith(
        //     formStatus:
        //         SignupFormFailure('Something went wrong, please try again 123'),
        //   ));
      }
    });
  }
}
