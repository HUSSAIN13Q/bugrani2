import 'package:bugrani2/providers/meetings_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UpcomingMeetingsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final meetingProvider = Provider.of<MeetingProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
         
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 50,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                ...meetingProvider.meetings.map((meeting) => Column(
                      children: [
                        MeetingItem(
                          title: meeting['title']!,
                          date: meeting['date']!,
                          description: meeting['description']!,
                          time: meeting['time']!,
                        ),
                        Divider(color: Colors.grey),
                      ],
                    )),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    debugPrint("Opening Generate Meeting Dialog");
                    showDialog(
                      context: context,
                      builder: (context) {
                        return GenerateMeetingDialog();
                      },
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Click to Generate Meeting',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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

class MeetingItem extends StatelessWidget {
  final String title;
  final String date;
  final String description;
  final String time;

  const MeetingItem({
    required this.title,
    required this.date,
    required this.description,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.blue,
              ),
            ),
            Text(
              time,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          date,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}

class GenerateMeetingDialog extends StatefulWidget {
  @override
  _GenerateMeetingDialogState createState() => _GenerateMeetingDialogState();
}

class _GenerateMeetingDialogState extends State<GenerateMeetingDialog> {
  final _titleController = TextEditingController();
  final _dateController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _timeController = TextEditingController();
  final _departmentController = TextEditingController();
  final _teamController = TextEditingController();
  final _locationController = TextEditingController();
  TimeOfDay? _selectedTime;
  DateTime? _selectedDate;

  final Map<String, List<String>> _departmentTeams = {
    'Accounting': ['Accounts Receivable', 'Accounts Payable', 'Audit Team'],
    'IT': ['Development Team', 'Network Team', 'Support Team'],
    'HR': ['Recruitment', 'Employee Relations', 'Training Team'],
    'Finance': ['Financial Planning', 'Investment Team', 'Taxation'],
    'Other': ['General Team 1', 'General Team 2', 'General Team 3'],
  };

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Spacer(),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close, color: Colors.black),
                ),
              ],
            ),
            Text(
              'Generate Meeting',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            _buildDropdownField('Choose Department', _departmentController,
                _departmentTeams.keys.toList()),
            SizedBox(height: 16),
            _buildDropdownField('Choose Team', _teamController,
                _departmentTeams[_departmentController.text] ?? []),
            SizedBox(height: 16),
            _buildTextField('Location', _locationController),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTimeField(),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildDateField(),
                ),
              ],
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _confirmMeeting(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Confirm',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownField(
      String label, TextEditingController controller, List<String> options) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: options.isEmpty
              ? null
              : (controller.text.isEmpty ? options.first : controller.text),
          items: options
              .map((e) => DropdownMenuItem(child: Text(e), value: e))
              .toList(),
          onChanged: (value) {
            setState(() {
              controller.text = value!;
              if (label == 'Choose Department') {
                _teamController.clear();
                if (_departmentTeams.containsKey(value) &&
                    _departmentTeams[value]!.isNotEmpty) {
                  _teamController.text = _departmentTeams[value]!.first;
                }
              }
            });
          },
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimeField() {
    return GestureDetector(
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (pickedTime != null) {
          setState(() {
            _selectedTime = pickedTime;
            _timeController.text = _selectedTime!.format(context);
          });
        }
      },
      child: AbsorbPointer(
        child: _buildTextField(
          'Choose Time',
          _timeController,
        ),
      ),
    );
  }

  Widget _buildDateField() {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null) {
          setState(() {
            _selectedDate = pickedDate;
            _dateController.text = DateFormat('MMM dd, yyyy').format(_selectedDate!);
          });
        }
      },
      child: AbsorbPointer(
        child: _buildTextField(
          'Choose Date',
          _dateController,
        ),
      ),
    );
  }

  void _confirmMeeting(BuildContext context) {
    if (_departmentController.text.isEmpty ||
        _teamController.text.isEmpty ||
        _locationController.text.isEmpty ||
        _timeController.text.isEmpty ||
        _dateController.text.isEmpty) {
      debugPrint("Missing input fields. Cannot add meeting.");
      return;
    }

    final meeting = {
      'title': '${_teamController.text} Meeting',
      'date': _dateController.text,
      'description': 'Lead by ${_departmentController.text} at ${_locationController.text}',
      'time': _timeController.text,
    };

    debugPrint("Adding Meeting: $meeting");
    Provider.of<MeetingProvider>(context, listen: false).addMeeting(meeting);
    Navigator.pop(context);
  }
}