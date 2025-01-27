import 'package:bugrani2/providers/clubs_provider.dart';
import 'package:bugrani2/providers/workshop_provider.dart';
import 'package:bugrani2/services/clubs_services.dart';
import 'package:bugrani2/services/workshop_services.dart';
import 'package:bugrani2/sign_in/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bugrani2/pages/clubsInfo_page.dart';
import 'package:bugrani2/models/club.dart';

class CommunityPage extends StatefulWidget {
  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  bool isClubsSelected = true; // Default selection for Clubs

  @override
  void initState() {
    super.initState();
    // Fetch workshops when the page is initialized
    Provider.of<WorkshopProvider>(context, listen: false).getWorkshop();
    Provider.of<ClubsProvider>(context, listen: false).getClubs();
  }

  @override
  Widget build(BuildContext context) {
    context.read<AuthProvider>().initAuth();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Blue AppBar with Title and Logo , design the base of the page
          _buildAppBar(context, "Community"),
          const SizedBox(height: 16),
          // Tabs for Clubs and Workshops
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
                  '     |',
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

  Widget _buildAppBar(BuildContext context, String title) {
    return Stack(
      children: [
        Container(
          height: 150, // Reduced the height of the blue container
          decoration: const BoxDecoration(
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
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Clubs Section
class ClubsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ClubsProvider>(
      builder: (context, clubProvider, child) {
        if (clubProvider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (clubProvider.errorMessage != null) {
          return Center(child: Text(clubProvider.errorMessage!));
        }

        if (clubProvider.clubs.isEmpty) {
          return Center(child: Text('No clubs available.'));
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          itemCount: clubProvider.clubs.length,
          itemBuilder: (context, index) {
            final club = clubProvider.clubs[index];
            return Column(
              children: [
                ClubsCard(
                  id: club.id,
                  title: club.title,
                  description: club.description,
                ),
                const SizedBox(height: 16),
              ],
            );
          },
        );
      },
    );
  }
}

// Workshops Section
class WorkshopsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<WorkshopProvider>(
      builder: (context, workshopProvider, child) {
        if (workshopProvider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (workshopProvider.errorMessage != null) {
          return Center(child: Text(workshopProvider.errorMessage!));
        }

        if (workshopProvider.workshops.isEmpty) {
          return Center(child: Text('No workshops available.'));
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          itemCount: workshopProvider.workshops.length,
          itemBuilder: (context, index) {
            final workshop = workshopProvider.workshops[index];
            return Column(
              children: [
                WorkshopsCard(
                  id: workshop.id,
                  title: workshop.title,
                  date: workshop.date,
                  description: workshop.description,
                ),
                const SizedBox(height: 16),
              ],
            );
          },
        );
      },
    );
  }
}

// Card Widget for Workshops
class WorkshopsCard extends StatelessWidget {
  final String id;
  final String title;
  final String date;
  final String description;

  const WorkshopsCard({
    required this.id,
    required this.title,
    required this.date,
    required this.description,
  });

  String _getImageByTitle(String title) {
    switch (title) {
      case 'Digital Banking Workshop':
        return 'assets/images/digitalbanking.jpg';
      case 'Financial Literacy Workshop':
        return 'assets/images/financialliteracy.png';
      case 'Investment Workshop':
        return 'assets/images/investment.png';
      case 'Leadership Workshop':
        return 'assets/images/leadership.jpg';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final imagePath = _getImageByTitle(title);

    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          if (imagePath.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              child: Image.asset(
                imagePath,
                width: 180, // Increased width
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Title: $title',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Date: $date'),
                  const SizedBox(height: 8),
                  Text('Description: $description'),
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () async {
                        // Handle Apply button press
                        try {
                          final response =
                              await WorkshopService().applyForWorkshop(id);
                          if (response['error'] != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(response['error'])),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('Applied for workshop successfully')),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text('Failed to apply for workshop')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Apply',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Card Widget for Clubs
class ClubsCard extends StatelessWidget {
  final String id;
  final String title;
  final String description;

  const ClubsCard({
    required this.id,
    required this.title,
    required this.description,
  });

  String _getImageByTitle(String title) {
    switch (title) {
      case 'Art Club':
        return 'assets/images/artclub.jpeg';
      case 'Book Club':
        return 'assets/images/bookclub.jpg';
      case 'knitting Club':
        return 'assets/images/knittingclub.jpeg';
      case 'Football Club':
        return 'assets/images/footballclub.jpeg';
      case 'Popculture Club':
        return 'assets/images/popculture.jpg';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final imagePath = _getImageByTitle(title);

    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          if (imagePath.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              child: Image.asset(
                imagePath,
                width: 180, // Increased width
                height: 180,
                fit: BoxFit.cover,
              ),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Title: $title',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('Description: $description'),
                  Spacer(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                      onPressed: () async {
                        // Handle Apply button press
                        try {
                          final response =
                              await ClubsService().applyForClub(id);
                          if (response['error'] != null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(response['error'])),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('Applied for club successfully')),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text('Failed to apply for club')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Apply',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
