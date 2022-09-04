import 'package:ecommerceapp/dialogs/error_diolog.dart';
import 'package:ecommerceapp/services/authentication_bloc/auth_bloc.dart';
import 'package:ecommerceapp/services/authentication_bloc/auth_event.dart';
import 'package:ecommerceapp/services/authentication_bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateForgetPassword) {
          if (state.hasSendEmail) {
            _emailController.clear();
            await showErrorDialog(
              context,
              'We send you a password reset link to your email',
            );
          }
          if (state.exception != null) {
            // ignore: use_build_context_synchronously
            await showErrorDialog(
              context,
              'We could not process your request.Please make sure that you are a register user or if not reggister a user by gi back one step',
            );
          }
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  label: Text('Enter your email'),
                ),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () {
                  final email = _emailController.text.trim();
                  context.read<AuthBloc>().add(
                        AuthEventForgetPassword(email: email),
                      );
                  // FirebaseAuth.instance.sendPasswordResetEmail(
                  //   email: _emailController.text.trim(),
                  // );
                },
                icon: const Icon(Icons.email),
                label: const Text(
                  'Send me a password reset link',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(const AuthEventLogOut());
                },
                child: const Text('Back to login page '),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
