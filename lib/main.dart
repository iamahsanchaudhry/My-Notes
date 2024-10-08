
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';
import 'package:mynotes/views/login_view.dart';
import 'package:mynotes/views/register_view.dart';
import 'package:mynotes/views/verifyEmail_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  runApp(MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: false,
      ),
      home:  const HomePage(),
      routes: {
        '/login/' : (context) => const LoginView(),
        '/register/': (context) => const RegisterView()
      },
    ),);
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context,snapshot){
          switch (snapshot.connectionState){
            case ConnectionState.done:
            //return const LoginView();
               final user = FirebaseAuth.instance.currentUser;
                if(user != null){
                  if(user.emailVerified){
                    print('Email is verified');
                  }
                  else{
                    return const VerifyEmailView();
                  }
                }else {
                  return const LoginView();
                }
                return const Text('Done');
          default:
            return const Center(child: CircularProgressIndicator()); // Fallback
          }
          },);
  }
} 
