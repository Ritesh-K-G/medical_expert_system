import 'package:flutter/material.dart';
import 'package:medical_expert_system/constants.dart';

class Shimmer extends StatefulWidget {
  final double height;
  final double width;

  Shimmer({Key? key, this.height = 20, this.width = 200}) : super(key: key);

  @override
  ShimmerState createState() => ShimmerState();
}

class ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation gradientPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(milliseconds: 1500), vsync: this);

    gradientPosition = Tween<double>(
      begin: -3,
      end: 10,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    )..addListener(() {
      if (mounted && _controller.isAnimating) {
        setState(() {});
      }
    });

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(gradientPosition.value, 0),
          end: Alignment(-1, 0),
          colors: [AppColors.boxgray, Colors.white12, AppColors.boxgray],
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
    );
  }
}

