import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set screen background to white
      body: Column(
        children: [
          // Blue AppBar with Title and Logo
          _buildAppBar(context, "News"),
          // News Content
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: newsData.length,
              itemBuilder: (context, index) {
                return AnimatedNewsCard(
                  title: newsData[index]['title']!,
                  description: newsData[index]['description']!,
                  imagePath: newsData[index]['imagePath']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, String title) {
    return Stack(
      children: [
        Container(
          height: 150,
          decoration: BoxDecoration(
            color: Color(0xFF2C80E6),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
        ),
        Positioned(
          top: 40, // Moved up
          left: MediaQuery.of(context).size.width / 2 - 25,
          child: Image.asset(
            'assets/images/orangelogoonly.png', // Replace with your logo path
            height: 50,
          ),
        ),
        Positioned(
          top: 110,
          left: 0,
          right: 0,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

const newsData = [
  {
    'title': "NEXUS 2024",
    'description': "Burgan Bank concludes its sponsorship of NEXUS 2024...the largest event in the field of technology and innovation in Kuwait",
    'imagePath': 'images/news3.jpg',
  },
  {
    'title': "Burgan Support AUK",
    'description': "Burgan Bank continues to support local talent development at AUK's Career Growth Fair",
    'imagePath': 'images/auk.webp',
  },
  {
    'title': "Cyber Security Conference Concludes",
    'description': "Cyber Security Conference organized by Burgan Bank concludes successfully.",
    'imagePath': 'images/cybernew.jpeg',
  },
];

class AnimatedNewsCard extends StatefulWidget {
  final String title;
  final String description;
  final String imagePath;

  const AnimatedNewsCard({
    Key? key,
    required this.title,
    required this.description,
    required this.imagePath,
  }) : super(key: key);

  @override
  _AnimatedNewsCardState createState() => _AnimatedNewsCardState();
}

class _AnimatedNewsCardState extends State<AnimatedNewsCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHover(PointerEvent details) {
    _controller.forward();
  }

  void _onExit(PointerEvent details) {
    _controller.reverse();
  }

  void _onTap() {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _onHover,
      onExit: _onExit,
      child: GestureDetector(
        onTap: _onTap,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _animation.value,
              child: child,
            );
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 16.0), // Add space between cards
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8), // Shadow color
                  blurRadius: 30, // Shadow blur radius
                  offset: Offset(0, 4), // Shadow offset
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    height: 250, // Increased height
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(widget.imagePath),
                        fit: BoxFit.cover, // Ensures the image is zoomed in
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    widget.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
