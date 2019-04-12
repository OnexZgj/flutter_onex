import 'package:flutter/material.dart';

class ImageTapWidget extends StatefulWidget {
  final Widget child;
  final Function onTap;

  const ImageTapWidget({Key key, this.child, this.onTap}) : super(key: key);

  @override
  ImageTapWidgetState createState() {
    return new ImageTapWidgetState();
  }
}

class ImageTapWidgetState extends State<ImageTapWidget> {
  var isDown = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        foregroundDecoration: BoxDecoration(
          color: isDown ? Colors.white.withOpacity(0.5) : Colors.transparent,
        ),
        child: widget.child,
      ),
      onTap: widget.onTap,
      onTapDown: (d) => setState(() => this.isDown = true),
      onTapUp: (d) => setState(() => this.isDown = false),
      onTapCancel: () => setState(() => this.isDown = false),
    );
  }
}