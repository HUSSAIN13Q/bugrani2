import 'package:flutter/material.dart';

class MapSection extends StatefulWidget {
  @override
  _MapSectionState createState() => _MapSectionState();
}

class _MapSectionState extends State<MapSection> {
  bool showAllFloors = false;

  @override
  Widget build(BuildContext context) {
    final floorButtons = [
      FloorMapButton(
        title: 'Ground Floor Map',
        onPressed: () => _openFloorPage(context, 'Ground Floor Map'),
      ),
      Divider(),
      FloorMapButton(
        title: 'First Floor Map',
        onPressed: () => _openFloorPage(context, 'First Floor Map'),
      ),
      Divider(),
      FloorMapButton(
        title: 'Second Floor Map',
        onPressed: () => _openFloorPage(context, 'Second Floor Map'),
      ),
      Divider(),
    ];

    if (showAllFloors) {
      floorButtons.addAll([
        FloorMapButton(
          title: 'Third Floor Map',
          onPressed: () => _openFloorPage(context, 'Third Floor Map'),
        ),
        Divider(),
        FloorMapButton(
          title: 'Fourth Floor Map',
          onPressed: () => _openFloorPage(context, 'Fourth Floor Map'),
        ),
        Divider(),
        FloorMapButton(
          title: 'Fifth Floor Map',
          onPressed: () => _openFloorPage(context, 'Fifth Floor Map'),
        ),
        Divider(),
        FloorMapButton(
          title: 'Sixth Floor Map',
          onPressed: () => _openFloorPage(context, 'Sixth Floor Map'),
        ),
        Divider(),
        FloorMapButton(
          title: 'Seventh Floor Map',
          onPressed: () => _openFloorPage(context, 'Seventh Floor Map'),
        ),
        Divider(),
        FloorMapButton(
          title: 'Eighth Floor Map',
          onPressed: () => _openFloorPage(context, 'Eighth Floor Map'),
        ),
        Divider(),
      ]);
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 50,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                ...floorButtons,
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showAllFloors = !showAllFloors;
                    });
                  },
                  child: Icon(
                    showAllFloors
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    size: 24,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _openFloorPage(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FloorPage(
          title: title,
        ),
      ),
    );
  }
}

class FloorMapButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const FloorMapButton({required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: GestureDetector(
        onTap: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.blue,
              ),
            ),
            Icon(Icons.arrow_forward, color: Colors.blue, size: 24),
          ],
        ),
      ),
    );
  }
}

class FloorPage extends StatelessWidget {
  final String title;

  const FloorPage({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Blue AppBar with Logo and Title
          Stack(
            children: [
              Container(
                height: 150, // Reduced the height of the blue container
                decoration: BoxDecoration(
                  color: Color(0xFF2C80E6),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 16,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Positioned(
                top: 50,
                left: MediaQuery.of(context).size.width / 2 - 25,
                child: Image.asset(
                  'assets/images/orangelogoonly.png',
                  height: 50,
                ),
              ),
              Positioned(
                top: 100,
                left: MediaQuery.of(context).size.width / 2 - 80,
                child: Text(
                  "Head Office Map",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          // Ground Floor Map Title
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),

          // Map Image Container
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Image.asset(
                    'assets/images/floor_map_placeholder.png', // Replace with actual map
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
