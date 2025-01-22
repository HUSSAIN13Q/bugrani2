import 'package:bugrani2/providers/workshop_provider.dart';
import 'package:bugrani2/sign_in/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommunityPage extends StatefulWidget {
  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  @override
  void initState() {
    super.initState();
    // Fetch workshops when the page is initialized
    // await
  }

  @override
  Widget build(BuildContext context) {
    context.read<AuthProvider>().initAuth();
    return Scaffold(
      body: Column(
        children: [
          // Blue AppBar with Title and Logo , design the base of the page
          Container(
            height: 150,
            decoration: const BoxDecoration(
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
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Display Workshops
          Expanded(
            child: WorkshopsSection(),
          ),
        ],
      ),
    );
  }
}

// Workshops Section
class WorkshopsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future:
            Provider.of<WorkshopProvider>(context, listen: false).getWorkshop(),
        builder: (context, datasnapshot) {
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
        });
  }
}

// Card Widget for Workshops
class WorkshopsCard extends StatelessWidget {
  final String title;
  final String date;
  final String description;

  const WorkshopsCard({
    required this.title,
    required this.date,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
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
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  // Handle Apply button press
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
          ),
        ],
      ),
    );
  }
}
