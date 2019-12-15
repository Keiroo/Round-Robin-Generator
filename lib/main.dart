import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Round-robin tournament generator',
      theme: ThemeData(
        primaryColor: Colors.lightBlue,
        secondaryHeaderColor: Colors.greenAccent,
      ),
      home: HomeWidget(),
    );
  }
}

class HomeWidgetState extends State<HomeWidget> {
  double _teamsCounter = 5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Round-robin tournament generator'),
      ),
      body: Center(
        child: _buildTeamCounter(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward_ios),
        onPressed: _pushNavigator,
      ),
    );
  }

  void _pushNavigator() {
    final List<ListTile> _matches = _generateMatches();
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: Text(_matches.length.toString() + ' matches'),
          ),
          body: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: _matches.length,
            itemBuilder: (context, i) {
              //if (i.isOdd) return Divider();
              int index = i;
              // int index = i ~/ 2;
              final match = _matches[index];
              return Dismissible(
                  key: Key(match.title.toString()),
                  child: match,
                  background: Container(
                    color: Colors.redAccent,
                    padding: const EdgeInsets.all(8.0),
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.delete),
                  ),
                  onDismissed: (direction) {
                    setState(() => _matches.removeAt(index));
                    final int matchIndex = index + 1;
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("Match $matchIndex dismissed")));
                  });
            },
          ));
    }));
  }

  List<ListTile> _generateMatches() {
    List<ListTile> _widgetsList = new List<ListTile>();
    List<String> _teams = new List<String>();
    int _teamCount = _teamsCounter.toInt();

    for (var i = 0; i <= _teamCount; i++) {
      if (i < _teamCount) {
        _teams.add((i + 1).toString());
      } else if (_teamCount.isOdd) {
        _teams.add('bye');
      }
    }

    for (var j = 0; j < _teams.length - 1; j++) {
      for (var i = 0; i < _teams.length ~/ 2; i++) {
        if (_teams[i] != 'bye' && _teams[_teams.length ~/ 2 + i] != 'bye') {
          _widgetsList.add(ListTile(
            title: Text(_teams[i] + ' vs ' + _teams[_teams.length ~/ 2 + i]),
          ));
        }
      }
      _teams.insert(1, _teams.last);
      _teams.removeLast();
    }

    return _widgetsList;
  }

  // Widget _getMatch(String matchTitle) {
  //   return Dismissible(
  //     key: Key(matchTitle),
  //   );

  //   // ListTile(
  //   //   title: Text(matchTitle,
  //   //   style: Theme.of(context).textTheme.display1,),

  //   // );
  // }

  Widget _buildTeamCounter() {
    Widget _getSlider() {
      return Slider(
        divisions: 8,
        max: 12,
        value: _teamsCounter,
        min: 4,
        onChanged: (value) {
          setState(() => _teamsCounter = value);
        },
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _teamsCounter.toInt().toString(),
              style: Theme.of(context).textTheme.display1,
            ),
            _getSlider(),
          ],
        ),
      ),
    );
  }
}

class HomeWidget extends StatefulWidget {
  HomeWidgetState createState() => HomeWidgetState();
}

// class RandomWordState extends State<RandomWords> {
//   final _suggestions = <WordPair>[];
//   final _biggerFont = const TextStyle(fontSize: 18.0);
//   final Set<WordPair> _saved = Set<WordPair>();
//   void _pushSaved() {
//     Navigator.of(context).push(
//       MaterialPageRoute<void>(builder: (BuildContext context) {
//         final Iterable<ListTile> tiles = _saved.map(
//           (WordPair pair) {
//             return ListTile(
//               title: Text(
//                 pair.asPascalCase,
//                 style: _biggerFont,
//               ),
//             );
//           },
//         );
//         final List<Widget> divided = ListTile.divideTiles(
//           context: context,
//           tiles: tiles,
//         ).toList();
//         return Scaffold(
//           appBar: AppBar(
//             title: Text('Saved suggestions'),
//           ),
//           body: ListView(children: divided),
//         );
//       }),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Startup Name Generator'),
//         actions: <Widget>[
//           IconButton(icon: Icon(Icons.list), onPressed: _pushSaved)
//         ],
//       ),
//       body: _buildSuggestions(),
//     );
//   }

//   Widget _buildSuggestions() {
//     return ListView.builder(
//       padding: const EdgeInsets.all(16.0),
//       itemBuilder: (context, i) {
//         if (i.isOdd) return Divider();
//         final index = i ~/ 2;
//         if (index >= _suggestions.length) {
//           _suggestions.addAll(generateWordPairs().take(10));
//         }
//         return _buildRow(_suggestions[index]);
//       },
//     );
//   }

//   Widget _buildRow(WordPair pair) {
//     final bool alreadySaved = _saved.contains(pair);
//     return ListTile(
//       title: Text(
//         pair.asPascalCase,
//         style: _biggerFont,
//       ),
//       trailing: Icon(
//         alreadySaved ? Icons.favorite : Icons.favorite_border,
//         color: alreadySaved ? Colors.red : null,
//       ),
//       onTap: () {
//         setState(() {
//           if (alreadySaved) {
//             _saved.remove(pair);
//           } else {
//             _saved.add(pair);
//           }
//         });
//       },
//     );
//   }
// }

// class RandomWords extends StatefulWidget {
//   @override
//   RandomWordState createState() => RandomWordState();
// }
