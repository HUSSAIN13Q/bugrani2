import 'package:bugrani2/providers/clubs_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ClubsInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<ClubsProvider>().getClubs();

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Blue AppBar with Title and Logo
          Stack(
            children: [
              Container(
                height: 150,
                decoration: const BoxDecoration(
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
                top: 40,
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
                    "Clubs Inbox",
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
                          onAnnouncementTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AnnouncementChatPage(
                                  clubTitle: club.title,
                                ),
                              ),
                            );
                          },
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

class ClubsCard extends StatefulWidget {
  final String id;
  final String title;
  final String description;
  final VoidCallback onAnnouncementTap;

  const ClubsCard({
    required this.id,
    required this.title,
    required this.description,
    required this.onAnnouncementTap,
  });

  @override
  _ClubsCardState createState() => _ClubsCardState();
}

class _ClubsCardState extends State<ClubsCard> {
  bool isAlertActive = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Title: ${widget.title}', style: TextStyle(fontWeight: FontWeight.bold)),
              IconButton(
                icon: Icon(
                  isAlertActive ? Icons.notifications_active : Icons.notifications_off,
                  color: Colors.orange,
                ),
                onPressed: () {
                  setState(() {
                    isAlertActive = !isAlertActive;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text('Description: ${widget.description}'),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: widget.onAnnouncementTap,
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.campaign, color: Colors.blue, size: 30),
                      SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Announcement',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Admin: All the players will be invited...',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '03/01/2025',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Icon(Icons.push_pin, color: Colors.orange, size: 20),
                    ],
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

class AnnouncementChatPage extends StatelessWidget {
  final String clubTitle;

  const AnnouncementChatPage({Key? key, required this.clubTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Blue AppBar with Title and Logo
          Stack(
            children: [
              Container(
                height: 150,
                decoration: const BoxDecoration(
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
                top: 40,
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
                    "$clubTitle Announcements",
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
            child: ListView(
              padding: EdgeInsets.all(16.0),
              children: [
                AnnouncementBubble(
                  date: '1/Jan/2025',
                  sender: 'Ghanim Alhashash',
                  role: 'Community admin',
                  message:
                      'Today the location on the Sulaibkhat court is at 5:30 PM. All make sure to be there before time.',
                ),
                AnnouncementBubble(
                  date: '1/Jan/2025',
                  sender: 'Hamad Almatoq',
                  role: 'Community admin',
                  message:
                      'Please all the members need to do this survey. The deadline is midnight today. Thanks all. http://footballsurvey.com',
                ),
                AnnouncementBubble(
                  date: '4/Jan/2025',
                  sender: 'Hamad Almatoq',
                  role: 'Community admin',
                  message:
                      'You are all invited to present the Khaleeji Zain to support the Kuwait team. Please fill out your info in this link to take your ticket. http://Burgan.khalejezain.com',
                ),
                AnnouncementBubble(
                  date: '5/Jan/2025',
                  sender: 'Ghanim Alhashash',
                  role: 'Community admin',
                  message:
                      'Reminder: Training session tomorrow at 6:00 PM. Don\'t forget to bring your gear.',
                ),
                AnnouncementBubble(
                  date: '6/Jan/2025',
                  sender: 'Hamad Almatoq',
                  role: 'Community admin',
                  message:
                      'Team meeting on Friday at 4:00 PM. Please be on time. http://teammeeting.com',
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[300],
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Only admins can type messages.',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AnnouncementBubble extends StatelessWidget {
  final String date;
  final String sender;
  final String role;
  final String message;

  const AnnouncementBubble({
    required this.date,
    required this.sender,
    required this.role,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          date,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(40),
              bottomRight: Radius.circular(30),
            ),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                blurRadius: 30,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                sender,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(
                role,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              _buildMessageWithLinks(message),
            ],
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildMessageWithLinks(String message) {
    final words = message.split(' ');
    return Wrap(
      children: words.map((word) {
        if (word.startsWith('http')) {
          return Text(
            word,
            style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
          );
        } else {
          return Text('$word ');
        }
      }).toList(),
    );
  }
}