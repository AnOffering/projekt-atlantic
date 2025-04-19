import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SeatingMapScreen extends StatelessWidget {
  final String venue;
  final String mapAsset;

  const SeatingMapScreen({
    required this.venue,
    required this.mapAsset,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Nearly black background
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF1A1A1A), // Very dark gray, almost black
                const Color(0xFF121212), // Pure black background
              ],
            ),
          ),
        ),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'SEATING CHART',
          style: GoogleFonts.cinzel(
            textStyle: TextStyle(
              color: Color(0xFFDAB85A), // Muted gold text
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
        iconTheme: IconThemeData(
          color: Color(0xFFDAB85A), // Gold icons
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            height: 1.0,
            color: Color(0xFFDAB85A).withOpacity(0.3), // Subtle gold divider
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          // Background color
          color: const Color(0xFF121212),
          // Cherry blossom decorative elements
          image: DecorationImage(
            image: AssetImage('assets/cherry_blossom.png'),
            opacity: 0.5, // Match the opacity from concert list
            fit: BoxFit.cover, // Changed to cover for full screen
            alignment: Alignment.center,
          ),
        ),
        // Use Stack to position Jerry in the corner
        child: Stack(
          children: [
            // Main content
            Column(
              children: [
                // Venue name
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    venue,
                    style: GoogleFonts.cinzel(
                      textStyle: TextStyle(
                        color: Color(0xFFDAB85A), // Gold text
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                ),
                
                // Seating map with interactive viewer
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF1E2D23).withOpacity(0.7), // Hunter green background with transparency
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Color(0xFFDAB85A).withOpacity(0.3), // Muted gold border
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 8,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: InteractiveViewer(
                          boundaryMargin: EdgeInsets.all(20),
                          minScale: 0.1,
                          maxScale: 4.0,
                          child: Image.asset(
                            mapAsset,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              // Fallback if the image fails to load
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.image_not_supported,
                                      color: Color(0xFFDAB85A).withOpacity(0.5),
                                      size: 50,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      'Seating map not available',
                                      style: GoogleFonts.raleway(
                                        textStyle: TextStyle(
                                          color: Color(0xFFDAB85A),
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                
                // Instructions text
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Pinch to zoom and drag to move around the seating chart',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.raleway(
                      textStyle: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            // Jerry in the top right corner
            Positioned(
              right: 10,
              top: 10,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Color(0xFFC06C84).withOpacity(0.1), // Very subtle cherry blossom pink
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/GoldJerry.png',
                    width: 30,
                    height: 30,
                    color: Color(0xFFDAB85A).withOpacity(0.8),
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