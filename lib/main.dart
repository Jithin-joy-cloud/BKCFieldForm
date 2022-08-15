import 'package:bkc_field_form/main.dart';
import 'package:bkc_field_form/models/device.dart';
import 'package:bkc_field_form/utils/helper.dart';
import 'package:bkc_field_form/utils/route_generator.dart';
import 'package:bkc_field_form/utils/style.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'db/formObjectBox.dart';
import 'utils/sharedPreference.dart' as pref;
import 'package:flutter_native_splash/flutter_native_splash.dart';

late FormObjectBox objectBox;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    FlutterNativeSplash.removeAfter(initialization);
    initializeObjectBox();

    runApp(const MyApp());
  });
}

void initialization() async {
  await Future.delayed(const Duration(seconds: 1)).then((value) {});

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: Style.themeData(false, context),
      onGenerateRoute: RouteGenerator.generateRoute,
      home: const SplashScreen(),
    );
  }
}

Future<void> initializeObjectBox() async {
  objectBox = await FormObjectBox.init();
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    pref.getCurrentUser().then((value) {
      currentDevice.value.height = Helper.getHeight(context);
      currentDevice.value.width = Helper.getWidth(context);
      if (value.id != "") {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
      } else {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}
