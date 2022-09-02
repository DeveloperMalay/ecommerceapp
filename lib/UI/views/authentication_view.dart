import 'package:ecommerceapp/UI/views/home_view.dart';
import 'package:ecommerceapp/UI/widgets/sign_in_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthenticationView extends StatefulWidget {
  const AuthenticationView({Key? key}) : super(key: key);

  @override
  State<AuthenticationView> createState() => _AuthenticationViewState();
}

class _AuthenticationViewState extends State<AuthenticationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeView();
          } else {
            return const SignInWidget();
          }
        },
      ),
    );
  }
}
