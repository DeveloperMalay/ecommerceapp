import 'package:ecommerceapp/UI/widgets/error_snackbar.dart';
import 'package:ecommerceapp/UI/widgets/sign_in_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({Key? key}) : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
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

//function to create a user
  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    // showDialog(
    //   context: context,
    //   builder: (context) => const Center(
    //     child: CircularProgressIndicator(),
    //   ),
    // );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      snackBar.showSnackBar(e.message);
    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 70,
              ),
              const Text(
                'Create a Account',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 50,
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
                validator: (password) => password != null && password.length < 6
                    ? 'password must be more than 6 characters'
                    : null,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: () {
                  signUp();
                },
                icon: const Icon(Icons.arrow_forward),
                label: const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 24),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const SignInWidget();
                  }));
                },
                child: Row(
                  children: const [
                    Text(
                      "Already have a account?",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Sign In',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
