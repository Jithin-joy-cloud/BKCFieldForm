import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;
  final double height;

  const AnimatedButton(
      {Key? key,
      required this.child,
      required this.onPressed,
      required this.height})
      : super(key: key);

  @override
  AnimatedButtonState createState() => AnimatedButtonState();
}

class AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late Animation<double> _scale;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 50),
    );
    _scale = Tween<double>(begin: 1.0, end: 0.9)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.ease));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (PointerDownEvent event) {
        _controller.forward();
      },
      onPointerUp: (PointerUpEvent event) {
        _controller.reverse();
        widget.onPressed();
      },
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          height: widget.height * .06,
          width: widget.height * .15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.height * .1),
            boxShadow: const [
              BoxShadow(
                color: Color(0x80000000),
                blurRadius: 12.0,
                offset: Offset(0.0, 5.0),
              ),
            ],
            color: Theme.of(context).primaryColor,
          ),
          child: Center(
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
