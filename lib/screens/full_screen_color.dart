import 'package:flutter/material.dart';
import 'package:screen_brightness/screen_brightness.dart';

// Helper function to convert opacity to alpha
int opacityToAlpha(double opacity) {
  return (opacity.clamp(0.0, 1.0) * 255).round();
}

class FullScreenColorScreen extends StatefulWidget {
  final Color color;

  const FullScreenColorScreen({super.key, required this.color});

  @override
  State<FullScreenColorScreen> createState() => _FullScreenColorScreenState();
}

class _FullScreenColorScreenState extends State<FullScreenColorScreen> with SingleTickerProviderStateMixin {
  double? _previousBrightness;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _setBrightness();
    
    // Setup pulse animation for the light effect
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);
  }

  Future<void> _setBrightness() async {
    try {
      // Get current brightness to restore later
      _previousBrightness = await ScreenBrightness().current;
      
      // Set brightness to maximum - use correct method for version 0.2.0+
      await ScreenBrightness().setScreenBrightness(1.0);
    } catch (e) {
      debugPrint('Failed to change brightness: $e');
    }
  }

  Future<void> _restoreBrightness() async {
    try {
      if (_previousBrightness != null) {
        await ScreenBrightness().setScreenBrightness(_previousBrightness!);
      }
    } catch (e) {
      debugPrint('Failed to restore brightness: $e');
    }
  }

  @override
  void dispose() {
    _restoreBrightness();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Scaffold(
        backgroundColor: widget.color,
        body: Stack(
          children: [
            // Solid color background (100% opacity)
            Container(
              color: widget.color,
            ),
            
            // Bottom "Tap to return" message
            SafeArea(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  margin: const EdgeInsets.only(bottom: 30),
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(opacityToAlpha(0.2)),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    'TAP TO RETURN',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 3.0,
                      shadows: [
                        Shadow(
                          blurRadius: 4.0,
                          color: Colors.black.withAlpha(opacityToAlpha(0.4)),
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}