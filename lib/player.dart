import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class player extends StatefulWidget {
  final List playList;
  const player(this.playList, {Key? key}) : super(key: key);

  @override
  _playerState createState() => _playerState();
}

class _playerState extends State<player> with TickerProviderStateMixin {
  late AnimationController _animationIconController;
  late AudioCache audioCache;
  late AudioPlayer audioPlayer;
  Duration duration = Duration();
  late int running_seconds;
  late int playing_seconds;
  Duration position = Duration();
  bool issongplaying = false;

  @override
  void initState() {
    super.initState();
    if (mounted) {
      initPlayer();
    }
    setState(() {
      issongplaying = true;
      _animationIconController.forward();
      audioCache.play(widget.playList[0]["song"]);
    });
  }

  void initPlayer() {
    if (mounted) {
      _animationIconController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 450),
        reverseDuration: const Duration(milliseconds: 450),
      );
      audioPlayer = AudioPlayer();
      audioCache = AudioCache(fixedPlayer: audioPlayer);
      audioPlayer.onDurationChanged.listen((d) {
        setState(() {
          running_seconds = d.inSeconds;
          duration = d;
        });
      });
      audioPlayer.onAudioPositionChanged.listen((p) {
        setState(() {
          position = p;
          playing_seconds = p.inSeconds;
        });
        if (running_seconds == playing_seconds) {
          setState(() {
            _animationIconController.reverse();
            issongplaying = false;
          });
        }
      });
    }
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    audioPlayer.seek(newDuration);
  }

  Widget slider() {
    return Slider.adaptive(
        activeColor: Colors.red,
        inactiveColor: Colors.black45,
        min: 0.0,
        value: position.inSeconds.toDouble(),
        max: duration.inSeconds.toDouble(),
        onChanged: (double value) {
          setState(() {
            seekToSecond(value.toInt());
            value = value;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.white, Colors.deepPurple],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0.0, 2.0],
                  tileMode: TileMode.clamp)),
        ),
        Positioned(
            top: _height * 0.18,
            left: _width * 0.09,
            right: _width * 0.09,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      widget.playList[0]["name"],
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.playList[0]["musicby"],
                      style: const TextStyle(color: Colors.white),
                    )
                  ],
                )
              ],
            )),
        Positioned(
          height: _height / 5,
          top: _height * 0.50,
          left: 10,
          width: _width - 20,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: _height * 0.05),
                slider(),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, left: 28.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(position.toString().split(".")[0]),
                      Text(duration.toString().split(".")[0]),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: () {
                            if (position.inSeconds.toDouble() < 30.0) {
                              setState(() {
                                seekToSecond(0);
                              });
                            } else {
                              var value = position.inSeconds.toDouble() - 30.0;
                              setState(() {
                                seekToSecond(value.toInt());
                              });
                            }
                          },
                          icon: const Icon(Icons.replay_30)),
                      GestureDetector(
                        onTap: () {
                          if (issongplaying) {
                            setState(() {
                              _animationIconController.reverse();
                              audioPlayer.pause();
                              issongplaying = false;
                            });
                          } else {
                            setState(() {
                              _animationIconController.forward();
                              audioCache.play(widget.playList[0]["song"]);
                              issongplaying = true;
                            });
                          }
                        },
                        child: ClipOval(
                          child: Container(
                            decoration: const BoxDecoration(
                                color: Colors.black, shape: BoxShape.circle),
                            child: Center(
                                child: AnimatedIcon(
                              icon: AnimatedIcons.play_pause,
                              progress: _animationIconController,
                              color: Colors.red,
                              size: 40,
                            )),
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            var value = position.inSeconds.toDouble() + 30.0;
                            if (value > duration.inSeconds) {
                              setState(() {
                                seekToSecond(duration.inSeconds);
                                _animationIconController.reverse();
                                issongplaying = false;
                              });
                            } else {
                              setState(() {
                                seekToSecond(value.toInt());
                              });
                            }
                          },
                          icon: const Icon(Icons.forward_30)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
          height: _height * 0.3,
          top: _height * 0.25,
          left: (_width - 220) / 2,
          right: (_width - 220) / 2,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
              image: DecorationImage(
                  image: NetworkImage(widget.playList[0]["image"]),
                  fit: BoxFit.cover),
            ),
          ),
        ),
      ],
    ));
  }

  @override
  void dispose() {
    super.dispose();
    _animationIconController.dispose();
    audioPlayer.dispose();
  }
}
