import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:bugrani2/services/mangaer_service.dart';

class TotalEmployeesPage extends StatefulWidget {
  final List<Map<String, String>> employees;

  TotalEmployeesPage({required this.employees});

  @override
  _TotalEmployeesPageState createState() => _TotalEmployeesPageState();
}

class _TotalEmployeesPageState extends State<TotalEmployeesPage> {
  final ManagerService _managerService = ManagerService();
  Map<String, bool> _loadingStates = {};

  Future<void> fetchInsights(BuildContext context, String employeeId) async {
    setState(() => _loadingStates[employeeId] = true);

    try {
      final response = await _managerService.getEmployeeInsights(employeeId);
      final data = response;

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              'Employee Insights',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            content: SingleChildScrollView(
              child: MarkdownBody(
                data: data['insights'],
                styleSheet: MarkdownStyleSheet(
                  strong: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  h3: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  p: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                  listIndent: 16.0,
                  blockSpacing: 8.0,
                ),
              ),
            ),
            actions: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'Close',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Error fetching insights: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching insights')),
      );
    } finally {
      setState(() => _loadingStates[employeeId] = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.employees.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Total Employees'),
        ),
        body: Center(
          child: Text('No employees found.'),
        ),
      );
    }

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
                top: 110,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    "Total Employees",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 0,
                right: 0,
                child: Center(
                  child: Image.asset(
                    'assets/images/orangelogoonly.png',
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListView.builder(
                itemCount: widget.employees.length,
                itemBuilder: (context, index) {
                  final employee = widget.employees[index];
                  final employeeId = employee['_id'] ?? employee['id'] ?? '';

                  return Card(
                    color: Colors.white,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            employee['name'] ?? 'No Name',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Email: ${employee['email'] ?? 'No Email'}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            'Location: ${employee['location'] ?? 'No Location'}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            'Title: ${employee['title'] ?? 'No Title'}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                if (employeeId.isNotEmpty) {
                                  fetchInsights(context, employeeId);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Error: Employee ID is null or empty'),
                                    ),
                                  );
                                }
                              },
                              icon: _loadingStates[employeeId] == true
                                  ? SizedBox(
                                      width: 16,
                                      height: 16,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Icon(Icons.insights, color: Colors.white),
                              label: Text(
                                'Get Insights',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
