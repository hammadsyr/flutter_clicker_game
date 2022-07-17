import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clicker_game/helpers/assets_resource.dart';
import 'package:flutter_clicker_game/helpers/text_resources.dart';

import '../dimens.dart';

class DefaultAppBar extends StatefulWidget {
  const DefaultAppBar({Key? key}) : super(key: key);

  @override
  _DefaultAppBarState createState() => _DefaultAppBarState();
}

class _DefaultAppBarState extends State<DefaultAppBar> {
  bool _isBgPlayed = false;
  AudioPlayer? _audioPlayer;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Stack(
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(
                vertical: mediumMargin,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: mediumMargin,
                vertical: mediumMargin,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 3.0,
                ),
              ),
              child: const Text(clickMe),
            ),
          ),
          Positioned(
            right: largeMargin,
            top: largeMargin,
            child: InkWell(
              onTap: () async {
                setState(() {
                  _isBgPlayed = !_isBgPlayed;
                });
                if (_isBgPlayed) {
                  await _audioPlayer?.play(soundYeay);
                  await _audioPlayer?.setReleaseMode(ReleaseMode.LOOP);
                } else {
                  await _audioPlayer?.stop();
                }
              },
              child: Icon(
                Icons.audiotrack_outlined,
                size: 40.0,
                color: _isBgPlayed ? Theme.of(context).primaryColor : Colors.black,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _audioPlayer = null;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY);
  }
}
