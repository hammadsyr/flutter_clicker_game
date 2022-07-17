import 'package:flutter/material.dart';
import 'package:flutter_clicker_game/helpers/dimens.dart';
import 'package:flutter_clicker_game/ui/main_screen.dart';

class DefaultBottomBar extends StatefulWidget {
  final Function(PageState) pageState;

  const DefaultBottomBar({Key? key, required this.pageState}) : super(key: key);

  @override
  DefaultBottomBarState createState() => DefaultBottomBarState();
}

class DefaultBottomBarState extends State<DefaultBottomBar> {
  PageState _pageState = PageState.home;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(
        mediumMargin,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: mediumMargin,
        vertical: mediumMargin,
      ),
      decoration: BoxDecoration(border: Border.all(width: 3.0)),
      child: Center(
        child: Row(
          children: [
            const Spacer(),
            _bottomBarButton("Home", PageState.home),
            const SizedBox(
              width: smallMargin,
            ),
            const Text("|"),
            const SizedBox(
              width: smallMargin,
            ),
            _bottomBarButton("Play", PageState.play),
            const SizedBox(
              width: smallMargin,
            ),
            const Text("|"),
            const SizedBox(
              width: smallMargin,
            ),
            _bottomBarButton("About", PageState.about),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  _bottomBarButton(String text, PageState state) {
    return InkWell(
      child: Text(
        text,
        style: TextStyle(
          color: _pageState == state ? Theme.of(context).primaryColor : Colors.black,
        ),
      ),
      onTap: () {
        setState(() {
          _pageState = state;
          widget.pageState(state);
        });
      },
    );
  }
}
