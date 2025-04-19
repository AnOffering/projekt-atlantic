import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color_screen.dart';
import '../data.dart';

class ConcertListScreen extends StatelessWidget {
  final List<Concert> concerts = [
    Concert(
      venue: 'Gas South Arena',
      city: 'Duluth, GA',
      date: 'September 16, 2025',
      color: Colors.deepPurple,
    ),
    Concert(
      venue: 'Kia Center',
      city: 'Orlando, FL',
      date: 'September 17, 2025',
      color: Colors.deepOrange,
    ),
    Concert(
      venue: 'First Horizon Coliseum',
      city: 'Greensboro, NC',
      date: 'September 20, 2025',
      color: Colors.deepPurple,
    ),
    Concert(
      venue: 'Barclays Center',
      city: 'Brooklyn, NY',
      date: 'September 22, 2025',
      color: Colors.deepOrange,
    ),
    Concert(
      venue: 'DCU Center',
      city: 'Worcester, MA',
      date: 'September 23, 2025',
      color: Colors.deepPurple,
    ),
    Concert(
      venue: 'Wells Fargo Center',
      city: 'Philadelphia, PA',
      date: 'September 24, 2025',
      color: Colors.deepOrange,
    ),
    Concert(
      venue: 'Little Caesars Arena',
      city: 'Detroit, MI',
      date: 'September 26, 2025',
      color: Colors.deepPurple,
    ),
    Concert(
      venue: 'Rocket Arena',
      city: 'Cleveland, OH',
      date: 'September 27, 2025',
      color: Colors.deepOrange,
    ),
    Concert(
      venue: 'Allstate Arena',
      city: 'Rosemont, IL',
      date: 'September 28, 2025',
      color: Colors.deepPurple,
    ),
    Concert(
      venue: 'Pinnacle Bank Arena',
      city: 'Lincoln, NE',
      date: 'September 30, 2025',
      color: Colors.deepOrange,
    ),
    Concert(
      venue: 'Target Center',
      city: 'Minneapolis, MN',
      date: 'October 1, 2025',
      color: Colors.deepPurple,
    ),
    Concert(
      venue: 'Ball Arena',
      city: 'Denver, CO',
      date: 'October 3, 2025',
      color: Colors.deepOrange,
    ),
    Concert(
      venue: 'Maverik Center',
      city: 'West Valley City, UT',
      date: 'October 5, 2025',
      color: Colors.deepPurple,
    ),
    Concert(
      venue: 'Tacoma Dome',
      city: 'Tacoma, WA',
      date: 'October 7, 2025',
      color: Colors.deepOrange,
    ),
    Concert(
      venue: 'Moda Center',
      city: 'Portland, OR',
      date: 'October 8, 2025',
      color: Colors.deepPurple,
    ),
    Concert(
      venue: 'Oakland Arena',
      city: 'Oakland, CA',
      date: 'October 10, 2025',
      color: Colors.deepOrange,
    ),
    Concert(
      venue: 'Crypto.com Arena',
      city: 'Los Angeles, CA',
      date: 'October 11, 2025',
      color: Colors.deepPurple,
    ),
  ];

  ConcertListScreen({super.key});

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
        title: Text(
          'PROJEKT ATLANTIC',
          style: GoogleFonts.cinzel(
            textStyle: TextStyle(
              color: Color(0xFFDAB85A), // Muted gold text
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 2.0,
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            height: 1.0,
            color: Color(0xFFDAB85A).withOpacity(0.3), // Subtle gold divider
          ),
        ),
        centerTitle: true,
      
      ),
      body: Container(
        decoration: BoxDecoration(
          // Background color
          color: const Color(0xFF121212),
          // Cherry blossom decorative elements
          image: DecorationImage(
            image: AssetImage('assets/cherry_blossom.png'),
            opacity: 0.5, // Very subtle opacity
            fit: BoxFit.fill, // Fit to width but not necessarily height
            alignment: Alignment.center, // Align to top right
            scale: 1.5, // Scale down to avoid being too zoomed in
          ),
        ),
        child: Stack(
          children: [
            
            
            // Main content
            SafeArea(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: concerts.length,
                itemBuilder: (context, index) {
                  final concert = concerts[index];
                  return TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: Duration(milliseconds: 600 + (index * 100)),
                    builder: (context, double value, child) {
                      return Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, (1 - value) * 20),
                          child: child,
                        ),
                      );
                    },
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ColorScreen(concert: concert),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Color(0xFF1E2D23), // Hunter green background
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 8,
                              offset: Offset(0, 3),
                            ),
                          ],
                          border: Border.all(
                            color: Color(0xFFDAB85A).withOpacity(0.2), // Subtle gold border
                            width: 1,
                          ),
                        ),
                        child: Stack(
                          children: [
                            // Subtle accent corner with Jerry
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Color(0xFFC06C84).withOpacity(0.1), // Very subtle cherry blossom pink
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                  ),
                                ),
                                child: Center(
                                  child: Image.asset(
                                    'assets/GoldJerry.png',
                                    width: 100,
                                    height: 100,
                                    color: Color(0xFFDAB85A).withOpacity(0.8),
                                  ),
                                ),
                              ),
                            ),
                            
                            // Main content padding
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          concert.venue,
                                          style: GoogleFonts.cinzel(
                                            textStyle: TextStyle(
                                              color: Color(0xFFDAB85A), // Gold text for visibility
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1.2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    concert.city,
                                    style: GoogleFonts.raleway(
                                      textStyle: TextStyle(
                                        color: Colors.white.withOpacity(0.8), // White text for good visibility
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    concert.date,
                                    style: GoogleFonts.raleway(
                                      textStyle: TextStyle(
                                        color: Colors.white.withOpacity(0.6),
                                        fontSize: 14,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                  
                                  // Subtle divider
                                  Padding(
                                    padding: const EdgeInsets.only(top: 12),
                                    child: Container(
                                      height: 1,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.transparent,
                                            Color(0xFFDAB85A).withOpacity(0.3),
                                            Colors.transparent,
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}