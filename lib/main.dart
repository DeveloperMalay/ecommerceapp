import 'package:ecommerceapp/UI/theme/theme.dart';
import 'package:ecommerceapp/UI/views/authentication_view.dart';
import 'package:ecommerceapp/UI/widgets/error_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  ErrorSnackBar messengerkey = ErrorSnackBar();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      scaffoldMessengerKey: messengerkey.messengerKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme,
      home: const AuthenticationView(),
    );
  }
}
