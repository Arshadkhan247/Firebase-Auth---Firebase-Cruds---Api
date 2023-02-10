import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/dash_board.dart';
import 'package:social_app/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  void login() {
    _auth
        .signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text)
        .then((value) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const DashBoardScreen()));
    }).onError((error, stackTrace) {
      'Invalid error$error';
      'Invalid Operation$stackTrace';
    });
  }

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
              height: 130,
              color: Colors.teal,
              image: AssetImage(
                'assets/login.png',
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Form(
              key: _formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Your Email';
                      }
                      return null;
                    },
                    controller: _emailController,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email), hintText: 'Email'),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Your Password';
                      }
                      return null;
                    },
                    controller: _passwordController,
                    obscureText: false,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.lock), hintText: 'Password'),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    // function for user sign in...
                    login();
                  }
                },
                child: const Text('Login')),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Don\'t have an account?'),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const SignUpScreen()));
                    },
                    child: const Text('Sign Up')),
              ],
            )
          ],
        ),
      ),
    );
  }
}
