import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SnakeGame extends StatefulWidget {
  const SnakeGame({super.key});

  @override
  State<SnakeGame> createState() => _SnakeGameState();
}

class _SnakeGameState extends State<SnakeGame> {
  static const int gridSize = 20;
  
  List<Point> snake = [];
  Point? food;
  Timer? timer;
  Direction direction = Direction.right;
  bool isPlaying = false;
  int score = 0;
  
  // Game speed
  static const int gameSpeed = 200;

  // App theme colors
  final Color backgroundColor = const Color(0xFF121212); // Nearly black background
  final Color primaryColor = const Color(0xFF1E2D23); // Hunter green
  final Color accentColor = const Color(0xFFDAB85A); // Muted gold
  final Color complementaryColor = const Color(0xFFC06C84); // Cherry blossom pink

  @override
  void initState() {
    super.initState();
    initGame();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void initGame() {
    // Initialize snake in the middle
    snake = [Point(gridSize ~/ 2, gridSize ~/ 2)];
    
    // Add direction
    direction = Direction.right;
    
    // Add food
    generateFood();
    
    // Start the game
    isPlaying = false;
    score = 0;
  }

  void startGame() {
    if (isPlaying) return;
    
    setState(() {
      isPlaying = true;
    });
    
    // Start the game loop
    timer = Timer.periodic(Duration(milliseconds: gameSpeed), (timer) {
      updateGame();
    });
  }

  void pauseGame() {
    if (!isPlaying) return;
    
    setState(() {
      isPlaying = false;
    });
    
    timer?.cancel();
  }

  void restartGame() {
    timer?.cancel();
    setState(() {
      initGame();
    });
  }

  void updateGame() {
    if (!isPlaying) return;
    
    setState(() {
      // Move snake
      moveSnake();
      
      // Check for collisions
      if (checkCollision()) {
        endGame();
        return;
      }
      
      // Check if food eaten
      if (snake.first.x == food!.x && snake.first.y == food!.y) {
        score++;
        generateFood();
      } else {
        // Remove tail if no food eaten
        snake.removeLast();
      }
    });
  }

  void moveSnake() {
    // Add new head based on direction
    switch (direction) {
      case Direction.up:
        snake.insert(0, Point(snake.first.x, snake.first.y - 1));
        break;
      case Direction.right:
        snake.insert(0, Point(snake.first.x + 1, snake.first.y));
        break;
      case Direction.down:
        snake.insert(0, Point(snake.first.x, snake.first.y + 1));
        break;
      case Direction.left:
        snake.insert(0, Point(snake.first.x - 1, snake.first.y));
        break;
    }
  }

  bool checkCollision() {
    // Check wall collision
    if (snake.first.x < 0 || snake.first.x >= gridSize || 
        snake.first.y < 0 || snake.first.y >= gridSize) {
      return true;
    }
    
    // Check self collision (skip the head)
    for (int i = 1; i < snake.length; i++) {
      if (snake.first.x == snake[i].x && snake.first.y == snake[i].y) {
        return true;
      }
    }
    
    return false;
  }

  void generateFood() {
    Random random = Random();
    
    // Generate random coordinates
    int x, y;
    bool overlapping;
    
    do {
      overlapping = false;
      x = random.nextInt(gridSize);
      y = random.nextInt(gridSize);
      
      // Check if food overlaps with snake
      for (var point in snake) {
        if (point.x == x && point.y == y) {
          overlapping = true;
          break;
        }
      }
    } while (overlapping);
    
    food = Point(x, y);
  }

  void endGame() {
    timer?.cancel();
    setState(() {
      isPlaying = false;
    });
    
    // Show game over dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: primaryColor,
        title: Text(
          'GAME OVER',
          style: GoogleFonts.cinzel(
            textStyle: TextStyle(
              color: accentColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Final Score: $score',
              style: GoogleFonts.raleway(
                textStyle: TextStyle(
                  color: Colors.white.withAlpha(220),
                  fontSize: 18,
                ),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: accentColor,
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                restartGame();
              },
              child: Text('PLAY AGAIN'),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: accentColor.withAlpha(100),
            width: 1,
          ),
        ),
      ),
    );
  }

  void onDirectionChange(Direction newDirection) {
    // Prevent reversing direction
    if ((direction == Direction.up && newDirection == Direction.down) ||
        (direction == Direction.down && newDirection == Direction.up) ||
        (direction == Direction.left && newDirection == Direction.right) ||
        (direction == Direction.right && newDirection == Direction.left)) {
      return;
    }
    
    direction = newDirection;
  }

  @override
  Widget build(BuildContext context) {
    // Get screen size for responsive design
    final size = MediaQuery.of(context).size;
    
    // Calculate grid size based on screen width, with a maximum size
    final availableWidth = min(size.width * 0.9, 500.0);
    
    // Make grid slightly taller to have more vertical space
    final cellSize = availableWidth / gridSize;
    final gameWidth = cellSize * gridSize;
    final gameHeight = cellSize * (gridSize + 1); // Make grid slightly taller
    
    // Consistent spacing value to use throughout
    const double standardSpacing = 24.0;

    return Scaffold(
      backgroundColor: backgroundColor,
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
          'SERPENT RITUAL',
          style: GoogleFonts.cinzel(
            textStyle: TextStyle(
              color: accentColor, // Muted gold text
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
        iconTheme: IconThemeData(
          color: accentColor, // Gold icons
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            timer?.cancel();
            Navigator.of(context).pop();
          },
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Container(
            height: 1.0,
            color: accentColor.withAlpha(80), // Subtle gold divider
          ),
        ),
      ),
      // Make the entire screen swipable by applying GestureDetector to the body
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.delta.dy > 0 && direction != Direction.up) {
            onDirectionChange(Direction.down);
            if (!isPlaying) startGame();
          } else if (details.delta.dy < 0 && direction != Direction.down) {
            onDirectionChange(Direction.up);
            if (!isPlaying) startGame();
          }
        },
        onHorizontalDragUpdate: (details) {
          if (details.delta.dx > 0 && direction != Direction.left) {
            onDirectionChange(Direction.right);
            if (!isPlaying) startGame();
          } else if (details.delta.dx < 0 && direction != Direction.right) {
            onDirectionChange(Direction.left);
            if (!isPlaying) startGame();
          }
        },
        child: Container(
          decoration: BoxDecoration(
            // Background color
            color: backgroundColor,
            // Cherry blossom decorative element
            image: DecorationImage(
              image: AssetImage('assets/cherry_blossom.png'),
              opacity: 0.5,
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    // Consistent spacing from app bar to score
                    SizedBox(height: standardSpacing),
                    
                    // Score display
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 30),
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(200),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: accentColor.withAlpha(80),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        'SCORE: $score',
                        style: GoogleFonts.cinzel(
                          textStyle: TextStyle(
                            color: accentColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                    ),
                    
                    // Same spacing from score to grid
                    SizedBox(height: standardSpacing),
                    
                    // Game board - now taller
                    Container(
                      width: gameWidth,
                      height: gameHeight,
                      decoration: BoxDecoration(
                        color: primaryColor.withAlpha(180),
                        border: Border.all(
                          color: accentColor.withAlpha(100),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: CustomPaint(
                          painter: SnakePainter(
                            gridSize: gridSize,
                            cellSize: cellSize,
                            snake: snake,
                            food: food,
                            accentColor: accentColor,
                            complementaryColor: complementaryColor,
                          ),
                          size: Size(gameWidth, gameHeight),
                        ),
                      ),
                    ),
                    
                    // Same spacing from grid to button
                    SizedBox(height: standardSpacing),
                    
                    // Button and instructions container
                    Container(
                      padding: const EdgeInsets.only(bottom: standardSpacing),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Button or text based on game state
                          isPlaying
                              ? Text(
                                  'RITUAL IN PROGRESS',
                                  style: GoogleFonts.cinzel(
                                    textStyle: TextStyle(
                                      color: accentColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: startGame,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withAlpha(100),
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                      border: Border.all(
                                        color: accentColor.withAlpha(150),
                                        width: 1,
                                      ),
                                    ),
                                    child: Text(
                                      'BEGIN RITUAL',
                                      style: GoogleFonts.cinzel(
                                        textStyle: TextStyle(
                                          color: accentColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.5,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          
                          const SizedBox(height: 12),
                          
                          // Instructions text
                          Text(
                            'Swipe to guide the serpent',
                            style: GoogleFonts.raleway(
                              textStyle: TextStyle(
                                color: accentColor.withAlpha(150),
                                fontSize: 14,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    // Flexible spacer to push everything up slightly
                    Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Direction enum
enum Direction { up, right, down, left }

// Custom painter for the snake game
class SnakePainter extends CustomPainter {
  final int gridSize;
  final double cellSize;
  final List<Point> snake;
  final Point? food;
  final Color accentColor;
  final Color complementaryColor;

  SnakePainter({
    required this.gridSize,
    required this.cellSize,
    required this.snake,
    required this.food,
    required this.accentColor,
    required this.complementaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint gridPaint = Paint()
      ..color = Colors.grey.withAlpha(20)
      ..style = PaintingStyle.stroke;
      
    final Paint snakePaint = Paint()
      ..color = accentColor
      ..style = PaintingStyle.fill;
      
    final Paint snakeHeadPaint = Paint()
      ..color = accentColor
      ..style = PaintingStyle.fill;
      
    final Paint foodPaint = Paint()
      ..color = complementaryColor
      ..style = PaintingStyle.fill;
    
    // Draw grid (lighter and more subtle)
    for (int i = 0; i < gridSize; i++) {
      for (int j = 0; j < gridSize; j++) {
        canvas.drawRect(
          Rect.fromLTWH(i * cellSize, j * cellSize, cellSize, cellSize),
          gridPaint,
        );
      }
    }
    
    // Draw food with smaller size to stay inside the grid
    if (food != null) {
      canvas.drawRect(
        Rect.fromLTWH(
          food!.x * cellSize + 2, 
          food!.y * cellSize + 2, 
          cellSize - 4, 
          cellSize - 4
        ),
        foodPaint,
      );
    }
    
    // Draw snake body with smaller cells to stay inside the grid
    for (int i = 1; i < snake.length; i++) {
      canvas.drawRect(
        Rect.fromLTWH(
          snake[i].x * cellSize + 2, 
          snake[i].y * cellSize + 2, 
          cellSize - 4, 
          cellSize - 4
        ),
        snakePaint,
      );
    }
    
    // Draw snake head with smaller cells to stay inside the grid
    if (snake.isNotEmpty) {
      canvas.drawRect(
        Rect.fromLTWH(
          snake.first.x * cellSize + 2, 
          snake.first.y * cellSize + 2, 
          cellSize - 4, 
          cellSize - 4
        ),
        snakeHeadPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}