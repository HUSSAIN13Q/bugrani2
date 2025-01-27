import 'package:bugrani2/providers/inbox_provider.dart';
import 'package:bugrani2/providers/search_provider.dart';
import 'package:bugrani2/sign_in/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class InboxPage extends StatefulWidget {
  @override
  _InboxPageState createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    // Fetch myworkshops when the page is initialized
    Provider.of<MyWorkshopProvider>(context, listen: false).getMyWorkshop();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<AuthProvider>().initAuth();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Blue AppBar with Title and Logo , design the base of the page
          _buildAppBar(context, "Inbox"),
          const SizedBox(height: 16),
          // Title for Searching on Employees with Icon
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Icon(
                  Icons.search, // Icon representing search
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                SizedBox(width: 8),
                Text(
                  "Searching on Employees",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9, // Smaller width
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search employees...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0), // Rounded corners
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                ),
                onSubmitted: (query) {
                  Provider.of<SearchProvider>(context, listen: false)
                      .searchEmployees(query);
                },
              ),
            ),
          ),
          // Search Results
          Expanded(
            child: Consumer<SearchProvider>(
              builder: (context, searchProvider, child) {
                if (searchProvider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                if (searchProvider.searchResults.isEmpty) {
                  return Center(child: Text('Search to Employees'));
                }

                return ListView.builder(
                  itemCount: searchProvider.searchResults.length,
                  itemBuilder: (context, index) {
                    final employee = searchProvider.searchResults[index];
                    return ListTile(
                      title: Text(employee['name']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(employee['email']),
                          Text(employee['title']), // Display the title from the database
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: 5),
          // Title for My Certificates with Icon
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Icon(
                  Icons.school, // Icon representing certificates
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
                SizedBox(width: 8),
                Text(
                  "My Certificates",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Display Section Based on Selected Tab
          Expanded(
            child: MyWorkshopsSection(), // Ensure this widget is displayed
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
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
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

// Workshops Section
class MyWorkshopsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<AuthProvider>().initAuth();
    return Consumer<MyWorkshopProvider>(
      builder: (context, myworkshopProvider, child) {
        if (myworkshopProvider.isLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (myworkshopProvider.errorMessage != null) {
          return Center(child: Text(myworkshopProvider.errorMessage!));
        }

        if (myworkshopProvider.myworkshops.isEmpty) {
          return Center(child: Text('No myworkshops available.'));
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          itemCount: myworkshopProvider.myworkshops.length,
          itemBuilder: (context, index) {
            final myworkshop = myworkshopProvider.myworkshops[index];
            return Column(
              children: [
                MyWorkshopsCard(
                  title: myworkshop.title,
                  date: DateFormat('yyyy-MM-dd').format(DateTime.parse(myworkshop.date)),
                  description: myworkshop.description,
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
class MyWorkshopsCard extends StatelessWidget {
  final String title;
  final String date;
  final String description;

  const MyWorkshopsCard({
    required this.title,
    required this.date,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20), // Increased corner radius
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2C80E6), // Blue color for the title
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Black color for the date
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.description, // Document icon
            color: Colors.orange,
            size: 30,
          ),
        ],
      ),
    );
  }
}
