import 'package:flutter/material.dart';

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set screen background to white
      body: Column(
        children: [
          // Blue AppBar with Title and Logo
          Stack(
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
                top: 50,
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
                    "News",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // News Content
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                // Today's News Section
                Text(
                  "Today,",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 16),
                NewsCard(
                  title: "Burgan Support AUK",
                  description:
                      "Burgan Bank continues to support local talent development at AUK's Career Growth Fair",
                  imagePath: 'images/auk.webp',
                ),
                SizedBox(height: 24),

                // Yesterday's News Section
                Text(
                  "Yesterday,",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 16),
                NewsCard(
                  title: "Cyber Security Conference Concludes",
                  description:
                      "Cyber Security Conference organized by Burgan Bank concludes successfully.",
                  imagePath: 'images/cybernew.jpeg',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Widget for News Card
class NewsCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const NewsCard({
    Key? key,
    required this.title,
    required this.description,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              title,
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
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover, // Ensures the image is zoomed in
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
