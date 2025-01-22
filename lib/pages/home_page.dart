import 'package:bugrani2/pages/NotificationPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'leaves_page.dart';
import '../widgets/BusinessCardDialog.dart';
import '../widgets/MapSection.dart';
import '../widgets/SpecialOffersSection.dart';
import '../widgets/UpcomingMeetingsSection.dart';
import 'NewsPage.dart';
import 'InboxPage.dart';
import 'CommunityPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  bool isExpanded = true;
  List<CustomWidgetContainer> customWidgets = [
    CustomWidgetContainer(
      title: 'Map Section',
      child: MapSection(),
      onRemoveWidget: () {},
    ),
    CustomWidgetContainer(
      title: 'Leaves Section',
      child: LeavesPageButton(),
      onRemoveWidget: () {},
    ),
    CustomWidgetContainer(
      title: 'Special Offers Section',
      child: SpecialOffersSection(),
      onRemoveWidget: () {},
    ),
    CustomWidgetContainer(
      title: 'Upcoming Meetings Section',
      child: UpcomingMeetingsSection(),
      onRemoveWidget: () {},
    ),
  ];

  void addCustomWidget(String title) {
    setState(() {
      customWidgets.add(CustomWidgetContainer(
        title: title,
        child: _getWidgetByTitle(title),
        onRemoveWidget: () {},
      ));
    });
  }

  Widget _getWidgetByTitle(String title) {
    switch (title) {
      case 'Map Section':
        return MapSection();
      case 'Leaves Section':
        return LeavesPageButton();
      case 'Special Offers Section':
        return SpecialOffersSection();
      case 'Upcoming Meetings Section':
        return UpcomingMeetingsSection();
      default:
        return Container();
    }
  }

  void showAddWidgetDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AddWidgetDialog(
          onAddWidget: addCustomWidget,
          hiddenWidgets: customWidgets.where((widget) => !widget.isVisible).map((widget) => widget.title).toList(),
        );
      },
    );
  }

  final List<Widget> _pages = [
    HomePageContent(
      customWidgets: [],
      onRemoveWidget: (index) {},
    ),
    CommunityPage(),
    InboxPage(),
    NewsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _currentIndex == 0
          ? AppBar(
              backgroundColor: Color(0xFF2C80E6),
              elevation: 0,
              centerTitle: true,
              title: Image.asset(
                'assets/images/orangelogoonly.png',
                height: 40,
              ),
              leading: IconButton(
                icon: Icon(Icons.badge_outlined, size: 30, color: Colors.white),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => BusinessCardDialog(),
                  );
                },
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.notifications_outlined, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NotificationPage()),
                    );
                  },
                ),
              ],
            )
          : null,
      body: Column(
        children: [
          if (_currentIndex == 0)
            Stack(
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: isExpanded ? 470 : 260,
                  decoration: BoxDecoration(
                    color: Color(0xFF2C80E6),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: HeaderSection(isExpanded: isExpanded),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: IconButton(
                      icon: Icon(
                        isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          Expanded(
            child: _currentIndex == 0
                ? HomePageContent(
                    customWidgets: customWidgets,
                    onRemoveWidget: (index) {
                      setState(() {
                        customWidgets[index] = CustomWidgetContainer(
                          title: customWidgets[index].title,
                          child: customWidgets[index].child,
                          isVisible: false,
                          onRemoveWidget: () {},
                        );
                      });
                    },
                  )
                : _pages[_currentIndex],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.home),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.people),
            ),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.inbox),
            ),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.article),
            ),
            label: 'News',
          ),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              onPressed: showAddWidgetDialog,
              backgroundColor: Colors.orange,
              child: Text(
                '+',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              shape: CircleBorder(),
            )
          : null,
    );
  }
}

class HomePageContent extends StatelessWidget {
  final List<CustomWidgetContainer> customWidgets;
  final Function(int) onRemoveWidget;

  const HomePageContent({
    Key? key,
    required this.customWidgets,
    required this.onRemoveWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 16),
          ...customWidgets.asMap().entries.map((entry) {
            int index = entry.key;
            CustomWidgetContainer widget = entry.value;
            return Visibility(
              visible: widget.isVisible,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CustomWidgetContainer(
                  title: widget.title,
                  child: widget.child,
                  onRemoveWidget: () => onRemoveWidget(index),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

class CustomWidgetContainer extends StatefulWidget {
  final String title;
  final Widget child;
  final bool isVisible;
  final VoidCallback onRemoveWidget;

  const CustomWidgetContainer({
    Key? key,
    required this.title,
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
              Text(
                widget.title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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



class HeaderSection extends StatefulWidget {
  final bool isExpanded;

  const HeaderSection({Key? key, required this.isExpanded}) : super(key: key);

  @override
  _HeaderSectionState createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<HeaderSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Meshari alhouli',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'UI Design / IT Department',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              SizedBox(height: 16),
              Text(
                'Total work this month',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  WorkStats(title: 'Working day', value: '30', unit: 'Days'),
                  VerticalDivider(color: Colors.grey),
                  WorkStats(
                    title: 'Late',
                    value: '0',
                    unit: 'Minutes',
                    valueColor: Colors.orange,
                  ),
                  VerticalDivider(color: Colors.grey),
                  WorkStats(title: 'Overtime', value: '15', unit: 'Hours'),
                ],
              ),
            ],
          ),
        ),
        if (widget.isExpanded) ...[
          SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.ads_click_outlined, color: Colors.white),
                  SizedBox(width: 8),
                  Text(
                    'Click to Check In',
                    style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CheckButton(
                title: 'Check in',
                time: '-',
                status: '',
                icon: Icons.check_circle,
              ),
              SizedBox(width: 16),
              CheckButton(
                title: 'Check out',
                time: '-',
                status: '',
                icon: Icons.logout,
              ),
            ],
          ),
        ],
      ],
    );
  }
}

class LeavesPageButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LeavesPage()),
          );
        },
        child: Container(
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              'Leaves Page',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CheckButton extends StatelessWidget {
  final String title;
  final String time;
  final String status;
  final IconData icon;
  final Color? statusColor;

  const CheckButton({required this.title, required this.time, required this.status, required this.icon, this.statusColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      height: 130,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: Colors.blue),
          SizedBox(height: 8),
          Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(time.isEmpty ? '-' : time, style: TextStyle(fontWeight: FontWeight.bold)),
          if (status.isNotEmpty)
            Text(
              status,
              style: TextStyle(color: statusColor ?? (status == 'on time' ? Colors.green : Colors.red), fontSize: 12),
            ),
        ],
      ),
    );
  }
}

class WorkStats extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final Color? valueColor;
  final Color? unitColor;

  const WorkStats({
    required this.title,
    required this.value,
    required this.unit,
    this.valueColor,
    this.unitColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: valueColor ?? Colors.orange)),
        if (unit.isNotEmpty)
          Text(unit, style: TextStyle(color: unitColor ?? Colors.black)),
      ],
    );
  }
}

class SectionContainer extends StatelessWidget {
  final String title;
  final Widget child;

  const SectionContainer({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}
