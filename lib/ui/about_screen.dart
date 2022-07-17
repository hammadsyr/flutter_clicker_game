// ignore_for_file: prefer_const_constructors

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clicker_game/helpers/assets_resource.dart';
import 'package:flutter_clicker_game/helpers/dimens.dart';
import 'package:flutter_clicker_game/helpers/text_resources.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  AboutScreenState createState() => AboutScreenState();
}

class AboutScreenState extends State<AboutScreen> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    lowerBound: 0.5,
    vsync: this,
  )..forward();

  late final AnimationController _controller2 = AnimationController(
    duration: const Duration(seconds: 2),
    lowerBound: 0.5,
    vsync: this,
  )..forward();

  late final AnimationController _controller3 = AnimationController(
    duration: const Duration(seconds: 2),
    lowerBound: 0.5,
    vsync: this,
  )..forward();

  late final AnimationController _controller4 = AnimationController(
    duration: const Duration(seconds: 2),
    lowerBound: 0.5,
    vsync: this,
  )..forward();

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.bounceIn,
  );

  late final Animation<double> _animation2 = CurvedAnimation(
    parent: _controller2,
    curve: Curves.bounceIn,
  );

  late final Animation<double> _animation3 = CurvedAnimation(
    parent: _controller3,
    curve: Curves.bounceIn,
  );

  late final Animation<double> _animation4 = CurvedAnimation(
    parent: _controller4,
    curve: Curves.bounceIn,
  );

  @override
  Widget build(BuildContext context) {
    bool isSmaller = true;
    bool isScreenWide = MediaQuery.of(context).size.width > 425.0;

    _marioIcon(Animation<double> animation, AnimationController controller) {
      return ScaleTransition(
        scale: animation,
        child: InkWell(
          onTap: () {
            isSmaller = !isSmaller;
            if (!isSmaller) {
              controller.reverse();
            } else {
              controller.forward();
            }
          },
          child: Image.asset(
            mario,
            height: 30,
            width: 30,
          ),
        ),
      );
    }

    _aboutChildren() {
      return [
        const Center(
          child: Text(
            "Me at a glance",
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: mediumMargin,
        ),
        SizedBox(
          width: 500,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _marioIcon(_animation, _controller),
              _marioIcon(_animation2, _controller2),
              _marioIcon(_animation3, _controller3),
              _marioIcon(_animation4, _controller4),
            ],
          ),
        ),
        const SizedBox(
          height: mediumMargin,
        ),
        Container(
          width: 500,
          margin: const EdgeInsets.symmetric(horizontal: largeMargin),
          padding: const EdgeInsets.all(largeMargin),
          decoration: BoxDecoration(
            border: Border.all(width: 3.0),
          ),
          child: Column(
            children: [
              Text(
                textAlign: TextAlign.center,
                aboutDesc,
                style: TextStyle(
                  height: 1.5,
                  fontSize: 12.0,
                ),
              ),
              const SizedBox(
                height: mediumMargin,
              ),
              Text(
                textAlign: TextAlign.center,
                "Flutter version of : ",
                style: TextStyle(
                  height: 1.5,
                  fontSize: 12.0,
                ),
              ),
              const SizedBox(
                height: smallMargin,
              ),
              GestureDetector(
                onTap: () {
                  const url = "https://paraparata.github.io/pfftPlayer";
                  launchUrl(Uri.parse(url));
                },
                child: Text(
                  textAlign: TextAlign.center,
                  "Paraparata pfftPlayer",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    height: 1.5,
                    fontSize: 12.0,
                  ),
                ),
              )
            ],
          ),
        )
      ];
    }

    return isScreenWide
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _aboutChildren(),
          )
        : ListView(
            children: _aboutChildren(),
          );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
  }
}
