import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// ignore: use_key_in_widget_constructors
class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  List users = [];
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchUser();
  }

  fetchUser() async {
    setState(() {
      isLoading = true;
    });
    var url = "https://api.first.org/data/v1/news";
    var response = await http.get(Uri.parse(url));
    // print(response.body);
    if (response.statusCode == 200) {
      var items = json.decode(response.body)['data'];
      setState(() {
        users = items;
        isLoading = false;
      });
    } else {
      users = [];
      isLoading = false;
    }
  }

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'HOME PAGE',
      style: optionStyle,
    ),
    Text(
      'COURSE PAGE',
      style: optionStyle,
    ),
    Text(
      'CONTACT GFG',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News"),
      ),
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            title: Text('News'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Favs'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        onTap: _onItemTapped,
      ),
    );
  }

  Widget getBody() {
    // ignore: prefer_is_empty
    if (users.contains(null) || users.length < 0 || isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return getCard(users[index]);
        });
  }

  Widget getCard(item) {
    var title = item['title'];
    var summary = item['summary'];
    var published = item['published'];
    // ignore: sized_box_for_whitespace
    return Container(
      height: 100,
      child: Card(
        elevation: 1.5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListTile(
            leading: const Icon(
              Icons.favorite_border_outlined,
              color: Colors.black,
              size: 34.0,
            ),
            title: Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  summary.toString(),
                  style: const TextStyle(color: Colors.black),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  published.toString(),
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            isThreeLine: true,

            // Row(
            //   children: <Widget>[
            //     const SizedBox(
            //       width: 20,
            //     ),
            //     Column(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: <Widget>[
            //         SizedBox(
            //           width: MediaQuery.of(context).size.width - 140,
            //           child: Text(
            //             title,
            //             overflow: TextOverflow.ellipsis,
            //             style: const TextStyle(
            //                 fontSize: 15, fontWeight: FontWeight.bold),
            //           ),
            //         ),
            //         SizedBox(
            //           height: MediaQuery.of(context).size.height,
            //           width: MediaQuery.of(context).size.width - 140,
            //           child: Text(
            //             summary.toString(),
            //             style: const TextStyle(color: Colors.black),
            //             maxLines: 2,
            //             overflow: TextOverflow.ellipsis,
            //           ),
            //         ),
            //         SizedBox(
            //           height: MediaQuery.of(context).size.height,
            //           width: MediaQuery.of(context).size.width - 140,
            //         ),
            //         Text(
            //           published.toString(),
            //           style: const TextStyle(color: Colors.grey),
            //         ),
            //       ],
            //     )
            //   ],
            // ),
          ),
        ),
      ),
    );
  }
}
