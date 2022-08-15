import 'package:bkc_field_form/controllers/user_controller.dart';
import 'package:bkc_field_form/models/device.dart';
import 'package:bkc_field_form/widgets/textFormCustom.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../widgets/animatedButton.dart';
import '../utils/style.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  MyLoginScreenState createState() => MyLoginScreenState();
}

class MyLoginScreenState extends StateMVC<Login> {
  late UserController userController;
  final size = currentDevice.value.height;

  MyLoginScreenState() : super(UserController()) {
    userController = controller as UserController;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Style.themeData(false, context),
      scaffoldMessengerKey: userController.scaffoldMessengerKey,
      home: Scaffold(
          key: userController.scaffoldKey,
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Stack(
              children: [
                Positioned(
                  bottom: -size * .01,
                  left: -size * .025,
                  child: Image.asset(
                    'assets/img/auth_bg_3.png',
                    width: size * .35,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Image.asset(
                    'assets/img/auth_bg_2.png',
                  ),
                ),
                Positioned(
                  top: 0,
                  right: -size * .075,
                  child: Image.asset(
                    'assets/img/auth_bg_1.png',
                    height: size * .2,
                    width: size * .35,
                  ),
                ),
                Positioned(
                  bottom: size * .006,
                  left: 5,
                  child: Image.asset(
                    'assets/img/logo.png',
                    height: size * .06,
                    width: size * .1,
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  top: 0,
                  child: Form(
                      key: userController.userFormKey,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: size * .025),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Sign In",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                            SizedBox(
                              height: size * .03,
                            ),
                            TextFormCustom(
                              hint: "Email",
                              inputType: TextInputType.emailAddress,
                              userController: userController,
                              isPassword: false,
                              height: size,
                            ),
                            SizedBox(
                              height: size * .03,
                            ),
                            TextFormCustom(
                              hint: "Password",
                              inputType: TextInputType.visiblePassword,
                              userController: userController,
                              isPassword: true,
                              height: size,
                            ),
                            SizedBox(
                              height: size * .03,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: AnimatedButton(
                                  onPressed: () {
                                    userController.login(context);
                                  },
                                  height: size,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: size * .02,
                                        vertical: size * .01),
                                    child: Text(
                                      "Sign In",
                                      style: TextStyle(
                                          color: Theme.of(context).cardColor),
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: size * .02,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't have an account?",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                                SizedBox(
                                  width: size * .009,
                                ),
                                MaterialButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil('/register',
                                            (Route<dynamic> route) => false);
                                  },
                                  child: Text(
                                    "Register now",
                                    style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )),
                ), /*Positioned(
                  bottom: height * .15,
                  left: 0,
                  right: 0,
                  child:
                ),*/
              ],
            ),
          )),
    );
  }
}
