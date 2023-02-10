import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_app/dash_board.dart';
import 'package:social_app/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text('Sign Up '),
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
                        controller: emailController,
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
                        controller: passwordController,
                        obscureText: false,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.lock), hintText: 'Password'),
                      ),
                    ],
                  )),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      auth
                          .createUserWithEmailAndPassword(
                              email: emailController.text.toString(),
                              password: passwordController.text.toString())
                          .then((signinuser) {
                        firestore.collection('User').add({
                          'email': emailController,
                          'password': passwordController,
                        }).then((value) {
                          return Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const DashBoardScreen()));
                        });
                      }).onError((error, stackTrace) {
                        return;
                      });
                    }
                  },
                  child: const Text('Sign Up')),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an Account'),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                      },
                      child: const Text('Login')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}


// only for practise...

                    // await showModalBottomSheet(
                    //     backgroundColor: Colors.grey,
                    //     elevation: 10,
                    //     barrierColor: Colors.transparent,
                    //     useRootNavigator: true,
                    //     context: context,
                    //     builder: (context) {
                    //       return Padding(
                    //         padding: const EdgeInsets.all(20),
                    //         child: Column(
                    //           children: const [],
                    //         ),
                    //       );
                    //     });