// ignore_for_file: use_build_context_synchronously
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import "views/login_view2.dart";
import 'views/register_view.dart';
import 'views/verify_email_view.dart';
import 'views/notes-view.dart';
import 'data/user_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserData.init();
  runApp(
    MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
        routes: {
          './login/': (context) => const LoginView(),
          './register/': (context) => const RegisterView(),
          './verify-email/': (context) => const VerifyEmailView(),
          './notes-view/': (context) => const NotesView(),
        }),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              if (user.emailVerified) {
                print('Email is verified!');
                return const NotesView();
              } else {
                return const LoginView();
              }
            }
            return const LoginView();
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
