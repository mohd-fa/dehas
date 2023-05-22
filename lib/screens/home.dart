import 'package:flutter/material.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import 'package:dehas/screens/homepage.dart';
import 'package:dehas/screens/chatpage.dart';
import 'package:dehas/screens/counselpage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int navindex = 0;
  final List<Widget> pages = [ const HomePage(),const ChatPage(),const CounselPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[navindex],
      bottomNavigationBar: SlidingClippedNavBar(backgroundColor: Colors.redAccent.shade700,
        activeColor: Colors.white,
        selectedIndex: navindex,
        onButtonPressed: (index) => setState(() {
          navindex = index;
        }),
        barItems: [
          BarItem(title: 'Home', icon: Icons.home_rounded),
          BarItem(title: 'Chat', icon: Icons.chat_rounded),
          BarItem(title: 'Counsel', icon: Icons.people),
        ],
      ),
    );
  }
}
