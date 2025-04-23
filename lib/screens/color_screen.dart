import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data.dart';
import 'full_screen_color.dart';
import 'Seating_Map_Screen.dart'; // Import the seating map screen

// Helper function to convert opacity to alpha
int opacityToAlpha(double opacity) {
  return (opacity.clamp(0.0, 1.0) * 255).round();
}

class ColorScreen extends StatelessWidget {
  final Concert concert;

  ColorScreen({super.key, required this.concert});

  // Song data for different colors - keeping the original purple and orange
  final Map<Color, Map<String, String>> _songData = {
    Colors.deepPurple: {
      'title': 'TBD',
      'description': 'Use purple lights during TBD'
    },
    Colors.deepOrange: {
      'title': 'TBD',
      'description': 'Use orange lights during TBD'
    },
  };

  // Method to show seating map with direct venue mapping
  void _showSeatingMap(BuildContext context, String venue) {
    // Define the mapping specifically matching the exact venue names in your data
    final Map<String, String> venueMap = {
      'Gas South Arena': 'assets/Sleep_Token_Gas_South.jpg',
      'Kia Center': 'assets/Sleep_Token_Kia_Center.png',
      'First Horizon Coliseum': 'assets/Sleep_Token_Greensboro_coliseum.jpg',
      'Barclays Center': 'assets/Sleep_Token_Barclays_Center.png',
      'DCU Center': 'assets/Sleep_Token_DCU_Center.jpg',
      'Wells Fargo Center': 'assets/Sleep_Token_Wells_Fargo_Center.png',
      'Little Caesars Arena': 'assets/Sleep_Token_Little_Ceasers_Arena.png',
      'Rocket Arena': 'assets/Sleep_Token_Rocket_Arena.png',
      'Allstate Arena': 'assets/Sleep_Token_Allstate_Arena.jpg',
      'Pinnacle Bank Arena': 'assets/Sleep_Token_Allstate_Arena.jpg', // Using a placeholder for now
      'Target Center': 'assets/Sleep_Token_Target_Center_Concert.png',
      'Ball Arena': 'assets/Sleep_Token_Ball_Arena.png',
      'Maverik Center': 'assets/Sleep_Token_Maverik_Center.png',
      'Tacoma Dome': 'assets/Sleep_Token_Tacoma_Dome.png',
      'Moda Center': 'assets/Sleep_Token_Moda_Center.png',
      'Oakland Arena': 'assets/Sleep_Token_Oakland_Arena.png',
      'Crypto.com Arena': 'assets/Sleep_Token_Crypto_Arena.png',
    };
    
    // Get the correct map asset path for the venue
    final String mapAsset = venueMap[venue] ?? 'assets/Sleep_Token_Allstate_Arena.jpg';
    
    // Navigate to the seating map screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SeatingMapScreen(
          venue: venue,
          mapAsset: mapAsset,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions for responsive sizing
    final screenWidth = MediaQuery.of(context).size.width;
    final smallFontSize = 14.0; // Base font size for the button

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
          concert.venue,
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
            color: Color(0xFFDAB85A).withAlpha(opacityToAlpha(0.3)), // Subtle gold divider
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
            fit: BoxFit.cover, // Changed to cover for full screen fill
            alignment: Alignment.center,
          ),
        ),
        child: Column(
          // Change from center to start alignment to avoid overflow
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Add some top padding
            SizedBox(height: 20),
            
            // Concert information
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xFF1E2D23).withAlpha(opacityToAlpha(0.8)), // Hunter green background with transparency
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Color(0xFFDAB85A).withAlpha(opacityToAlpha(0.3)), // Muted gold border
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(opacityToAlpha(0.3)),
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // City name
                    Text(
                      concert.city,
                      style: GoogleFonts.cinzel(
                        textStyle: TextStyle(
                          color: Color(0xFFDAB85A), // Gold text
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    // Date
                    Text(
                      concert.date,
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: Colors.white.withAlpha(opacityToAlpha(0.7)),
                          fontSize: 16,
                        ),
                      ),
                    ),
                    // Gold divider
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Container(
                        height: 1,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Color(0xFFDAB85A).withAlpha(opacityToAlpha(0.3)),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Seating chart button
                    OutlinedButton.icon(
                      icon: Icon(
                        Icons.chair_outlined, 
                        size: smallFontSize * 1.2, 
                        color: Color(0xFFDAB85A)
                      ),
                      label: Text(
                        'VIEW SEATING CHART',
                        style: GoogleFonts.cinzel(
                          textStyle: TextStyle(
                            color: Color(0xFFDAB85A),
                            fontSize: smallFontSize,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Color(0xFFDAB85A).withAlpha(opacityToAlpha(0.5))),
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.03,
                          vertical: screenWidth * 0.015
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () {
                        _showSeatingMap(context, concert.venue);
                      },
                    ),
                  ],
                ),
              ),
            ),
            
            // Ritual Colors title with mystical design
            Stack(
              alignment: Alignment.center,
              children: [
                // Decorative lines
                Container(
                  width: 200,
                  height: 1,
                  color: Color(0xFFDAB85A).withAlpha(opacityToAlpha(0.3)),
                ),
                // Title with background
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: BoxDecoration(
                    color: Color(0xFF121212),
                    border: Border.all(
                      color: Color(0xFFDAB85A).withAlpha(opacityToAlpha(0.3)),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'RITUAL COLORS',
                    style: GoogleFonts.cinzel(
                      textStyle: TextStyle(
                        color: Color(0xFFDAB85A), // Gold text
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 30), // Slightly reduced from 40
            
            // Color choices in a nicer layout
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildColorChoice(Colors.deepPurple, 'PURPLE', context),
                _buildColorChoice(Colors.deepOrange, 'ORANGE', context),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorChoice(Color color, String label, BuildContext context) {
    final songInfo = _songData[color] ?? {'title': 'Unknown', 'description': 'Details coming soon'};
    
    // Function to navigate to full screen color
    void _navigateToFullScreen() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => FullScreenColorScreen(color: color),
        ),
      );
    }
    
    return Column(
      children: [
        // Color circle with tap functionality
        InkWell(
          onTap: _navigateToFullScreen,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Simple color circle with gold border
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color,
                  border: Border.all(
                    color: Color(0xFFDAB85A).withAlpha(opacityToAlpha(0.3)),
                    width: 1.5,
                  ),
                ),
              ),
              // Symbol overlay
              if (color == Colors.deepPurple)
                Icon(
                  Icons.auto_awesome, // Mystical symbol for purple
                  color: Colors.white.withAlpha(opacityToAlpha(0.15)), // Less intense white
                  size: 25, // Slightly smaller
                )
              else
                Icon(
                  Icons.whatshot, // Fire-like symbol for orange
                  color: Colors.white.withAlpha(opacityToAlpha(0.15)), // Less intense white
                  size: 25, // Slightly smaller
                ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        // Song title
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Color(0xFF1E2D23).withAlpha(opacityToAlpha(0.7)),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Color(0xFFDAB85A).withAlpha(opacityToAlpha(0.2)),
              width: 1,
            ),
          ),
          child: Text(
            songInfo['title']!,
            style: GoogleFonts.cinzel(
              textStyle: TextStyle(
                color: Color(0xFFDAB85A), // Gold text
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        // Song description
        Container(
          width: 150,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: Color(0xFF1E2D23).withAlpha(opacityToAlpha(0.5)),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Color(0xFFDAB85A).withAlpha(opacityToAlpha(0.1)),
              width: 1,
            ),
          ),
          child: Text(
            songInfo['description']!,
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(
              textStyle: TextStyle(
                color: Colors.white.withAlpha(opacityToAlpha(0.8)),
                fontSize: 12,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Button
        ElevatedButton(
          onPressed: _navigateToFullScreen,
          style: ElevatedButton.styleFrom(
            backgroundColor: color.withAlpha(opacityToAlpha(0.7)), // Slightly more muted
            foregroundColor: Colors.white, // White text for both colors
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 4, // Less elevation
            shadowColor: color.withAlpha(opacityToAlpha(0.3)), // More subtle shadow
          ),
          child: Text(
            'ILLUMINATE',
            style: GoogleFonts.cinzel(
              textStyle: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}