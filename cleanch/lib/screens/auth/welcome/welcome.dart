import 'package:cleanch/providers/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../widgets/my_button.dart';
import '../../../widgets/my_textfield.dart';
import '../../../widgets/square_tile.dart';
import '../auth.dart';
import '../login/login.dart';
import '../signup/signup.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({super.key});

  // text editing controllers
  final phoneController = TextEditingController();

  double _sigmaX = 5; // from 0-10
  double _sigmaY = 5; // from 0-10
  double _opacity = 0.2;
  double _width = 350;
  double _height = 300;
  final _formKey = GlobalKey<FormState>();

  Future<void> handlePhone(BuildContext context) async {
    String phone = phoneController.text;

    String phoneStatus = await phoneNumberHandler(phone);

    print(phoneStatus);

    if (phoneStatus == 'Done') {
      UserDataProvider userDataProvider =
          // ignore: use_build_context_synchronously
          Provider.of<UserDataProvider>(context, listen: false);
      userDataProvider.setPhoneNumber(phone);

      if (phoneStatus == 'Done') {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
    } else {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Signup()),
      );
    }
  }

  // sign user in method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/images/road.jpg',
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.fill,
                color: Color.fromARGB(164, 32, 118, 189),
                colorBlendMode: BlendMode.srcOver,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network('https://cleanch.ch/img/logoN.png'),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.10),
                  Form(
                    key: _formKey,
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // username textfield
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 90,
                            ),
                            child: PhoneTextField(
                              controller: phoneController,
                              hintText: 'Phone Number',
                              obscureText: false,
                            ),
                          ),

                          const SizedBox(height: 60),

                          // sign in button
                          MyButton(
                            onTap: (() {
                              if (_formKey.currentState!.validate() &&
                                  phoneController.text.isNotEmpty &&
                                  phoneController.text.length == 8) {
                                handlePhone(context);
                              } else {
                                print('not valid');
                              }
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
