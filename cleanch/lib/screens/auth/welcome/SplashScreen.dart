import 'package:flutter/material.dart';

import 'welcome.dart';

import 'package:flutter/material.dart';
import '../../../widgets/my_button.dart';
import '../../../widgets/my_textfield.dart';
import '../../../widgets/square_tile.dart';
import '../signup/signup.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final double _sigmaX = 5; // from 0-10
  double _sigmaY = 5; // from 0-10
  double _opacity = 0.2;
  double _width = 350;
  double _height = 300;
  final _formKey = GlobalKey<FormState>();

  // sign user in method
  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: MyButtonAgree(
        onTap: (() {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => WelcomePage()),
          );
        }),
        text: 'Next',
      ),
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/images/Weil.jpg',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.fill,
                color: Color.fromARGB(131, 32, 118, 189),
                colorBlendMode: BlendMode.srcOver,
              ),
              PositionedDirectional(
                top: 50,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.asset(
                        'assets/images/logo.jpg',
                        width: 70,
                        height: 70,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Row(
                      children: [
                        const Text(
                          'Clean',
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontWeight: FontWeight.w800,
                            fontSize: 25,
                            fontFamily: 'Open Sans',
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(
                          width: 2,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 6),
                          child: const Text(
                            'Ch',
                            style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.w900,
                              fontSize: 15,
                              fontFamily: 'sans-serif',
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Positioned(
                top: 200,
                left: 20,
                right: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("For a Safe Road",
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontWeight: FontWeight.w300,
                          fontSize: 35,
                          fontFamily: 'Open Sans',
                          fontStyle: FontStyle.italic,
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
