import 'package:flutter/material.dart';

class CommunityPage extends StatefulWidget {
  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  bool isClubsSelected = true; // Default selection for Clubs

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Blue AppBar with Title and Logo , design the base of the page 
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: Color(0xFF2C80E6),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 50,
                  left: MediaQuery.of(context).size.width / 2 - 25,
                  child: Image.asset(
                    'assets/images/orangelogoonly.png',
                    height: 50,
                  ),
                ),
                Positioned(
                  top: 110,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      "Community",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),




          // Tabs for Clubs and Workshops  i mean  the orange buttons to select the section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Clubs Button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isClubsSelected = true; // Switch to Clubs
                    });
                  },
                  child: Text(
                    'Clubs',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isClubsSelected ? Colors.orange : Colors.black,
                    ),
                  ),
                ),
                // Divider
                Text(
                  '|',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                // Workshops Button
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isClubsSelected = false; // Switch to Workshops
                    });
                  },
                  child: Text(
                    'Workshops',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: !isClubsSelected ? Colors.orange : Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          // Display Section Based on Selected Tab
          Expanded(
            child: isClubsSelected
                ? ClubsSection() // Show Clubs Section
                : WorkshopsSection(), // Show Workshops Section
          ),
        ],
      ),
    );
  }
}



// Clubs Section , numbers of cards
class ClubsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: 3, // Number of cards for Clubs
      itemBuilder: (context, index) {
        return Column(
          children: [
            // Card for Clubs
            ClubsCard(
              title: 'Clubs Card ${index + 1}',
            ),
            SizedBox(height: 16),
          ],
        );
      },
    );
  }
}



// Workshops Section , numbers of cards
class WorkshopsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemCount: 2, // Number of cards for Workshops
      itemBuilder: (context, index) {
        return Column(
          children: [
            // Card for Workshops
            WorkshopsCard(
              title: 'Workshops Card ${index + 1}',
            ),
            SizedBox(height: 16),
          ],
        );
      },
    );
  }
}



// Card Widget for Clubs
class ClubsCard extends StatefulWidget {
  final String title;

  const ClubsCard({required this.title});

  @override
  _ClubsCardState createState() => _ClubsCardState();
}

class _ClubsCardState extends State<ClubsCard> {
  bool isPending = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => ClubsDialog(
                      title: widget.title,
                      isPending: isPending,
                      onApplyPressed: (newState) {
                        setState(() {
                          isPending = newState; // Synchronize Pending state
                        });
                        Navigator.of(context).pop(); // Close the dialog
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isPending ? Colors.grey : Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  isPending ? 'Pending' : 'Learn More',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
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



// Card Widget for Workshops
class WorkshopsCard extends StatefulWidget {
  final String title;

  const WorkshopsCard({required this.title});

  @override
  _WorkshopsCardState createState() => _WorkshopsCardState();
}

class _WorkshopsCardState extends State<WorkshopsCard> {
  bool isPending = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              widget.title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => WorkshopsDialog(
                      title: widget.title,
                      isPending: isPending,
                      onApplyPressed: (newState) {
                        setState(() {
                          isPending = newState; // Synchronize Pending state
                        });
                        Navigator.of(context).pop(); // Close the dialog
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isPending ? Colors.grey : Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(
                  isPending ? 'Pending' : 'Learn More',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
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



// Dialog for Clubs
class ClubsDialog extends StatelessWidget {
  final String title;
  final bool isPending;
  final Function(bool) onApplyPressed;

  const ClubsDialog({
    required this.title,
    required this.isPending,
    required this.onApplyPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                // Apply Button
                ElevatedButton(
                  onPressed: isPending
                      ? null // Disable button when in Pending state
                      : () {
                          onApplyPressed(true); // Set to Pending
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isPending ? Colors.grey : Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    isPending ? 'Pending' : 'Apply',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          // Close Button
          Positioned(
            right: 0,
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}



// Dialog for Workshops
class WorkshopsDialog extends StatelessWidget {
  final String title;
  final bool isPending;
  final Function(bool) onApplyPressed;

  const WorkshopsDialog({
    required this.title,
    required this.isPending,
    required this.onApplyPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                // Apply Button
                ElevatedButton(
                  onPressed: isPending
                      ? null // Disable button when in Pending state
                      : () {
                          onApplyPressed(true); // Set to Pending
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isPending ? Colors.grey : Colors.orange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    isPending ? 'Pending' : 'Apply',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          // Close Button
          Positioned(
            right: 0,
            child: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}
