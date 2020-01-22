import 'dart:async';

import 'package:flutter/material.dart';
import 'package:aplayer/player.dart';
import 'package:aplayer/utils.dart';

class LinearAudioBar extends StatelessWidget {
  double _progressValue = 0.0;
  StreamSubscription _sub;
  GlobalKey _keyTap = GlobalKey();

  final APlayer player;

  LinearAudioBar({Key key, this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: player.curentTime,
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          _progressValue = 0.0;
        else {
          _progressValue = snapshot.data.inMilliseconds.toDouble() /
              player.duration.inMilliseconds.toDouble();
        }
        return GestureDetector(
          onTap: () {},
          onTapDown: (TapDownDetails details) {
            final RenderBox renderBox =
                _keyTap.currentContext.findRenderObject();
            final size = renderBox.size;
            final position = renderBox.localToGlobal(Offset.zero);
            final newCursorPosition = APlayerUtils.getPosition(
                Offset(details.globalPosition.dx, details.globalPosition.dy),
                position,
                size);
            final newCursorPositionInTime =
                newCursorPosition * player.duration.inMilliseconds;
            player.setCurrentTime(
                Duration(milliseconds: newCursorPositionInTime.toInt()));
          },
          child: LinearProgressIndicator(
            key: _keyTap,
            value: _progressValue,
          ),
        );
      },
    );
  }
}
