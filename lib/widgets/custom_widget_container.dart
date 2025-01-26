import 'package:flutter/material.dart';

class CustomWidgetContainer extends StatefulWidget {
  final String title;
  final IconData icon;
  final Widget child;
  final bool isVisible;
  final VoidCallback onRemoveWidget;

  const CustomWidgetContainer({
    Key? key,
    required this.title,
    required this.icon,
    required this.child,
    this.isVisible = true,
    required this.onRemoveWidget,
  }) : super(key: key);

  @override
  _CustomWidgetContainerState createState() => _CustomWidgetContainerState();
}

class _CustomWidgetContainerState extends State<CustomWidgetContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(widget.icon, size: 24),
                  SizedBox(width: 8),
                  Text(
                    widget.title,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              IconButton(
                onPressed: widget.onRemoveWidget,
                icon: Icon(Icons.remove_circle, color: Colors.orange),
              ),
            ],
          ),
          widget.child,
        ],
      ),
    );
  }
}

class AddWidgetDialog extends StatefulWidget {
  final Function(String) onAddWidget;
  final List<String> hiddenWidgets;

  const AddWidgetDialog({required this.onAddWidget, required this.hiddenWidgets});

  @override
  _AddWidgetDialogState createState() => _AddWidgetDialogState();
}

class _AddWidgetDialogState extends State<AddWidgetDialog> {
  late List<String> availableWidgets;

  @override
  void initState() {
    super.initState();
    availableWidgets = List.from(widget.hiddenWidgets);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add Widget',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              child: Column(
                children: availableWidgets.map((name) {
                  return ListTile(
                    title: Text(name),
                    trailing: Icon(Icons.add_circle, color: Colors.blue),
                    onTap: () {
                      widget.onAddWidget(name);
                      setState(() {
                        availableWidgets.remove(name);
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                backgroundColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Close',
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
}