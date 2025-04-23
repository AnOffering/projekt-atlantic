import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:google_fonts/google_fonts.dart';

// Helper function to convert opacity to alpha
int opacityToAlpha(double opacity) {
  return (opacity.clamp(0.0, 1.0) * 255).round();
}

class JerryVideoScreen extends StatefulWidget {
  const JerryVideoScreen({super.key});

  @override
  State<JerryVideoScreen> createState() => _JerryVideoScreenState();
}

class _JerryVideoScreenState extends State<JerryVideoScreen> {
  late VideoPlayerController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    // Initialize the controller with the video
    _controller = VideoPlayerController.asset('assets/Jerry_dancing.mp4')
      ..initialize().then((_) {
        // Ensure the first frame is shown
        setState(() {
          _isInitialized = true;
        });
        // Start playing as soon as initialized
        _controller.play();
        // Loop the video
        _controller.setLooping(true);
      });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions 
    final screenSize = MediaQuery.of(context).size;
    
    // Calculate safe insets
    final safePadding = MediaQuery.of(context).padding;
    
    // Calculate the height of AppBar
    final appBarHeight = AppBar().preferredSize.height;
    
    // Height available for content
    final availableHeight = screenSize.height - safePadding.top - safePadding.bottom - appBarHeight;
    
    // Reserve height for controls
    final controlsHeight = 70.0;
    
    // Height available for video
    final videoContainerHeight = availableHeight - controlsHeight;
    
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        title: Text(
          'JERRY\'S SECRET DANCE',
          style: GoogleFonts.cinzel(
            textStyle: TextStyle(
              color: Color(0xFFDAB85A),
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Color(0xFFDAB85A), // Gold color for the back arrow
        ),
      ),
      body: SafeArea(
        child: _isInitialized
            ? Column(
                children: [
                  // Video container with specific dimensions
                  SizedBox(
                    height: videoContainerHeight,
                    child: Center(
                      child: AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: Container(
                          margin: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(0xFFDAB85A).withAlpha(opacityToAlpha(0.5)),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: VideoPlayer(_controller),
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  // Controls with fixed height
                  SizedBox(
                    height: controlsHeight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            _controller.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Color(0xFFDAB85A),
                            size: 32,
                          ),
                          onPressed: () {
                            setState(() {
                              _controller.value.isPlaying
                                  ? _controller.pause()
                                  : _controller.play();
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.replay,
                            color: Color(0xFFDAB85A),
                            size: 28,
                          ),
                          onPressed: () {
                            _controller.seekTo(Duration.zero);
                            _controller.play();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Center(
                child: CircularProgressIndicator(
                  color: Color(0xFFDAB85A),
                ),
              ),
      ),
    );
  }
}