import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(32.0),
          child: SquareAnimation(),
        ),
      ),
    );
  }
}

class SquareAnimation extends StatefulWidget {
  const SquareAnimation({super.key});

  @override
  State<SquareAnimation> createState() {
    return SquareAnimationState();
  }
}

class SquareAnimationState extends State<SquareAnimation> {
  static const _squareSize = 50.0;
  static const _animationDuration = Duration(seconds: 1);

  double _position = 0.0; // Initial position in the center
  bool _isAnimating = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxPosition = screenWidth - _squareSize - 64; // Account for padding

    bool isAtLeftEdge = _position <= 0;
    bool isAtRightEdge = _position >= maxPosition;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 80,
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: _animationDuration,
                left: _position,
                child: Container(
                  width: _squareSize,
                  height: _squareSize,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border.all(),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _isAnimating || isAtLeftEdge ? null : _moveLeft,
              child: const Text('Left'),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: _isAnimating || isAtRightEdge ? null : _moveRight,
              child: const Text('Right'),
            ),
          ],
        ),
      ],
    );
  }

  void _moveRight() {
    setState(() {
      _isAnimating = true;
      _position = MediaQuery.of(context).size.width - _squareSize - 64;
    });
    Future.delayed(_animationDuration, () {
      setState(() {
        _isAnimating = false;
      });
    });
  }

  void _moveLeft() {
    setState(() {
      _isAnimating = true;
      _position = 0;
    });
    Future.delayed(_animationDuration, () {
      setState(() {
        _isAnimating = false;
      });
    });
  }
}