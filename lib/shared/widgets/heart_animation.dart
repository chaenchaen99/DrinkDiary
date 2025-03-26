import 'package:flutter/material.dart';
import 'dart:math';

class HeartAnimation extends StatefulWidget {
  const HeartAnimation({super.key});

  @override
  State<HeartAnimation> createState() => _HeartAnimationState();
}

class _HeartAnimationState extends State<HeartAnimation>
    with SingleTickerProviderStateMixin {
  bool isLiked = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  final List<HeartBurst> _hearts = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn,
      ),
    );
  }

  void _addHearts() async {
    // 6개의 하트를 순차적으로 생성
    for (int i = 0; i < 6; i++) {
      setState(() {
        _hearts.add(HeartBurst(
          key: UniqueKey(),
          index: i, // 인덱스 전달
          onComplete: () {
            setState(() {
              _hearts.removeAt(0);
            });
          },
        ));
      });
      // 각 하트 사이에 약간의 딜레이
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isLiked = !isLiked;
          if (isLiked) {
            _controller.forward().then((_) => _controller.reverse());
            _addHearts();
          }
        });
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ScaleTransition(
            scale: _scaleAnimation,
            child: Image.asset(
              isLiked
                  ? 'assets/icons/heart_fill.png'
                  : 'assets/icons/heart_blank.png',
              width: 20,
              height: 20,
            ),
          ),
          ..._hearts,
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

// 터지는 하트 애니메이션 위젯
class HeartBurst extends StatefulWidget {
  final VoidCallback onComplete;
  final int index; // 인덱스 추가

  const HeartBurst({
    super.key,
    required this.onComplete,
    required this.index,
  });

  @override
  State<HeartBurst> createState() => _HeartBurstState();
}

class _HeartBurstState extends State<HeartBurst>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _moveAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _horizontalAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    // 지그재그 패턴을 위한 X축 오프셋 계산
    final double horizontalOffset = widget.index.isEven ? 10 : -10;

    _horizontalAnimation = Tween<double>(
      begin: 0,
      end: horizontalOffset,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeOutSine),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.2, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );

    _moveAnimation = Tween<double>(begin: 0, end: 60).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeOutQuart),
      ),
    );

    _fadeAnimation = Tween<double>(begin: 0.8, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );

    _controller.forward().then((_) => widget.onComplete());
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          left: _horizontalAnimation.value,
          bottom: _moveAnimation.value,
          child: Transform.scale(
            scale: _scaleAnimation.value,
            child: Opacity(
              opacity: _fadeAnimation.value,
              child: Image.asset(
                'assets/icons/heart_fill.png',
                width: 15,
                height: 15,
                color: Colors.red,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
