import 'package:flutter/material.dart';
import 'dart:math';

class LimeDecoratedBackground extends StatefulWidget {
  final Widget child;
  final bool showWatermark;
  final bool showPattern;
  final bool showCornerEmoji;

  const LimeDecoratedBackground({
    Key? key,
    required this.child,
    this.showWatermark = true,
    this.showPattern = true,
    this.showCornerEmoji = true,
  }) : super(key: key);

  @override
  State<LimeDecoratedBackground> createState() =>
      _LimeDecoratedBackgroundState();
}

class _LimeDecoratedBackgroundState extends State<LimeDecoratedBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: widget.child,
        ),
        if (widget.showPattern)
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: LimePatternPainter(
                  animation: _animationController.view,
                ),
              ),
            ),
          ),
        if (widget.showWatermark)
          Positioned(
            top: 20,
            right: 20,
            child: Opacity(
              opacity: 0.15,
              child: Text(
                '🍋',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ),
        if (widget.showCornerEmoji) ...[
          Positioned(
            top: 10,
            left: 10,
            child: FloatingLimeFruit(
              emoji: '🍋',
              offset: Offset(0, -20),
              duration: const Duration(seconds: 3),
            ),
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: FloatingLimeFruit(
              emoji: '🍋',
              offset: Offset(10, -15),
              duration: const Duration(seconds: 4),
              delayFactor: 0.5,
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: FloatingLimeFruit(
              emoji: '🍋',
              offset: Offset(-15, -25),
              duration: const Duration(seconds: 3.5),
              delayFactor: 0.25,
            ),
          ),
        ],
      ],
    );
  }
}

class LimePatternPainter extends CustomPainter {
  final Animation<double> animation;

  LimePatternPainter({required this.animation}) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF22DD22).withOpacity(0.08)
      ..style = PaintingStyle.fill;

    final linePaint = Paint()
      ..color = const Color(0xFF22DD22).withOpacity(0.04)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final random = Random(42);
    const spacing = 80;
    final animationValue = animation.value;

    for (int i = 0; i < (size.width / spacing).ceil(); i++) {
      for (int j = 0; j < (size.height / spacing).ceil(); j++) {
        final x = i * spacing + (random.nextDouble() - 0.5) * 40;
        final y = j * spacing + (random.nextDouble() - 0.5) * 40;

        final baseRadius = 15 + sin(animationValue * pi * 2 + i + j) * 5;

        canvas.drawCircle(
          Offset(x, y),
          baseRadius,
          paint,
        );

        canvas.drawCircle(
          Offset(x, y),
          baseRadius * (1 + sin(animationValue * pi * 2) * 0.3),
          linePaint,
        );

        if (i < (size.width / spacing).ceil() - 1) {
          final nextX = (i + 1) * spacing + (random.nextDouble() - 0.5) * 40;
          final nextY = j * spacing + (random.nextDouble() - 0.5) * 40;

          canvas.drawLine(
            Offset(x, y),
            Offset(nextX, nextY),
            linePaint,
          );
        }
      }
    }

    final gradientPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFF22DD22).withOpacity(0.02),
          Colors.transparent,
          const Color(0xFF22DD22).withOpacity(0.02),
        ],
        stops: [
          0,
          0.5 + sin(animationValue * pi * 2) * 0.2,
          1,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      gradientPaint,
    );
  }

  @override
  bool shouldRepaint(LimePatternPainter oldDelegate) => true;
}

class FloatingLimeFruit extends StatefulWidget {
  final String emoji;
  final Offset offset;
  final Duration duration;
  final double delayFactor;

  const FloatingLimeFruit({
    Key? key,
    required this.emoji,
    required this.offset,
    required this.duration,
    this.delayFactor = 0.0,
  }) : super(key: key);

  @override
  State<FloatingLimeFruit> createState() => _FloatingLimeFruitState();
}

class _FloatingLimeFruitState extends State<FloatingLimeFruit>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat();

    if (widget.delayFactor > 0) {
      Future.delayed(
        Duration(
          milliseconds: (widget.duration.inMilliseconds * widget.delayFactor)
              .toInt(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final animValue = _controller.value;

        final yOffset = sin(animValue * pi * 2) * widget.offset.dy;
        final xOffset = sin(animValue * pi * 2 + pi / 2) * widget.offset.dx;

        final rotation = animValue * pi * 2;

        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..translate(xOffset, yOffset)
            ..setEntry(3, 2, 0.001)
            ..rotateZ(rotation),
          child: child,
        );
      },
      child: Text(
        widget.emoji,
        style: const TextStyle(fontSize: 40),
      ),
    );
  }
}

class LimeFruitBadge extends StatefulWidget {
  final String label;
  final Color color;
  final VoidCallback? onTap;

  const LimeFruitBadge({
    Key? key,
    required this.label,
    this.color = const Color(0xFF22DD22),
    this.onTap,
  }) : super(key: key);

  @override
  State<LimeFruitBadge> createState() => _LimeFruitBadgeState();
}

class _LimeFruitBadgeState extends State<LimeFruitBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: Tween<double>(begin: 1.0, end: 1.1).animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeInOutCubic),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: widget.color.withOpacity(0.4),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '🍋',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(width: 6),
              Text(
                widget.label,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LimeProgressIndicator extends StatefulWidget {
  final double value;
  final double height;
  final Duration animationDuration;

  const LimeProgressIndicator({
    Key? key,
    required this.value,
    this.height = 6,
    this.animationDuration = const Duration(milliseconds: 600),
  }) : super(key: key);

  @override
  State<LimeProgressIndicator> createState() => _LimeProgressIndicatorState();
}

class _LimeProgressIndicatorState extends State<LimeProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: widget.value).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(LimeProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _animation = Tween<double>(begin: _animation.value, end: widget.value)
          .animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
      );
      _controller.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(widget.height / 2),
          child: LinearProgressIndicator(
            value: _animation.value,
            minHeight: widget.height,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(
              const Color(0xFF22DD22),
            ),
          ),
        );
      },
    );
  }
}
