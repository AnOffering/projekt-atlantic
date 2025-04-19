import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:screen_brightness/screen_brightness.dart';

class FullScreenColorScreen extends StatefulWidget {
  final Color color;

  const FullScreenColorScreen({super.key, required this.color});

  @override
  State<FullScreenColorScreen> createState() => _FullScreenColorScreenState();
}

class _FullScreenColorScreenState extends State<FullScreenColorScreen> with SingleTickerProviderStateMixin {
  double? _previousBrightness;
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _setMaxBrightness();
    
    // Setup pulse animation for the light effect with a slower, more ethereal pace
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6), // slower animation for less eye strain
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(begin: 0.9, end: 1.0).animate( // less intense pulsing
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  Future<void> _setMaxBrightness() async {
    try {
      _previousBrightness = await ScreenBrightness().current;
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
        body: AnimatedBuilder(
          animation: _pulseAnimation,
          builder: (context, child) {
            return Stack(
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
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      margin: EdgeInsets.only(bottom: 30),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        'TAP TO RETURN',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.cinzel(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 3.0,
                            shadows: [
                              Shadow(
                                blurRadius: 4.0,
                                color: Colors.black.withOpacity(0.4),
                                offset: const Offset(0, 0),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}