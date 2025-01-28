import 'package:flutter/material.dart';
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
    setState(() {
      _loadingStates[employeeId] = true;
    });

    print('Fetching insights for employee ID: $employeeId'); // Debugging
    try {
      final response = await _managerService.getEmployeeInsights(employeeId);
      print('API Response: $response'); // Debugging

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: data['insights'].split('\n').map<Widget>((line) {
                  if (line.startsWith('**') && line.endsWith('**')) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        line.replaceAll('**', ''),
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    );
                  } else if (line.startsWith('1.') ||
                      line.startsWith('2.') ||
                      line.startsWith('3.') ||
                      line.startsWith('Overall')) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        line,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 4.0),
                      child: Text(
                        line,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    );
                  }
                }).toList(),
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
      setState(() {
        _loadingStates[employeeId] = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Employees list structure: ${widget.employees}'); // Debugging

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
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: widget.employees.length,
              itemBuilder: (context, index) {
                final employee = widget.employees[index];

                // Extract employee ID dynamically
                final employeeId = employee['_id'] ?? employee['id'] ?? '';
                print('Employee ID: $employeeId'); // Debugging

                return Card(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                              print(
                                  'Button clicked for employee ID: $employeeId'); // Debugging
                              if (employeeId.isNotEmpty) {
                                fetchInsights(context, employeeId);
                              } else {
                                print('Error: Employee ID is null or empty');
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Error: Employee ID is null or empty')),
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
                            label: Text('Get Insights',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16)),
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
        ],
      ),
    );
  }
}
