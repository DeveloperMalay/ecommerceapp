import 'package:ecommerceapp/UI/widgets/error_snackbar.dart';
import 'package:ecommerceapp/dialogs/error_diolog.dart';
import 'package:ecommerceapp/services/auth_exception.dart';
import 'package:ecommerceapp/services/authentication_bloc/auth_bloc.dart';
import 'package:ecommerceapp/services/authentication_bloc/auth_event.dart';
import 'package:ecommerceapp/services/authentication_bloc/auth_state.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  ErrorSnackBar snackBar = ErrorSnackBar();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  //function to make the user login
  Future signIn() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    context.read<AuthBloc>().add(
          AuthEventLogIn(
            email,
            password,
          ),
        );

    // showDialog(
    //   context: context,
    //   barrierDismissible: false,
    //   builder: (context) => const Center(
    //     child: CircularProgressIndicator(),
    //   ),
    // );
    // try {
    //   await FirebaseAuth.instance.signInWithEmailAndPassword(
    //       email: emailController.text.trim(),
    //       password: passwordController.text.trim());
    // } on FirebaseAuthException catch (e) {
    //   snackBar.showSnackBar(e.message);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          if (state.exception is UserNotFoundAuthException) {
            await showErrorDialog(
              context,
              'Cannot find a user wh=ith the entered credential',
            );
          } else if (state.exception is WrongPasswordAuthException) {
            await showErrorDialog(context, 'Wrong credential');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, 'Authentication Error');
          }
        }
      },
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Hey There,\nWelcome Back',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                          ? 'Enter a valid email'
                          : null,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value != null && value.length < 6
                      ? 'password must be more than 6 characters'
                      : null,
                ),
                const SizedBox(
                  height: 5,
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'forgot password ?',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 10,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () {
                    signIn();
                  },
                  icon: const Icon(Icons.lock_open),
                  label: const Text(
                    'Sign In',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          const AuthEventShouldRegister(),
                        );

                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) {
                    //   return const SignUpView();
                    // }));
                  },
                  child: const Text(
                    "Don't have a account? Sign Up",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
