import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clicker_game/helpers/assets_resource.dart';
import 'package:flutter_clicker_game/helpers/dimens.dart';
import 'package:flutter_clicker_game/helpers/text_resources.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  bool _isPlayed = false;
  AudioPlayer? _audioPlayer;

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
  }

  @override
  void dispose() {
    _audioPlayer?.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _isPlayed ? _played() : _initial();
  }

  _played() {
    return ScaleTransition(
      scale: _animation,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(smallMargin),
            decoration: BoxDecoration(
              border: Border.all(width: 3.0),
            ),
            child: Column(
              children: [
                InkWell(
                  child: Image.asset(
                    novaSkin,
                    height: 200,
                    width: 150,
                  ),
                  onTap: () {
                    if (_isPlayed) {
                      _controller.reverse().whenComplete(() {
                        setState(() {
                          _isPlayed = !_isPlayed;
                        });
                      });
                    }
                  },
                ),
                const SizedBox(
                  height: smallMargin,
                ),
                Text(
                  clickMe,
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _initial() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          clickMe,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(
          height: smallMargin,
        ),
        const Text(
          homeDesc,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: mediumMargin,
        ),
        Container(
          width: 150,
          height: 50,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            border: Border.all(width: 3.0),
          ),
          child: InkWell(
            child: const Center(
              child: Text(
                play,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            onTap: () async {
              await _audioPlayer?.play(soundUh);
              setState(() {
                _isPlayed = !_isPlayed;
                _controller.forward();
              });
            },
          ),
        ),
      ],
    );
  }
}
