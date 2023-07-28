import 'dart:ui';
import 'package:cleanch/widgets/my_button.dart';
import 'package:cleanch/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/user_data_provider.dart';
import '../auth.dart';
import '../login/login.dart';

class Signup extends StatelessWidget {
  // text editing controllers
  final firstnaleController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> handleSignUp(BuildContext context) async {
    String firstName = firstnaleController.text;

    String phone = phoneController.text;

    String email = emailController.text;

    String password = passwordController.text;

    String signUpStatus = await signUp(firstName, password, phone, email);

    if (signUpStatus == 'Done') {
      UserDataProvider userDataProvider =
          Provider.of<UserDataProvider>(context, listen: false);
      userDataProvider.setFirstName(firstName);
      userDataProvider.setPhoneNumber(phone);
      userDataProvider.setEmail(email);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    } else {
      print('Login failed');
    }
  }

  final double _sigmaX = 5; // from 0-10
  final double _sigmaY = 5; // from 0-10
  final double _opacity = 0.2;
  final double _width = 350;
  final double _height = 300;
  final _formKey = GlobalKey<FormState>();

  // sign user in method
  void signUserIn() {
    if (_formKey.currentState!.validate()) {
      print('valid');
    } else {
      print('not valid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   elevation: 0,
        //   leading: IconButton(
        //     icon: const Icon(Icons.arrow_back_ios),
        //     color: Colors.white,
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //   ),
        // ),
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/images/road.jpg',
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      fit: BoxFit.fill,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 70,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.05),
                          ClipRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                  sigmaX: _sigmaX, sigmaY: _sigmaY),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 17, vertical: 0),
                                decoration: BoxDecoration(
                                    color: const Color.fromRGBO(0, 0, 0, 1)
                                        .withOpacity(_opacity),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(25))),
                                width: MediaQuery.of(context).size.width * 0.9,
                                height:
                                    MediaQuery.of(context).size.height * 0.86,
                                child: Form(
                                  key: _formKey,
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              const Center(
                                                child: Text("SignUp ",
                                                    // ignore: prefer_const_constructors
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20),
                                                    textAlign: TextAlign.start),
                                              ),
                                              const SizedBox(height: 10),
                                              const Text(
                                                  "Look like you don't have an account. Let's create ",
                                                  // ignore: prefer_const_constructors
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                  textAlign: TextAlign.start),
                                              // ignore: prefer_const_constructors

                                              const SizedBox(height: 15),

                                              NameTextField(
                                                controller: firstnaleController,
                                                hintText: 'First Name',
                                                obscureText: false,
                                              ),

                                              const SizedBox(height: 10),
                                              EmailTextField(
                                                controller: emailController,
                                                hintText: 'Email',
                                                obscureText: false,
                                              ),

                                              const SizedBox(height: 10),

                                              PhoneTextField(
                                                controller: phoneController,
                                                hintText: 'Phone Number',
                                                obscureText: false,
                                              ),

                                              const SizedBox(height: 10),
                                              MyPasswordTextField(
                                                controller: passwordController,
                                                hintText: 'Password',
                                                obscureText: true,
                                              ),

                                              const SizedBox(height: 30),

                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                children: [
                                                  RichText(
                                                    text: const TextSpan(
                                                      text: '',
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                          text:
                                                              'By selecting Agree & Continue below, I agree to our ',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20),
                                                        ),
                                                        TextSpan(
                                                            text:
                                                                'Terms of Service and Privacy Policy',
                                                            style: TextStyle(
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        71,
                                                                        233,
                                                                        133),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 20)),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 16,
                                                        horizontal: 80),
                                                    child: MyButton(
                                                      onTap: (() {
                                                        handleSignUp(context);
                                                      }),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ],
                ))));
  }
}
