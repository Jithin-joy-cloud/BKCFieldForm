import 'dart:io';

import 'package:bkc_field_form/models/completeForm.dart';
import 'package:bkc_field_form/screens/formDetails.dart';
import 'package:bkc_field_form/screens/forms/editForms.dart';
import 'package:bkc_field_form/screens/forms/result.dart';
import 'package:bkc_field_form/screens/home.dart';
import 'package:bkc_field_form/screens/localForms.dart';
import 'package:bkc_field_form/screens/pdfViewer.dart';
import 'package:bkc_field_form/screens/profile.dart';
import 'package:bkc_field_form/screens/register.dart';
import 'package:bkc_field_form/screens/serverForms.dart';
import 'package:flutter/material.dart';

import '../controllers/form_controller.dart';
import '../screens/documents.dart';
import '../screens/home.dart';
import '../screens/login.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final arguments;
    switch (settings.name) {
      case '/result':
        arguments = settings.arguments as FormController;
        break;
      case '/formDetail':
        arguments = settings.arguments as CompleteForm;
        break;
      case '/pdfViewer':
        arguments = settings.arguments as File;
        break;
      case '/editForm':
        arguments = settings.arguments as CompleteForm;
        break;
      case '/home':
        arguments = settings.arguments == null
            ? null
            : settings.arguments as FormController;
        break;
      default:
        arguments = settings.arguments;
    }
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (BuildContext context) => const Login());
      case '/register':
        return MaterialPageRoute(builder: (_) => const Register());
      case '/login':
        return MaterialPageRoute(builder: (_) => const Login());
      case '/home':
        return MaterialPageRoute(builder: (_) => HomeScreen(arguments));
      case '/documents':
        return MaterialPageRoute(builder: (_) => const DocumentScreen());
      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case '/localForm':
        return MaterialPageRoute(builder: (_) => const LocalFormScreen());
      case '/serverForm':
        return MaterialPageRoute(builder: (_) => const ServerScreen());
      case '/result':
        return MaterialPageRoute(
            builder: (_) => ResultScreen(formController: arguments));
      case '/formDetail':
        return MaterialPageRoute(
            builder: (_) => FormDetail(form: arguments));
      case '/editForm':
        return MaterialPageRoute(
            builder: (_) => EditFormScreen(completeForm: arguments));
      case '/pdfViewer':
        return MaterialPageRoute(builder: (_) => PDFViewer(file: arguments));
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (BuildContext context) {
      return const Scaffold(body: Center(child: Text("Error")));
    });
  }
}
