import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './MatchCard.dart';
import 'BottomSheetCustom.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Rent a Care'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: _getBackgroundColor(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(
              Icons.navigate_before,
              color: _getTextColor(),
            ),
            Text(
              'Explore',
              style: TextStyle(
                  color: _getTextColor(), fontWeight: FontWeight.w600),
            ),
            Icon(
              Icons.search,
              color: _getTextColor(),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CardListState(),
          Container(
            padding: EdgeInsets.all(15.0),
            margin: EdgeInsets.only(bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 10.0),
                  height: 60.0,
                  width: 60.0,
                  child: FloatingActionButton(
                    elevation: 3,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.not_interested,
                      color: Colors.red,
                    ),
                    onPressed: () {

                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 10.0),
                  height: 90.0,
                  width: 90.0,
                  child: FloatingActionButton(
                    elevation: 3,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.done,
                      color: Colors.black45,
                    ),
                    onPressed: () {},
                  ),
                ),
                Container(
                  height: 60.0,
                  width: 60.0,
                  child: FloatingActionButton(
                    elevation: 3,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.bookmark,
                      color: Colors.green,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CardListState extends StatefulWidget {
  @override
  _CardListStateState createState() => _CardListStateState();
}

class _CardListStateState extends State<CardListState> {
  List<Widget> cardList = new List();
  List<MatchCard> cards = new List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    cards.add(MatchCard(
        "Volvo",
        "Currently avilable",
        "assets/volvo.jpg",
        30,
        4,
        10,
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book"));
    cards.add(MatchCard(
        "Ford",
        "Currently avilable",
        "assets/Ford.jpg",
        40,
        6,
        20,
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book"));
    cards.add(MatchCard(
        "Nissan GTR",
        "Currently avilable",
        "assets/GTR.jpg",
        25,
        3,
        20,
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book"));
  }

  _removeCard(index) {
    setState(() {
      cards.removeAt(index);
      cardList.removeLast();
    });
  }

  @override
  Widget build(BuildContext context) {
    cardList.clear();
    cards.asMap().forEach((index, cardw) {
      cardList.add(
        ConstrainedBox(
          constraints: BoxConstraints(
              minHeight: 100.0, minWidth: 100.0, maxHeight: 380.0),
          child: Draggable(
            childWhenDragging: Container(),
            onDragEnd: (details) {
              if (details.offset.dx > 150 || details.offset.dx < -150) {
                if (index != 0) {
                  _removeCard(index);
                }
              }
            },
            child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 231, 234, 238),
                      spreadRadius: 2,
                      blurRadius: 5,
                    )
                  ]),
              child: GestureDetector(
                onTap: () {
                  _showCardDetailsSheet(context, cardw);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: MediaQuery.of(context).size.width - 40,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: <Widget>[
                              Text(
                                cardw.name,
                                style: TextStyle(
                                    color: _getTextColor(),
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                cardw.available,
                                style: TextStyle(
                                    fontSize: 25.0,
                                    color: Colors.lightGreen,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          cardw.imgSrc,
                          fit: BoxFit.contain,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    "\$${cardw.price}",
                                    style: TextStyle(
                                        color: _getTextColor(),
                                        fontWeight: FontWeight.w800,
                                        fontSize: 20.0),
                                  ),
                                  Text('/day',
                                      style: TextStyle(
                                          color: _getTextColor(),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 20.0))
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Icon(Icons.person),
                                  Text("${cardw.poeple}",
                                      style: TextStyle(
                                          color: _getTextColor(),
                                          fontWeight: FontWeight.w800,
                                          fontSize: 20.0)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            feedback: Container(
              height: 500,
              width: MediaQuery.of(context).size.width - 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: MediaQuery.of(context).size.width - 40,
                  color: Colors.white,
                  child: Image.asset(
                    cardw.imgSrc,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });

    return Center(
      child: Stack(
        children: cardList,
      ),
    );
  }
}

Color _getBackgroundColor() {
  return Color.fromARGB(255, 248, 249, 253);
}

Color _getTextColor() {
  return Color.fromARGB(255, 29, 39, 64);
}

_showCardDetailsSheet(context, MatchCard cardw) {
  return showModalBottomSheetCustom(
      context: context,
      builder: (BuildContext bc) {
        return SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.black45),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              cardw.name,
                              style: TextStyle(
                                  color: _getTextColor(),
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              cardw.available,
                              style: TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.lightGreen,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.not_interested,
                            color: Colors.redAccent,
                          ),
                          Icon(
                            Icons.bookmark,
                            color: Colors.green,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  cardw.imgSrc,
                  fit: BoxFit.contain,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            "\$${cardw.price}",
                            style: TextStyle(
                                color: _getTextColor(),
                                fontWeight: FontWeight.w800,
                                fontSize: 20.0),
                          ),
                          Text('/day',
                              style: TextStyle(
                                  color: _getTextColor(),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20.0))
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Icon(Icons.person),
                          Text("${cardw.poeple}",
                              style: TextStyle(
                                  color: _getTextColor(),
                                  fontWeight: FontWeight.w800,
                                  fontSize: 20.0)),
                        ],
                      ),
                    ],
                  ),
                ),
                Text(cardw.desc),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: RaisedButton(
                          color: _getTextColor(),
                          child: Text(
                            'Rent this vechile',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {},
                        ),
                      )),
                ),
              ],
            ),
          ),
        );
      });
}
