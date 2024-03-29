import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_application_1/api_manager.dart';
import 'package:flutter_application_1/pagerbody.dart';
import 'package:flutter_application_1/gamebody.dart';
import 'package:flutter_application_1/playerbody.dart';
import 'package:flutter_application_1/playermodel.dart';
import 'package:flutter_application_1/soccermodel.dart';

void main() => runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: BottomNavBar()));

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SoccerApp(),
    );
  }
}

class SoccerApp extends StatefulWidget {
  const SoccerApp({Key? key}) : super(key: key);

  @override
  _SoccerAppState createState() => _SoccerAppState();
}

class _SoccerAppState extends State<SoccerApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 75,
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarOpacity: 0.8,
        elevation: 0.0,
        title: Container(
          margin: const EdgeInsets.only(top: 20.0),
          width: 100,
          child: Image.asset(
            'images/nba.png',
          ),
        ),
      ),
      //now we have finished the api service let's call it
      //Now befo re we create Our layout let's create our API service
      body: FutureBuilder<List<SoccerMatch>>(
        future: SoccerApi()
            .getAllMatches(), //Here we will call our getData() method,
        builder: (context, snapshot) {
          //the future builder is very intersting to use when you work with api
          if (snapshot.hasData) {
            return PageBody(snapshot.data!, context);
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else {
            return Center(
              child: Image.asset(
                "images/shoot.gif",
              ),
            );
          }
        }, // here we will buil the app layout
      ),
    );
  }
}

class PlayerScreen extends StatelessWidget {
  final String data;

  const PlayerScreen({
    Key? key,
    required this.data,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    debugPrint(data);
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: const Color(0xFF4373D9),
        elevation: 0.0,
        title: const Text(
          "PLAYER",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      //now we have finished the api service let's call it
      //Now befo re we create Our layout let's create our API service
      body: FutureBuilder<PlayerModel>(
        future: SoccerApi()
            .getPlayerById(data), //Here we will call our getData() method,
        builder: (context, snapshot) {
          //the future builder is very intersting to use when you work with api
          if (snapshot.hasData) {
            return PlayerBody(snapshot.data!, context);
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else {
            return Center(
              child: Image.asset(
                "images/basketball.gif",
              ),
            );
          }
        }, // here we will buil the app layout
      ),
    );
  }
}

class GameScreen extends StatelessWidget {
  final String data;
  final String idHome;
  final String idAway;

  const GameScreen(
      {Key? key,
      required this.data,
      required this.idHome,
      required this.idAway})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Colors.red,
        toolbarHeight: 75,
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarOpacity: 0.8,
        elevation: 0.0,
        title: const Text(
          "GAME",
          style: TextStyle(color: Colors.white),
        ),
      ),
      //now we have finished the api service let's call it
      //Now befo re we create Our layout let's create our API service
      body: FutureBuilder<SoccerMatch>(
        future: SoccerApi()
            .getMatcheById(data), //Here we will call our getData() method,
        builder: (context, snapshot) {
          //the future builder is very intersting to use when you work with api
          if (snapshot.hasData) {
            return GameBody(snapshot.data!, context);
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else {
            return Center(
              child: Image.asset(
                "images/loading.gif",
              ),
            );
          }
        }, // here we will buil the app layout
      ),
    );
  }
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 1;
  double _op = 0;
  Color _color = Colors.blueAccent;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  Widget getWidget() {
    if (_page == 1) {
      _op = 1;
      _color = Colors.red;

      return const Scaffold(body: SoccerApp());
    }
    _color = Colors.blueAccent;
    return Container(
        color: Colors.blueAccent,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(_page.toString(), textScaleFactor: 10.0),
              ElevatedButton(
                child: Text('Go To Page of index 1'),
                onPressed: () {
                  final CurvedNavigationBarState? navBarState =
                      _bottomNavigationKey.currentState;
                  navBarState?.setPage(1);
                  getWidget();
                },
              )
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 1,
          height: 60.0,
          items: const <Widget>[
            Icon(Icons.add, size: 30),
            Icon(Icons.list, size: 30),
            Icon(Icons.perm_identity, size: 30),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: _color.withOpacity(_op),
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _page = index;
              getWidget();
            });
          },
          letIndexChange: (index) => true,
        ),
        body: Container(
          color: _color,
          child: getWidget(),
        ));
  }
}
