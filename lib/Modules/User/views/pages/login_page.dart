import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_me/Modules/Beneficiary/repository/beneficiary_repository.dart';
import 'package:pay_me/Modules/Home/bloc/cubit/home_cubit.dart';
import 'package:pay_me/Modules/Home/views/screens/home_page.dart';
import 'package:pay_me/Modules/Home/views/widgets/benefeciary_card.dart';
import 'package:pay_me/Modules/User/repository/user_repository.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body:

            //  Container(
            //     decoration: const BoxDecoration(
            //       borderRadius: BorderRadius.all(Radius.circular(20)),
            //       color: Colors.white,
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.black26,
            //       blurRadius: 8.0,
            //       offset: Offset(0, 4),
            //     ),
            //   ],
            // ),
            // padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            // height: MediaQuery.of(context).size.height * 0.4,
            // width: MediaQuery.of(context).size.width,
            // child:
            SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0, bottom: 50),
                    child: Image.asset(
                      'assets/1024.png',
                      height: 150,
                      width: 150,
                    ),
                  ),
                  const Text(
                    'Welcome to Payflex',
                    style: TextStyle(
                        color: Color(0xff3A7BD5),
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Name',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 50.0),
                        Center(
                            child: SubmitButton(
                          text: 'Login',
                          height: 40,
                          width: 100,
                          fontsize: 16,
                          onTap: () async {
                            try {
                              var credentials = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: _emailController.text,
                                      password: _passwordController.text);
                              _emailController.text = "";
                              _passwordController.text = "";
                              Navigator.push(
                                // ignore: use_build_context_synchronously
                                context,
                                PageRouteBuilder(
                                  pageBuilder: (c, a1, a2) => BlocProvider(
                                      create: (context) => HomeCubit(
                                          const UserRepository(),
                                          BeneficiaryRepository(),
                                          credentials.user!.uid),
                                      child: const HomePage()),
                                  transitionsBuilder: (c, anim, a2, child) =>
                                      FadeTransition(
                                          opacity: anim, child: child),
                                  transitionDuration:
                                      const Duration(milliseconds: 800),
                                ),
                              );
                            } on FirebaseAuthException catch (e) {
                              String errorMessage = 'An error occurred';
                              if (e.code == 'user-not-found') {
                                errorMessage = e.message ??
                                    'No user found for that email.';
                              } else if (e.code == 'wrong-password') {
                                errorMessage = e.message ??
                                    'Wrong password provided for that user.';
                              } else if (e.code == 'invalid-credential') {
                                errorMessage =
                                    e.message ?? 'Invalid credentials';
                              }
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(errorMessage),
                                ),
                              );
                            } catch (e) {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(e.toString()),
                                ),
                              );
                            }
                          },
                        )),
                      ],
                    ),
                  )
                ]),
          ),
        )
        //)
        );
  }
}
