import 'package:flutter/material.dart';

import 'package:food_swipes/Pages/SearchResults.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Swipes'),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: TextField(
                    autofocus: true,
                    controller: myController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Search recipes',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      child: Text('Search', style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      )),
                      color: Colors.amber,
                      padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 60.0),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchResults(myController.text),
                          )
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
