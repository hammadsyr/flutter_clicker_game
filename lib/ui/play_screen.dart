import 'dart:async';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clicker_game/helpers/assets_resource.dart';
import 'package:flutter_clicker_game/helpers/dimens.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({Key? key}) : super(key: key);

  @override
  PlayScreenState createState() => PlayScreenState();
}

class PlayScreenState extends State<PlayScreen> with TickerProviderStateMixin {
  Timer? _timer;
  int _start = 10;
  bool _isFirstClicked = true;
  int _clickCount = 0;
  AudioPlayer? _audioPlayer;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    lowerBound: 0.5,
    vsync: this,
  )..forward;

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  final List<Color> _colors = [
    Colors.red,
    Colors.green,
    Colors.indigo,
    Colors.blueAccent,
    Colors.deepPurple,
    Colors.tealAccent
  ];

  Color _color = Colors.green;
  double _circleSize = 300.0;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
  }

  @override
  void dispose() {
    super.dispose();
    _audioPlayer?.dispose();
    _timer?.cancel();
    _controller.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) async {
        if (_start == 0) {
          await _audioPlayer?.play(soundUh);
          _isFirstClicked = true;
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  _playingWidgets() {
    return [
      InkWell(
        onTap: () async {
          if (_isFirstClicked) {
            startTimer();
            _isFirstClicked = false;
          }

          var rnd = Random();
          int index = rnd.nextInt(_colors.length - 1);
          _clickCount++;
          if (_clickCount % 10 == 0) {
            await _audioPlayer?.play(soundUh);
          }

          setState(() {
            _color = _colors[index];
            _circleSize -= 2.0;
          });
        },
        child: Container(
          width: _circleSize,
          height: _circleSize,
          decoration: BoxDecoration(shape: BoxShape.circle, color: _color),
        ),
      ),
      const SizedBox(
        height: largeMargin,
      ),
      Text(
        "You clicked $_clickCount times",
        style: const TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
      ),
      const SizedBox(
        height: smallMargin,
      ),
      Text(
        "$_start seconds left",
        textAlign: TextAlign.center,
      ),
    ];
  }

  _rewardWidgets(BuildContext context) {
    return [
      Text(
        "Yeeaay, here is your reward",
        style: TextStyle(fontSize: 26, color: Theme.of(context).primaryColor),
        textAlign: TextAlign.center,
      ),
      const SizedBox(
        height: mediumMargin,
      ),
      ScaleTransition(
        scale: _animation,
        child: Container(
          padding: const EdgeInsets.all(smallMargin),
          decoration: BoxDecoration(
            border: Border.all(width: 3.0),
          ),
          child: Image.asset(
            novaSkin,
            height: 240,
            width: 180,
          ),
        ),
      ),
      const SizedBox(
        height: mediumMargin,
      ),
      Text(
        "You clicked $_clickCount times",
        style: const TextStyle(fontSize: 20),
        textAlign: TextAlign.center,
      ),
      const SizedBox(
        height: smallMargin,
      ),
      Text(
        "$_start seconds left",
        textAlign: TextAlign.center,
      ),
      const SizedBox(
        height: mediumMargin,
      ),
      Container(
        width: 150,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.blue,
          border: Border.all(width: 3.0),
        ),
        child: InkWell(
          child: const Center(
            child: Text(
              "Play",
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          onTap: () {
            _clickCount = 0;
            setState(() {
              _start = 10;
              _circleSize = 300.0;
            });
          },
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _start == 0 ? _rewardWidgets(context) : _playingWidgets(),
    );
  }
}
