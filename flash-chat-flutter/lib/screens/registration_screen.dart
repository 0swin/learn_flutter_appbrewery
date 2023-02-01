import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
  static const String id = 'registration_screen';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                onChanged: (String value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your email',
                ),
                style: const TextStyle(
                  color: Colors.black,
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                onChanged: (String value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter your password',
                ),
                style: const TextStyle(
                  color: Colors.black,
                ),
                obscureText: true,
              ),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Register',
                color: Colors.blueAccent,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final dynamic newUser =
                        await _auth.createUserWithEmailAndPassword(
                      email: email,
                      password: password,
                    );
                    if (newUser != null) {
                      await Navigator.pushNamed(context, 'chat_screen');
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
