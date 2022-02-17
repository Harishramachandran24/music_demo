import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_demo/player.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _selectedMusic = '';
  List all_songs = [
    {
      "image":
      "https://www.iwmbuzz.com/wp-content/uploads/2019/08/what-makes-a-r-rahmans-music-so-popular-920x518.jpg",
      "name": "Hayati",
      "song": "Hayati.mp3",
      "musicby": "A R Rahman"
    },
    {
      "image":
      "https://static.toiimg.com/thumb/msid-73098630,width-1200,height-900,resizemode-4/.jpg",
      "name": "Arabic Kuthu",
      "song": "ArabicKuthu.mp3",
      "musicby": "Anirudh"
    },
  ];
  List playList = [];
  late AudioCache audioCache;
  late AudioPlayer audioPlayer;

  @override
  Widget build(BuildContext context) {
    final double _height = MediaQuery.of(context).size.height;
    final double _width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.white, Colors.deepPurple],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 2.0],
                  tileMode: TileMode.clamp)),
          child: Stack(
            children: [
              Positioned(
                height: _height * 0.2,
                top: _height * 0.14,
                left: (_width - 170) / 2,
                right: (_width - 170) / 2,
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                      image: const DecorationImage(
                          image: NetworkImage(
                              "https://media.istockphoto.com/photos/golden-music-notes-isolated-on-white-background-picture-id1182235520?b=1&k=20&m=1182235520&s=170667a&w=0&h=HN1r8AhdrQX-amWYM9vpv0WANR0OoVTnbihMg5v4hA8="),
                          fit: BoxFit.cover),
                    )),
              ),
              Positioned(
                top: _height / 2,
                height: _height,
                left: 0.0,
                right: 0.0,
                child: Card(
                    elevation: 5,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "Playlist",
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                            height: _height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: _height * 0.08,
                                width: _width - 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: Colors.black45, width: 2.0)),
                                child: Row(
                                  children: [
                                    Radio<String>(
                                        value: "arrahman",
                                        groupValue: _selectedMusic,
                                        onChanged: (value) {
                                          playList = [];
                                          setState(() {
                                            _selectedMusic = value!;
                                            if (_selectedMusic == "arrahman") {
                                              playList.add(all_songs[0]);
                                            }
                                          });
                                        }),
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          image: const DecorationImage(
                                              image: NetworkImage(
                                                  "https://www.iwmbuzz.com/wp-content/uploads/2019/08/what-makes-a-r-rahmans-music-so-popular-920x518.jpg"),
                                              fit: BoxFit.cover),
                                          borderRadius:
                                          BorderRadius.circular(10.0)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: const [
                                          Text("Hayati"),
                                          Text("A.R.Rahman")
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: _height * 0.02,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: _height * 0.08,
                                width: _width - 40,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: Colors.black45, width: 2.0)),
                                child: Row(
                                  children: [
                                    Radio<String>(
                                        value: "anirudh",
                                        groupValue: _selectedMusic,
                                        onChanged: (value) {
                                          playList = [];
                                          setState(() {
                                            _selectedMusic = value!;
                                            if (_selectedMusic == "anirudh") {
                                              playList.add(all_songs[1]);
                                            }
                                          });
                                        }),
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          image: const DecorationImage(
                                              image: NetworkImage(
                                                  "https://static.toiimg.com/thumb/msid-73098630,width-1200,height-900,resizemode-4/.jpg"),
                                              fit: BoxFit.cover),
                                          borderRadius:
                                          BorderRadius.circular(10.0)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: const [
                                          Text("Arabic Kuthu"),
                                          Text("Anirudh")
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    )),
              ),
              Positioned(
                  bottom: _height * 0.05,
                  left: (_width - 100) / 2,
                  right: (_width - 100) / 2,
                  height: 50,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        ),
                        Text(
                          "PLAY",
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        )
                      ],
                    ),
                    onPressed: () {
                      if (playList.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text("select a song"),
                              ],
                            )));
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => player(playList)),
                        );
                      }
                    },
                  ))
            ],
          ),
        ));
  }
}