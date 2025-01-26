import 'package:bugrani2/providers/clubs_provider.dart';
import 'package:bugrani2/sign_in/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClubsInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<AuthProvider>().initAuth();
    context.read<ClubsProvider>().getClubs();

    return Scaffold(
      body: Column(
        children: [
          // Blue AppBar with Title and Logo , design the base of the page
          Stack(
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
                    "Club Inbox",
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
          const SizedBox(height: 16),
          Expanded(
            child: Consumer<ClubsProvider>(
              builder: (context, clubsProvider, child) {
                if (clubsProvider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                if (clubsProvider.errorMessage != null) {
                  return Center(child: Text(clubsProvider.errorMessage!));
                }

                if (clubsProvider.clubs.isEmpty) {
                  return Center(child: Text('No applied clubs available.'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  itemCount: clubsProvider.clubs.length,
                  itemBuilder: (context, index) {
                    final club = clubsProvider.clubs[index];
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
            ),
          ),
        ],
      ),
    );
  }
}

class ClubsCard extends StatelessWidget {
  final String id;
  final String title;
  final String description;

  const ClubsCard({
    required this.id,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
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
                Text('Description: $description'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
