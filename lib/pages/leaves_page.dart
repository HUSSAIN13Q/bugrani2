import 'package:flutter/material.dart';

class LeavesPage extends StatefulWidget {
  @override
  _LeavesPageState createState() => _LeavesPageState();
}

class _LeavesPageState extends State<LeavesPage> {
  String selectedLeaveType = 'Choose Your Leave Type';
  final List<String> leaveTypes = [
    'Choose Your Leave Type',
    'Sick Leave',
    'Annual Leave',
    'Casual Leave',
    'Maternity Leave',
    'Paternity Leave',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Blue AppBar with Title and Logo
          Stack(
            children: [
              Container(
                height: 450, // Reduced the height of the blue container
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
                      icon:
                          const Icon(Icons.arrow_downward, color: Colors.black),
                      iconSize: 24,
                      elevation: 16,
                      dropdownColor: Colors.white,
                      style: const TextStyle(color: Colors.black, fontSize: 18),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                "Sick Leave",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily:
                                      'YourFontFamily', // Replace with your font family
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Used",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily:
                                      'YourFontFamily', // Replace with your font family
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Remaining",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily:
                                      'YourFontFamily', // Replace with your font family
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                "Annual Leave",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontFamily:
                                      'YourFontFamily', // Replace with your font family
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Used",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily:
                                      'YourFontFamily', // Replace with your font family
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                "Remaining",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily:
                                      'YourFontFamily', // Replace with your font family
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Add other widgets or content here as needed
        ],
      ),
    );
  }
}
