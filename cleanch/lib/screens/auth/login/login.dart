import 'dart:ui';

import 'package:cleanch/screens/home/ScreenHomePage.dart';
import 'package:cleanch/widgets/my_button.dart';
import 'package:cleanch/widgets/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_data_provider.dart';
import '../../home/home.dart';
import '../auth.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _PhoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen({super.key});

  void handleLogin(BuildContext context) async {
    String phone = _PhoneController.text;
    String password = _passwordController.text;

    String loginStatus = await loginOTP(phone, password);

    if (loginStatus == 'Done') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
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
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    UserDataProvider userDataProvider =
        Provider.of<UserDataProvider>(context, listen: true);
    String usename = userDataProvider.username;
    String phone = userDataProvider.phoneNumber;
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/images/road.jpg',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.fill,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  ClipRect(
                    child: BackdropFilter(
                      filter:
                          ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
                      child: Container(
                        padding: const EdgeInsets.symmetric(),
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: Form(
                          key: _formKey,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 0,
                                  ),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Center(
                                          child: Text("Login ",
                                              // ignore: prefer_const_constructors
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize: 25),
                                              textAlign: TextAlign.start),
                                        ),
                                        // const CircleAvatar(
                                        //   radius: 30,
                                        //   backgroundImage: NetworkImage(
                                        //       'https://anmg-production.anmg.xyz/yaza-co-za_sfja9J2vLAtVaGdUPdH5y7gA'),
                                        // ),
                                        SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.02),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          // ignore: prefer_const_literals_to_create_immutables
                                          children: [
                                            Text(usename,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            const SizedBox(height: 5),
                                            Text(phone,
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18)),
                                            const SizedBox(height: 5),
                                            // Text("55443322",
                                            //     style: TextStyle(
                                            //         color: Colors.white,
                                            //         fontSize: 18))
                                          ],
                                        )
                                      ]),
                                ),
                                PhoneTextField(
                                  controller: _PhoneController,
                                  labelText: phone,
                                  hintText: 'Phone Number',
                                  obscureText: false,
                                ),
                                const SizedBox(height: 10),
                                MyPasswordTextField(
                                  controller: _passwordController,
                                  hintText: 'Password',
                                  obscureText: true,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 80),
                                  child: MyButton(
                                    onTap: (() {
                                      handleLogin(context);
                                    }),
                                  ),
                                ),
                                const SizedBox(height: 15),
                                const Text('Forgot Password?',
                                    style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 71, 233, 133),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                    textAlign: TextAlign.start),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
