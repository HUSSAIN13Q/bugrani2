import 'package:bugrani2/providers/inbox_provider.dart';
import 'package:bugrani2/sign_in/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// class InboxPage extends StatefulWidget {
//   @override
//   _InboxPageState createState() => _InboxPageState();
// }

// class _InboxPageState extends State<InboxPage> {
//   // Default selection for Clubs

//   @override
//   void initState() {
//     super.initState();
//     // Fetch myworkshops when the page is initialized
//     Provider.of<MyWorkshopProvider>(context, listen: false).getMyWorkshop();
//   }

//   @override
//   Widget build(BuildContext context) {
//     context.read<AuthProvider>().initAuth();
//     return Scaffold(
//       body: Column(
//         children: [
//           // Blue AppBar with Title and Logo , design the base of the page
//           Stack(
//             children: [
//               Container(
//                 height: 150, // Reduced the height of the blue container
//                 decoration: const BoxDecoration(
//                   color: Color(0xFF2C80E6),
//                   borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(40),
//                     bottomRight: Radius.circular(40),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 top: 50,
//                 left: MediaQuery.of(context).size.width / 2 - 25,
//                 child: Image.asset(
//                   'assets/images/orangelogoonly.png',
//                   height: 50,
//                 ),
//               ),
//               const Positioned(
//                 top: 110,
//                 left: 0,
//                 right: 0,
//                 child: Center(
//                   child: Text(
//                     "Inbox",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 16),
//           // Tabs for Clubs and Workshops
//           // Tabs for Clubs and Workshops  i mean  the orange buttons to select the section

//           SizedBox(height: 16),
//           // Display Section Based on Selected Tab
//         ],
//       ),
//     );
//   }
// }

// // Clubs Section (Empty for now)

// // Workshops Section
// class MyWorkshopsSection extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     context.read<AuthProvider>().initAuth();
//     return Consumer<MyWorkshopProvider>(
//       builder: (context, myworkshopProvider, child) {
//         if (myworkshopProvider.isLoading) {
//           return Center(child: CircularProgressIndicator());
//         }

//         if (myworkshopProvider.errorMessage != null) {
//           return Center(child: Text(myworkshopProvider.errorMessage!));
//         }

//         if (myworkshopProvider.myworkshops.isEmpty) {
//           return Center(child: Text('No myworkshops available.'));
//         }

//         return ListView.builder(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           itemCount: myworkshopProvider.myworkshops.length,
//           itemBuilder: (context, index) {
//             final myworkshop = myworkshopProvider.myworkshops[index];
//             return Column(
//               children: [
//                 MyWorkshopsCard(
//                   title: myworkshop.title,
//                   date: myworkshop.date,
//                   description: myworkshop.description,
//                 ),
//                 const SizedBox(height: 16),
//               ],
//             );
//           },
//         );
//       },
//     );
//   }
// }

// // Card Widget for Workshops
// class MyWorkshopsCard extends StatelessWidget {
//   final String title;
//   final String date;
//   final String description;

//   const MyWorkshopsCard({
//     required this.title,
//     required this.date,
//     required this.description,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 180,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 2,
//             blurRadius: 5,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Title: $title',
//                     style: TextStyle(fontWeight: FontWeight.bold)),
//                 const SizedBox(height: 8),
//                 Text('Date: $date'),
//                 const SizedBox(height: 8),
//                 Text('Description: $description'),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:bugrani2/providers/inbox_provider.dart';
import 'package:bugrani2/sign_in/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InboxPage extends StatefulWidget {
  @override
  _InboxPageState createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  // Default selection for Clubs

  @override
  void initState() {
    super.initState();
    // Fetch myworkshops when the page is initialized
    Provider.of<MyWorkshopProvider>(context, listen: false).getMyWorkshop();
  }

  @override
  Widget build(BuildContext context) {
    context.read<AuthProvider>().initAuth();
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
              const Positioned(
                top: 110,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    "Inbox",
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
          // Tabs for Clubs and Workshops
          // Tabs for Clubs and Workshops  i mean  the orange buttons to select the section

          SizedBox(height: 16),
          // Display Section Based on Selected Tab
          Expanded(
            child: MyWorkshopsSection(), // Ensure this widget is displayed
          ),
        ],
      ),
    );
  }
}

// Clubs Section (Empty for now)

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
                  date: myworkshop.date,
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
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
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
        ],
      ),
    );
  }
}
