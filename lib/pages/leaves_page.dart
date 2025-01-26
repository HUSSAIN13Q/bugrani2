import 'package:bugrani2/models/leave.dart';
import 'package:bugrani2/sign_in/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bugrani2/providers/leaves_provider.dart';
import 'package:file_picker/file_picker.dart';


class LeavesPage extends StatefulWidget {
  @override
  _LeavesPageState createState() => _LeavesPageState();
}

class _LeavesPageState extends State<LeavesPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    // Fetch leave balance and leaves only once
    final leavesProvider = Provider.of<LeavesProvider>(context, listen: false);
    leavesProvider.getLeaveBalance();
    leavesProvider.getLeaves();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF2C80E6),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Image.asset(
          'assets/images/orangelogoonly.png',
          height: 50,
        ),
      ),
      body: Column(
        children: [
          // Header Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFF2C80E6),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 16),
                Text(
                  "Managing Leaves",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LeaveFormPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: Size(double.infinity, 50),
                    maximumSize: Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Submit Your Leave',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                // Leave Stats
                Consumer<LeavesProvider>(
                  builder: (context, leavesProvider, child) {
                    if (leavesProvider.leaveBalance == null) {
                      return CircularProgressIndicator();
                    } else {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _leaveStatCard(
                            context,
                            "Sick Leave",
                            leavesProvider.leaveBalance!.sickUsed.toString(),
                            (leavesProvider.leaveBalance!.sickEntitlement -
                                    leavesProvider.leaveBalance!.sickUsed)
                                .toString(),
                          ),
                          _leaveStatCard(
                            context,
                            "Annual Leave",
                            leavesProvider.leaveBalance!.annualUsed.toString(),
                            (leavesProvider.leaveBalance!.annualEntitlement -
                                    leavesProvider.leaveBalance!.annualUsed)
                                .toString(),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          // Previous Leave Details Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(Icons.document_scanner_outlined, color: Colors.black),
                SizedBox(width: 8),
                Text(
                  "Previous Applied Leave Details",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          // Placeholder for leave details (Empty for Backend Data)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                elevation: 15,
                shadowColor: Colors.black.withOpacity(1.0),
                child: Column(
                  children: [
                    TabBar(
                      controller: _tabController,
                      tabs: [
                        Tab(text: "Pending"),
                        Tab(text: "Approved"),
                        Tab(text: "Rejected"),
                      ],
                      labelColor: Colors.blue, // Color for selected tab
                      unselectedLabelColor: Colors.black, // Color for unselected tabs
                      indicatorColor: Colors.blue, // Color for the underline
                      indicatorWeight: 3.0, // Thickness of the underline
                    ),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        padding: const EdgeInsets.all(16.0),
                        child: Consumer<LeavesProvider>(
                          builder: (context, leavesProvider, child) {
                            if (leavesProvider.isLoading) {
                              return Center(child: CircularProgressIndicator());
                            } else if (leavesProvider.leaves.isEmpty) {
                              return Center(
                                child: Text(
                                  "No leave data available",
                                  style: TextStyle(fontSize: 16, color: Colors.grey),
                                ),
                              );
                            } else {
                              return TabBarView(
                                controller: _tabController,
                                children: [
                                  _buildLeaveList(leavesProvider.leaves.where((leave) => leave.status == 'Pending').toList()),
                                  _buildLeaveList(leavesProvider.leaves.where((leave) => leave.status == 'Approved').toList()),
                                  _buildLeaveList(leavesProvider.leaves.where((leave) => leave.status == 'Rejected').toList()),
                                ],
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeaveList(List<Leave> leaves) {
    return ListView.builder(
      itemCount: leaves.length,
      itemBuilder: (context, index) {
        final leave = leaves[index];
        return Column(
          children: [
            ListTile(
              trailing: Icon(Icons.picture_as_pdf, color: Colors.orange),
              title: Text(
                leave.type,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("${leave.startDate} to ${leave.endDate}\n${leave.description}"),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        "Status: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: leave.status == 'Pending'
                              ? Colors.grey
                              : leave.status == 'Approved'
                                  ? Colors.green
                                  : Colors.red,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Text(
                          leave.status,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              isThreeLine: true,
            ),
            Divider(color: const Color.fromARGB(255, 0, 0, 0), thickness: 0.1), // Thin blue line
          ],
        );
      },
    );
  }

  Widget _leaveStatCard(
      BuildContext context, String title, String used, String remaining) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      height: 120,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        used,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "used",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        remaining,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "remaining",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LeaveFormPage extends StatefulWidget {
  const LeaveFormPage({super.key});

  @override
  _LeaveFormPageState createState() => _LeaveFormPageState();
}

class _LeaveFormPageState extends State<LeaveFormPage> {
  String selectedLeaveType = 'Choose Your Leave Type';
  final List<String> leaveTypes = [
    'Choose Your Leave Type',
    'Sick Leave',
    'Annual Leave', 
    'Birthday Leave',
    'Busnisstrip Leave', 
    'Compensation Leave',
    'Death Type A&B Leave',
    'Hajj Leave',
    'Marriage Leave',
  ];

  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String? uploadedFilePath;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    if (selectedLeaveType == 'Annual Leave') {
      _fetchRecommendations();
    }
  }

  void _fetchRecommendations() async {
    final leavesProvider = Provider.of<LeavesProvider>(context, listen: false);
    await leavesProvider.getLeaveRecommendations();
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _pickDocument() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        uploadedFilePath = result.files.single.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    context.read<AuthProvider>().initAuth();
    final leavesProvider = Provider.of<LeavesProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFF2C80E6),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Image.asset(
          'assets/images/orangelogoonly.png',
          height: 50,
        ),
      ),
      body: Column(
        children: [
          // Header Section
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFF2C80E6),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                SizedBox(height: 16),
                Text(
                  "Leave Form",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 16),
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0), // More rounded
                  ),
                  elevation: 8,
                  shadowColor: Colors.black.withOpacity(0.2),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedLeaveType,
                        icon: const Icon(Icons.arrow_downward,
                            color: Colors.black),
                        iconSize: 24,
                        elevation: 16,
                        dropdownColor: Colors.white,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 18),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedLeaveType = newValue!;
                            if (selectedLeaveType == 'Annual Leave') {
                              _fetchRecommendations();
                            }
                          });
                        },
                        items: leaveTypes
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        borderRadius: BorderRadius.circular(20.0), // More rounded
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  if (selectedLeaveType != 'Annual Leave')
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Upload Your Document",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 16),
                        Center(
                          child: GestureDetector(
                            onTap: _pickDocument,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Icon(
                                Icons.upload_file,
                                size: 50,
                                color: Colors.orange,
                              ),
                            ),
                          ),
                        ),
                        if (uploadedFilePath != null)
                          Text("Uploaded: $uploadedFilePath"),
                      ],
                    ),
                  const SizedBox(height: 16),
                  if (selectedLeaveType == 'Annual Leave')
                    isLoading
                        ? Expanded(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
                                  ),
                                  SizedBox(height: 16),
                                  Icon(Icons.android, size: 50, color: Colors.black),
                                  SizedBox(height: 16),
                                  Text(
                                    'AI Recommendation',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : leavesProvider.recommendations.isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Recommendations:',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8), // Add space between text and container
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          spreadRadius: 2,
                                          blurRadius: 10,
                                          offset: Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: leavesProvider.recommendations.map((recommendation) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                                            child: Text(
                                              recommendation,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 35),
            child: ElevatedButton(
              onPressed: () async {
                if (selectedLeaveType != 'Choose Your Leave Type' &&
                    startDateController.text.isNotEmpty &&
                    endDateController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty) {
                  await Provider.of<LeavesProvider>(context, listen: false)
                      .submitLeave(
                    type: selectedLeaveType,
                    startDate: startDateController.text,
                    endDate: endDateController.text,
                    description: descriptionController.text,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Leave request submitted successfully')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill all fields')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: Size(double.infinity, 60),
                maximumSize: Size(double.infinity, 60),
              ),
              child: const Text(
                'Submit Leave Request',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
