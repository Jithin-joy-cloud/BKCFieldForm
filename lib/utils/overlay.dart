import 'dart:async';

import 'package:bkc_field_form/models/device.dart';
import 'package:bkc_field_form/widgets/circularLoadingWidget.dart';
import 'package:flutter/material.dart';

class ProgressHelper {
  static hideLoader(OverlayEntry loader) {
    Timer(const Duration(milliseconds: 500), () {
      try {
        loader.remove();
      } catch (e) {}
    });
  }

  static OverlayEntry overlayLoader(context) {
    final height = currentDevice.value.height;
    final width = currentDevice.value.width;

    OverlayEntry loader = OverlayEntry(builder: (context) {
      return Positioned(
        height: height,
        width: width,
        child: Material(
          color: Theme.of(context).cardColor.withOpacity(.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                      height: height * .065,
                      width: height * .065,
                      child: CircularProgressIndicator(
                        strokeWidth: height * .006,
                      )),
                  Image.asset(
                    'assets/img/logo_progress.png',
                    height: height * .03,
                    width: height * .035,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
    return loader;
  }
}
