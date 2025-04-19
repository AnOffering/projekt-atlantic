import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Particle> _pinkParticles = [];
  final List<Particle> _goldParticles = [];
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
    
    // Create pink cherry blossom particles (background)
    final random = Random();
    for (int i = 0; i < 40; i++) {
      _pinkParticles.add(
        Particle(
          x: random.nextDouble() * 400,
          y: random.nextDouble() * 800,
          radius: random.nextDouble() * 2 + 1,
          color: Color(0xFFC06C84).withOpacity(random.nextDouble() * 0.5 + 0.2), // Cherry blossom pink
          speed: random.nextDouble() * 0.5 + 0.2,
          isGold: false,
        ),
      );
    }
    
    // Create gold particles (foreground) - larger, more prominent
    for (int i = 0; i < 30; i++) {
      _goldParticles.add(
        Particle(
          x: random.nextDouble() * 400,
          y: random.nextDouble() * 800,
          radius: random.nextDouble() * 2.5 + 1.5, // Slightly larger
          color: Color(0xFFDAB85A).withOpacity(random.nextDouble() * 0.6 + 0.4), // More vibrant gold
          speed: random.nextDouble() * 0.3 + 0.1, // Slightly slower for layered effect
          isGold: true,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _launchLinktree() async {
    final Uri url = Uri.parse('https://linktr.ee/projektatlantic');
    print("Trying to launch $url");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.platformDefault);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Nearly black background
      body: Stack(
        children: [
          // Cherry blossom background
          Container(
            decoration: BoxDecoration(
              // Background color
              color: const Color(0xFF121212),
              // Cherry blossom decorative element
              image: DecorationImage(
                image: AssetImage('assets/cherry_blossom.png'),
                opacity: 0.5, // Match the opacity from the concert list screen
                fit: BoxFit.fill, // Fill the entire background
                alignment: Alignment.center,
              ),
            ),
          ),
          
          // Pink cherry blossom particles (background layer)
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: ParticlePainter(
                  particles: _pinkParticles,
                  animation: _controller,
                ),
                child: Container(),
              );
            },
          ),
          
          // Gold particles (foreground layer) - more prominent
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return CustomPaint(
                painter: GoldParticlePainter(
                  particles: _goldParticles,
                  animation: _controller,
                ),
                child: Container(),
              );
            },
          ),
          
          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                
                // Logo with subtle glow effect
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.9, end: 1.0),
                  duration: Duration(seconds: 3),
                  curve: Curves.easeInOut,
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value, // Subtle breathing animation
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFFDAB85A).withOpacity(0.15 * value), // Animated glow
                              blurRadius: 20 * value,
                              spreadRadius: 2 * value,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'assets/projekt_atlantic_logo5.png',
                          height: 220,
                          color: Color(0xFFDAB85A), // Muted gold logo
                        ),
                      ),
                    );
                  },
                  onEnd: () {
                    setState(() {}); // Restart the animation
                  },
                ),
                
                const SizedBox(height: 60),
                
                // View Concerts button - with subtle green and gold
                GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/concerts'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E2D23),
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      border: Border.all(
                        color: const Color(0xFFDAB85A).withOpacity(0.4),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'View Concerts',
                          style: GoogleFonts.cinzel( 
                            textStyle: TextStyle(
                              color: Color(0xFFDAB85A),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0,
                            ), 
                          ),
                        ),
                        const SizedBox(width: 10),
                        Image.asset(
                          'assets/GoldJerry.png',
                          height: 26,
                        ),
                      ],
                    ),
                  ),
                ),

                
                // Linktree button - with subtle dark and cherry blossom accent
                GestureDetector(
                  onTap: _launchLinktree,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: Color(0xFF1E2D23), // Hunter green background
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ],
                      border: Border.all(
                        color: Color(0xFFDAB85A).withOpacity(0.4), // Muted gold border
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'LINKTREE',
                          style: GoogleFonts.cinzel(
                            textStyle: TextStyle(
                              color: Color(0xFFDAB85A), // Muted gold text
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2.0,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        // Small cherry blossom accent on the Linktree button
                        Opacity(
                          opacity: 0.7,
                          child: Icon(
                            Icons.eco, // Leaf/nature icon
                            color: Color(0xFFC06C84).withOpacity(0.6), // Cherry blossom pink
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Particle class to represent each floating petal
class Particle {
  double x;
  double y;
  double radius;
  Color color;
  double speed;
  bool isGold; // To distinguish between gold and pink particles

  Particle({
    required this.x,
    required this.y,
    required this.radius,
    required this.color,
    required this.speed,
    required this.isGold,
  });
}

// CustomPainter for drawing the pink cherry blossom particles
class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final Animation<double> animation;

  ParticlePainter({required this.particles, required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      // Update particle position
      particle.y += particle.speed;
      
      // Reset particle if it goes off screen
      if (particle.y > size.height) {
        particle.y = 0;
        particle.x = Random().nextDouble() * size.width;
      }

      // Gentle swaying motion
      double xOffset = sin(animation.value * 2 * pi + particle.y / 50) * 2;
      
      final paint = Paint()
        ..color = particle.color
        ..style = PaintingStyle.fill;
      
      // Draw cherry blossom petals as oval shapes
      final rect = Rect.fromCenter(
        center: Offset(particle.x + xOffset, particle.y), 
        width: particle.radius * 5, 
        height: particle.radius * 2.5,
      );
      
      // Rotate the petal based on its position
      canvas.save();
      canvas.translate(particle.x + xOffset, particle.y);
      canvas.rotate(particle.x * 0.1 + animation.value);
      canvas.translate(-(particle.x + xOffset), -particle.y);
      
      canvas.drawOval(rect, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant ParticlePainter oldDelegate) => true;
}

// CustomPainter for drawing the gold particles
class GoldParticlePainter extends CustomPainter {
  final List<Particle> particles;
  final Animation<double> animation;

  GoldParticlePainter({required this.particles, required this.animation});

  @override
  void paint(Canvas canvas, Size size) {
    for (var particle in particles) {
      // Update particle position
      particle.y += particle.speed;
      
      // Reset particle if it goes off screen
      if (particle.y > size.height) {
        particle.y = 0;
        particle.x = Random().nextDouble() * size.width;
      }

      // More subtle swaying motion for gold particles
      double xOffset = sin(animation.value * 2 * pi + particle.y / 70) * 1.5;
      
      final paint = Paint()
        ..color = particle.color
        ..style = PaintingStyle.fill
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, particle.radius * 0.5); // Add glow effect
      
      // Draw gold particles with glow
      canvas.drawCircle(
        Offset(particle.x + xOffset, particle.y),
        particle.radius,
        paint,
      );
      
      // Add a smaller, brighter center to the gold particles
      final highlightPaint = Paint()
        ..color = Color(0xFFDAB85A).withOpacity(0.8)
        ..style = PaintingStyle.fill;
        
      canvas.drawCircle(
        Offset(particle.x + xOffset, particle.y),
        particle.radius * 0.5,
        highlightPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant GoldParticlePainter oldDelegate) => true;
}