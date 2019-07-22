import 'package:flutter/material.dart';

import 'package:food_swipes/Api/EdamamApiFetch.dart';
import 'package:food_swipes/Api/ApiResponse.dart';

class SearchResults extends StatelessWidget {
  final String query;

  SearchResults(this.query);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Food Swipes'),
      ),
      body: Center(
        child: Container(
          child: FutureBuilder<List<ApiResponse>>(
            future: fetchResponse(query),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Image.network(snapshot.data[index].res["recipe"]["image"], height: 100.0,),
                            Text(snapshot.data[index].res["recipe"]["label"].toString()),
                          ],
                        ),
                        Divider(),
                      ],
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
