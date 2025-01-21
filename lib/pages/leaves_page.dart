// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:intl/intl.dart';
// import 'package:bugrani2/providers/leaves_provider.dart';

// class LeavesPage extends StatefulWidget {
//   const LeavesPage({super.key});

//   @override
//   _LeavesPageState createState() => _LeavesPageState();
// }

// class _LeavesPageState extends State<LeavesPage> {
//   String selectedLeaveType = 'Choose Your Leave Type';
//   final List<String> leaveTypes = [
//     'Choose Your Leave Type',
//     'Sick Leave',
//     'Annual Leave',
//   ];

//   final TextEditingController startDateController = TextEditingController();
//   final TextEditingController endDateController = TextEditingController();
//   final TextEditingController descriptionController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             // Blue AppBar with Title and Logo
//             Stack(
//               children: [
//                 Container(
//                   height: 450, // Reduced the height of the blue container
//                   decoration: const BoxDecoration(
//                     color: Color(0xFF2C80E6),
//                     borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(40),
//                       bottomRight: Radius.circular(40),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 50,
//                   left: MediaQuery.of(context).size.width / 2 - 25,
//                   child: Image.asset(
//                     'assets/images/orangelogoonly.png',
//                     height: 50,
//                   ),
//                 ),
//                 Positioned(
//                   top: 110,
//                   left: 0,
//                   right: 0,
//                   child: Center(
//                     child: Text(
//                       "Leaves",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 22,
//                         fontFamily:
//                             'YourFontFamily', // Replace with your font family
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 150,
//                   left: 16,
//                   right: 16,
//                   child: Card(
//                     color: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 16.0, vertical: 8.0),
//                       child: DropdownButton<String>(
//                         value: selectedLeaveType,
//                         icon: const Icon(Icons.arrow_downward,
//                             color: Colors.black),
//                         iconSize: 24,
//                         elevation: 16,
//                         dropdownColor: Colors.white,
//                         style:
//                             const TextStyle(color: Colors.black, fontSize: 18),
//                         underline: Container(
//                           height: 0,
//                           color: Colors.transparent,
//                         ),
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             selectedLeaveType = newValue!;
//                           });
//                         },
//                         items: leaveTypes
//                             .map<DropdownMenuItem<String>>((String value) {
//                           return DropdownMenuItem<String>(
//                             value: value,
//                             child: Text(value),
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 250,
//                   left: 16,
//                   right: 16,
//                   child: Column(
//                     children: [
//                       TextField(
//                         controller: startDateController,
//                         decoration: InputDecoration(
//                           labelText: 'Start Date',
//                           filled: true,
//                           fillColor: Colors.white,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                         ),
//                         onTap: () async {
//                           DateTime? pickedDate = await showDatePicker(
//                             context: context,
//                             initialDate: DateTime.now(),
//                             firstDate: DateTime(2000),
//                             lastDate: DateTime(2101),
//                           );
//                           if (pickedDate != null) {
//                             setState(() {
//                               startDateController.text =
//                                   DateFormat('yyyy-MM-dd').format(pickedDate);
//                             });
//                           }
//                         },
//                       ),
//                       const SizedBox(height: 16),
//                       TextField(
//                         controller: endDateController,
//                         decoration: InputDecoration(
//                           labelText: 'End Date',
//                           filled: true,
//                           fillColor: Colors.white,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                         ),
//                         onTap: () async {
//                           DateTime? pickedDate = await showDatePicker(
//                             context: context,
//                             initialDate: DateTime.now(),
//                             firstDate: DateTime(2000),
//                             lastDate: DateTime(2101),
//                           );
//                           if (pickedDate != null) {
//                             setState(() {
//                               endDateController.text =
//                                   DateFormat('yyyy-MM-dd').format(pickedDate);
//                             });
//                           }
//                         },
//                       ),
//                       const SizedBox(height: 16),
//                       TextField(
//                         controller: descriptionController,
//                         decoration: InputDecoration(
//                           labelText: 'Description',
//                           filled: true,
//                           fillColor: Colors.white,
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       ElevatedButton(
//                         onPressed: () async {
//                           if (selectedLeaveType != 'Choose Your Leave Type' &&
//                               startDateController.text.isNotEmpty &&
//                               endDateController.text.isNotEmpty &&
//                               descriptionController.text.isNotEmpty) {
//                             DateFormat dateFormat = DateFormat('yyyy-MM-dd');
//                             await Provider.of<LeavesProvider>(context,
//                                     listen: false)
//                                 .submitLeave(
//                               type: selectedLeaveType,
//                               startDate: dateFormat.format(
//                                   DateTime.parse(startDateController.text)),
//                               endDate: dateFormat.format(
//                                   DateTime.parse(endDateController.text)),
//                               description: descriptionController.text,
//                             );
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                   content: Text(
//                                       'Leave request submitted successfully')),
//                             );
//                           } else {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                   content: Text('Please fill all fields')),
//                             );
//                           }
//                         },
//                         child: const Text('Submit Leave Request'),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:bugrani2/sign_in/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:bugrani2/providers/leaves_provider.dart';

class LeavesPage extends StatefulWidget {
  const LeavesPage({super.key});

  @override
  _LeavesPageState createState() => _LeavesPageState();
}

class _LeavesPageState extends State<LeavesPage> {
  String selectedLeaveType = 'Choose Your Leave Type';
  final List<String> leaveTypes = [
    'Choose Your Leave Type',
    'Sick',
    'Annual',
  ];

  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    context.read<AuthProvider>().initAuth();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Blue AppBar with Title and Logo
            Stack(
              children: [
                Container(
                  height: 550, // Reduced the height of the blue container
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
                      "Leaves",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontFamily:
                            'YourFontFamily', // Replace with your font family
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 150,
                  left: 16,
                  right: 16,
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: DropdownButton<String>(
                        value: selectedLeaveType,
                        icon: const Icon(Icons.arrow_downward,
                            color: Colors.black),
                        iconSize: 24,
                        elevation: 16,
                        dropdownColor: Colors.white,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        underline: Container(
                          height: 0,
                          color: Colors.transparent,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedLeaveType = newValue!;
                          });
                        },
                        items: leaveTypes
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 250,
                  left: 16,
                  right: 16,
                  child: Column(
                    children: [
                      TextField(
                        controller: startDateController,
                        decoration: InputDecoration(
                          labelText: 'Start Date',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              startDateController.text =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: endDateController,
                        decoration: InputDecoration(
                          labelText: 'End Date',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              endDateController.text =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          if (selectedLeaveType != 'Choose Your Leave Type' &&
                              startDateController.text.isNotEmpty &&
                              endDateController.text.isNotEmpty &&
                              descriptionController.text.isNotEmpty) {
                            await Provider.of<LeavesProvider>(context,
                                    listen: false)
                                .submitLeave(
                              type: selectedLeaveType,
                              startDate: startDateController.text,
                              endDate: endDateController.text,
                              description: descriptionController.text,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Leave request submitted successfully')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Please fill all fields')),
                            );
                          }
                        },
                        child: const Text('Submit Leave Request'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
