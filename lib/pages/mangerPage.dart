import 'package:bugrani2/models/leave.dart';
import 'package:bugrani2/providers/leaves_provider.dart';
import 'package:bugrani2/providers/manger_proveder.dart';
import 'package:bugrani2/widgets/totalEmployees.dart';
import 'package:bugrani2/widgets/AbsentEmployees.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ManagerLeaveRequestScreen extends StatefulWidget {
  @override
  _ManagerLeaveRequestScreenState createState() =>
      _ManagerLeaveRequestScreenState();
}

class _ManagerLeaveRequestScreenState extends State<ManagerLeaveRequestScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ManagerProvider>(context, listen: false)
        .fetchDepartmentEmployees();
    Provider.of<LeavesProvider>(context, listen: false).getLeaves();
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
      body: Consumer<ManagerProvider>(
        builder: (context, managerProvider, child) {
          if (managerProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
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
                      Text(
                        "Manager Dashboard",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 16),
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        alignment: WrapAlignment.center,
                        children: [
                          _animatedStatCard(
                            context,
                            "Total Team Members",
                            "${managerProvider.totalEmployees}",
                            Icons.group,
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TotalEmployeesPage(
                                    employees: managerProvider.employees,
                                  ),
                                ),
                              );
                            },
                          ),
                          _animatedStatCard(
                            context,
                            "Absent Employees",
                            "${managerProvider.totalAbsentEmployees}",
                            Icons.person_off,
                            () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AbsentEmployeesPage(
                                    absentEmployees:
                                        managerProvider.absentEmployees,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Consumer<LeavesProvider>(
                  builder: (context, leavesProvider, child) {
                    if (leavesProvider.isLoading) {
                      return Center(child: CircularProgressIndicator());
                    }

                    final pendingRequests = leavesProvider.leaves
                        .where((leave) => leave.status == 'Pending')
                        .toList();
                    final approvedRequests = leavesProvider.leaves
                        .where((leave) => leave.status == 'Approved')
                        .toList();
                    final rejectedRequests = leavesProvider.leaves
                        .where((leave) => leave.status == 'Rejected')
                        .toList();

                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: DefaultTabController(
                        length: 3,
                        child: Column(
                          children: [
                            TabBar(
                              tabs: [
                                Tab(
                                  child: Text(
                                    "Pending",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    "Approved",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Tab(
                                  child: Text(
                                    "Rejected",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                              labelColor: Colors.blue,
                              unselectedLabelColor: Colors.black,
                              indicatorColor: Colors.blue,
                              indicatorWeight: 3.0,
                            ),
                            SizedBox(height: 8),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.55,
                              child: TabBarView(
                                children: [
                                  _buildLeaveList(pendingRequests, true),
                                  _buildLeaveList(approvedRequests, false),
                                  _buildLeaveList(rejectedRequests, false),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _animatedStatCard(BuildContext context, String title, String value,
      IconData icon, VoidCallback onTap) {
    return MouseRegion(
      onEnter: (_) => setState(() {}),
      onExit: (_) => setState(() {}),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: 160,
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
                  Icon(icon, size: 30, color: Colors.blue),
                  SizedBox(height: 8),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Click for details",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ).animate().scale(
              begin: Offset(1.0, 1.0),
              end: Offset(1.05, 1.05),
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
            ),
      ),
    );
  }

  Widget _buildLeaveList(List<Leave> leaves, bool isPending) {
    return ListView.builder(
      itemCount: leaves.length,
      itemBuilder: (context, index) {
        final leave = leaves[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Employee Name: ${leave.userName}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Leave Type: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      children: [
                        TextSpan(
                          text: ' ${leave.type}',
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Leave Duration: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      children: [
                        TextSpan(
                          text: ' ${leave.startDate} to ${leave.endDate}',
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Description: ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                      children: [
                        TextSpan(
                          text: ' ${leave.description}',
                          style: TextStyle(fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        "Status: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        decoration: BoxDecoration(
                          color: leave.status == 'Pending'
                              ? Colors.grey
                              : leave.status == 'Approved'
                                  ? Colors.green
                                  : Colors.red,
                          borderRadius: BorderRadius.circular(20),
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
                  if (isPending)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await Provider.of<LeavesProvider>(context,
                                    listen: false)
                                .approveLeave(leave.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Leave approved')),
                            );
                          },
                          child: Text(
                            'Approve',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () async {
                            await Provider.of<LeavesProvider>(context,
                                    listen: false)
                                .rejectLeave(leave.id);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Leave rejected')),
                            );
                          },
                          child: Text(
                            'Reject',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
            Divider(color: Colors.grey),
          ],
        );
      },
    );
  }
}
