import 'package:flutter/material.dart';
import 'package:flutter_clicker_game/helpers/widgets/default_app_bar.dart';

import '../helpers/widgets/default_bottom_bar.dart';
import 'about_screen.dart';
import 'home_screen.dart';
import 'play_screen.dart';

enum PageState { home, play, about }

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  PageState _pageState = PageState.home;

  @override
  void initState() {
    super.initState();
  }

  _midScreen() {
    if (_pageState == PageState.home) {
      return const HomeScreen();
    } else if (_pageState == PageState.play) {
      return const PlayScreen();
    } else {
      return const AboutScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(
        children: [
          const DefaultAppBar(),
          Expanded(
            child: _midScreen(),
          ),
          DefaultBottomBar(pageState: (state) {
            setState(() {
              debugPrint("state $state");
              _pageState = state;
            });
          }),
        ],
      ),
    );
  }
}
