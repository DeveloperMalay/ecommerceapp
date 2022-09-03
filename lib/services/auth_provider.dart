import 'package:ecommerceapp/services/auth_user.dart';

abstract class AuthProvider {
  Future<void> initalize();
  AuthUser? get currentuser;
  Future<AuthUser> logIn({
    required String email,
    required String password,
  });
  Future<AuthUser> createUser({
    required String email,
    required String password,
  });
  Future<void> logOut();
  Future<void> sendEmailVerification();
  Future<void> sendPasswordReset({
    required String email,
  });
}
