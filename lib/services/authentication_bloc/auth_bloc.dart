import 'package:ecommerceapp/services/auth_provider.dart';
import 'package:ecommerceapp/services/authentication_bloc/auth_event.dart';
import 'package:ecommerceapp/services/authentication_bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider)
      : super(const AuthStateUninitialized(isLaoding: true)) {
//registering the user
    on<AuthEventShouldRegister>((event, emit) {
      emit(
        const AuthStateRegistering(
          exception: null,
          isLoading: false,
        ),
      );
    });

//forget password
    on<AuthEventForgetPassword>((event, emit) async {
      emit(
        const AuthStateForgetPassword(
          exception: null,
          hasSendEmail: false,
          isLoading: false,
        ),
      );
      final email = event.email;
      if (email == null) {
        return;
      }
//user send a forget-password-email
      emit(const AuthStateForgetPassword(
        exception: null,
        hasSendEmail: false,
        isLoading: true,
      ));
      bool didSendEmail;
      Exception? exception;
      try {
        await provider.sendPasswordReset(email: email);
        didSendEmail = true;
        exception = null;
      } on Exception catch (e) {
        didSendEmail = false;
        exception = e;
      }
      emit(AuthStateForgetPassword(
        exception: exception,
        hasSendEmail: didSendEmail,
        isLoading: false,
      ));
    });

//sending email verification
    on<AuthEventSendEmailVerification>((event, emit) async {
      await provider.sendEmailVerification();
      emit(state);
    });

// doing registation
    on<AuthEventRegister>(
      (event, emit) async {
        final email = event.email;
        final password = event.password;
        try {
          await provider.createUser(
            email: email,
            password: password,
          );
          await provider.sendEmailVerification();
          emit(
            const AuthStateNeedsVerification(
              isLoading: false,
            ),
          );
        } on Exception catch (e) {
          emit(
            AuthStateRegistering(
              exception: e,
              isLoading: false,
            ),
          );
        }
      },
    );
//initialized
    on<AuthEventInitialize>(
      (event, emit) async {
        await provider.initalize();
        final user = provider.currentuser;
        if (user == null) {
          emit(
            const AuthStateLoggedOut(
              exception: null,
              isLoading: false,
            ),
          );
        } else if (!user.isEmailVerified) {
          emit(
            const AuthStateNeedsVerification(
              isLoading: false,
            ),
          );
        } else {
          emit(
            AuthStateLoggedIn(
              user: user,
              isLoading: false,
            ),
          );
        }

//login action
        on<AuthEventLogIn>(
          (event, emit) async {
            emit(
              const AuthStateLoggedOut(
                exception: null,
                isLoading: true,
              ),
            );
            final email = event.email;
            final password = event.password;
            try {
              final user = await provider.logIn(
                email: email,
                password: password,
              );
              if (!user.isEmailVerified) {
                emit(
                  const AuthStateLoggedOut(
                      exception: null,
                      isLoading: false,
                      loadingText: 'Please wait while I log you in'),
                );
                emit(
                  const AuthStateNeedsVerification(isLoading: false),
                );
              } else {
                emit(
                  const AuthStateLoggedOut(
                    exception: null,
                    isLoading: false,
                  ),
                );
                emit(AuthStateLoggedIn(
                  user: user,
                  isLoading: false,
                ));
              }
            } on Exception catch (e) {
              emit(
                AuthStateLoggedOut(
                  exception: e,
                  isLoading: false,
                ),
              );
            }
          },
        );

//logout
        on<AuthEventLogOut>(
          (event, emit) async {
            try {
              await provider.logOut();
              emit(
                const AuthStateLoggedOut(
                  exception: null,
                  isLoading: false,
                ),
              );
            } on Exception catch (e) {
              emit(
                AuthStateLoggedOut(
                  exception: e,
                  isLoading: false,
                ),
              );
            }
          },
        );
      },
    );
  }
}
