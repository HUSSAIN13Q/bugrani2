import 'package:bugrani2/pages/NotificationPage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'leaves_page.dart';
import '../widgets/BusinessCardDialog.dart';
import '../widgets/MapSection.dart';
import '../widgets/SpecialOffersSection.dart';
import '../widgets/UpcomingMeetingsSection.dart';
import 'NewsPage.dart';
import 'InboxPage.dart';
import 'CommunityPage.dart';
import '../widgets/custom_widget_container.dart'; // Import the new file
import '../widgets/HeaderSection.dart'; // Import the new file

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  bool isExpanded = true;
  List<CustomWidgetContainer> customWidgets = [];

  @override
  void initState() {
    super.initState();
    _loadCustomWidgets();
  }

  Future<void> _loadCustomWidgets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedWidgets = prefs.getStringList('customWidgets');
    if (savedWidgets != null) {
      setState(() {
        customWidgets = savedWidgets.map((title) {
          return CustomWidgetContainer(
            title: title,
            icon: _getIconByTitle(title),
            child: _getWidgetByTitle(title),
            isVisible: true,
            onRemoveWidget: () => _toggleWidgetVisibility(title),
          );
        }).toList();
      });
    } else {
      setState(() {
        customWidgets = [
          CustomWidgetContainer(
            title: 'Head office Maps',
            icon: Icons.map,
            child: MapSection(),
            isVisible: true,
            onRemoveWidget: () => _toggleWidgetVisibility('Head office Maps'),
          ),
          CustomWidgetContainer(
            title: 'Leaves',
            icon: Icons.event_note,
            child: LeavesPageButton(),
            isVisible: true,
            onRemoveWidget: () => _toggleWidgetVisibility('Leaves'),
          ),
          CustomWidgetContainer(
            title: 'Special Offers',
            icon: Icons.local_offer,
            child: SpecialOffersSection(),
            isVisible: true,
            onRemoveWidget: () => _toggleWidgetVisibility('Special Offers'),
          ),
          CustomWidgetContainer(
            title: 'Upcoming Meetings',
            icon: Icons.people_alt_outlined,
            child: UpcomingMeetingsSection(),
            isVisible: true,
            onRemoveWidget: () => _toggleWidgetVisibility('Upcoming Meetings'),
          ),
        ];
      });
    }
  }

  void _saveCustomWidgets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> widgetTitles = customWidgets
        .where((widget) => widget.isVisible)
        .map((widget) => widget.title)
        .toList();
    await prefs.setStringList('customWidgets', widgetTitles);
  }

  void _toggleWidgetVisibility(String title) {
    setState(() {
      final index = customWidgets.indexWhere((widget) => widget.title == title);
      if (index != -1) {
        final widget = customWidgets[index];
        customWidgets[index] = CustomWidgetContainer(
          title: widget.title,
          icon: widget.icon,
          child: widget.child,
          isVisible: !widget.isVisible,
          onRemoveWidget: widget.onRemoveWidget,
        );
      }
      _saveCustomWidgets();
    });
  }

  void addCustomWidget(String title) {
    setState(() {
      final widget =
          customWidgets.firstWhere((widget) => widget.title == title);
      customWidgets[customWidgets.indexOf(widget)] = CustomWidgetContainer(
        title: widget.title,
        icon: widget.icon,
        child: widget.child,
        isVisible: true,
        onRemoveWidget: widget.onRemoveWidget,
      );
      _saveCustomWidgets();
    });
  }

  IconData _getIconByTitle(String title) {
    switch (title) {
      case 'Head office Maps':
        return Icons.map;
      case 'Leaves':
        return Icons.event_note;
      case 'Special Offers':
        return Icons.local_offer;
      case 'Upcoming Meetings':
        return Icons.people_alt_outlined;
      default:
        return Icons.widgets;
    }
  }

  Widget _getWidgetByTitle(String title) {
    switch (title) {
      case 'Head office Maps':
        return MapSection();
      case 'Leaves':
        return LeavesPageButton();
      case 'Special Offers':
        return SpecialOffersSection();
      case 'Upcoming Meetings':
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
          hiddenWidgets: customWidgets
              .where((widget) => !widget.isVisible)
              .map((widget) => widget.title)
              .toList(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      HomePageContent(
        customWidgets: customWidgets,
        onRemoveWidget: (index) =>
            _toggleWidgetVisibility(customWidgets[index].title),
      ),
      CommunityPage(),
      InboxPage(),
      NewsPage(),
    ];

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
                  icon: Icon(Icons.notifications_outlined,
                      color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationPage()),
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
                        isExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
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
            child: _pages[_currentIndex],
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
                  icon: widget.icon, // Add icon
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
          Text(title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}
