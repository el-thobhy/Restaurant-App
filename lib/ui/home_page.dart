import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/main_page.dart';

class HomePage extends StatefulWidget {
  final int bottomNavBarIndex;

  const HomePage({Key? key, this.bottomNavBarIndex = 0}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int index;
  late PageController pageController;

  @override
  void initState() {
    super.initState();

    index = widget.bottomNavBarIndex;
    pageController = PageController(initialPage: index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.amber,
          ),
          SafeArea(
              child: Container(
            color: Colors.grey[100],
          )),
          const MainPage(),
        ],
      ),
    );
  }
}
