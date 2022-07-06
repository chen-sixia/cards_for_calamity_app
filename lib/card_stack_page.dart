// import 'package:example/content.dart';
import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';

// import 'data/card.dart';
import 'content.dart';
// import 'parse_cards.dart';

class CardStackPage extends StatefulWidget {
  CardStackPage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _CardStackPageState createState() => _CardStackPageState();
}

class _CardStackPageState extends State<CardStackPage> {
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final List<String> _cards = [
    "Silence.",
    "The illusion of choice in a late-stage capitalist society.",
    "Many bats.",
    "Famine.",
    "Flesh-eating bacteria.",
    "Flying sex snakes.",
    "Not giving a shit about the Third World.",
    "Magnets.",
    "Shapeshifters.",
  ];

  @override
  void initState() {
    const duration = Duration(milliseconds: 500);
    for (int i = 0; i < _cards.length; i++) {
      _swipeItems.add(
        SwipeItem(
          content: Content(text: _cards[i], color: Colors.white),
          likeAction: () {
            _scaffoldKey.currentState?.showSnackBar(SnackBar(
              content: Text("Liked ${_cards[i]}"),
              duration: duration,
            ));
          },
          nopeAction: () {
            _scaffoldKey.currentState?.showSnackBar(SnackBar(
              content: Text("Nope ${_cards[i]}"),
              duration: duration,
            ));
          },
          // superlikeAction: () {
          //   _scaffoldKey.currentState?.showSnackBar(SnackBar(
          //     content: Text("Superliked ${_cards[i]}"),
          //     duration: duration,
          //   ));
          // },
          // onSlideUpdate: (SlideRegion? region) async {
          //   print("Region $region");
          // },
        ),
      );
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 500);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Cards For Calamity'),
        centerTitle: true,
      ),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('home'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('card list'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xFFD5B9DF),
              Color(0xFF8EB0C9),
            ],
            stops: [
              0.0,
              1.0,
            ],
          ),
        ),
        child: Column(children: [
          const Spacer(flex: 1),
          Center(
            child: SizedBox(
              width: 250,
              height: 350,
              child: SwipeCards(
                matchEngine: _matchEngine!,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                        width: 3.0,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        _swipeItems[index].content.text,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
                onStackFinished: () {
                  _scaffoldKey.currentState!.showSnackBar(
                    const SnackBar(
                      content: Text("Stack Finished"),
                      duration: duration,
                    ),
                  );
                },
                itemChanged: (SwipeItem item, int index) {
                  print("item: ${item.content.text}, index: $index");
                },
                upSwipeAllowed: true,
                fillSpace: true,
              ),
            ),
          ),
          const Spacer(flex: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FloatingActionButton(
                elevation: 1,
                splashColor: const Color(0xFF4C5966),
                onPressed: () {
                  _matchEngine!.currentItem?.nope();
                },
                child: const Text(
                  "Nope",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FloatingActionButton(
                elevation: 1,
                splashColor: const Color(0xFF4C5966),
                onPressed: () {
                  _matchEngine!.currentItem?.like();
                },
                child: const Text(
                  "Like",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
          const Spacer(flex: 1),
        ]),
      ),
    );
  }
}
