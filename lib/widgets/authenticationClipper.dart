import 'package:flutter/cupertino.dart';

class CustomPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double path1Xs = size.width / 428;
    double path1Ys = size.height / 926;

    Path path_1 = Path()
      ..moveTo(0 * path1Xs, 0 * path1Ys)
      ..lineTo(428 * path1Xs, 0 * path1Ys)
      ..lineTo(428 * path1Xs, 378 * path1Ys)
      ..cubicTo(428 * path1Xs, 378 * path1Ys, 202.25 * path1Xs,
          243.95 * path1Ys, 95.25 * path1Xs, 243.95 * path1Ys)
      ..cubicTo(54.81 * path1Xs, 243.95 * path1Ys, 31.33 * path1Xs,
          263.11 * path1Ys, 17.7 * path1Xs, 287.05 * path1Ys)
      ..cubicTo(-4.54 * path1Xs, 326.14 * path1Ys, 0 * path1Xs,
          378 * path1Ys, 0 * path1Xs, 378 * path1Ys)
      ..lineTo(0 * path1Xs, 370.56 * path1Ys)
      ..lineTo(0 * path1Xs, 0 * path1Ys)
      ..close();
    path_1 = path_1.shift(Offset(-0.38 * path1Xs, 0 * path1Ys));

    return path_1;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
