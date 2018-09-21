import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: new ThemeData(
          primaryColor: Colors.red,
        ),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Intro',
        home: RandomWords());
  }
}

class RandomWordsState extends State<RandomWords> {
  @override
  final List<WordPair> _suggestions = <WordPair>[];
  final Set<WordPair> _saved = new Set<WordPair>();
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('startup Name Generator'),
        backgroundColor: Colors.red,
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      final Iterable<ListTileTheme> tiles = _saved.map((WordPair pair) {
        return new ListTileTheme(
            textColor: Colors.redAccent,
            child: ListTile(
              title: new Text(
                pair.asPascalCase,
                style: _biggerFont,
              ),
            ));
      });
      final List<Widget> divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();

      return new Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Favorites'),
        ),
        body: new ListView(children: divided),
      );
    }));
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();

        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return InkWell(
      onTap: () {},
      child: ListTileTheme(
          textColor: Colors.redAccent,
          child: ListTile(
            title: Text(
              pair.asPascalCase,
              style: _biggerFont,
            ),
            trailing: new Icon(
              alreadySaved ? Icons.favorite : Icons.favorite_border,
              color: alreadySaved ? Colors.red : null,
            ),
            onTap: () {
              setState(() {
                if (alreadySaved) {
                  _saved.remove(pair);
                } else {
                  _saved.add(pair);
                }
              });
            },
          )),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}

//import 'package:flutter/material.dart';
//
//void main() => runApp(MyApp());
//
//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    final title = 'InkWell Demo';
//
//    return MaterialApp(
//      title: title,
//      home: MyHomePage(title: title),
//    );
//  }
//}
//
//class MyHomePage extends StatelessWidget {
//  final String title;
//
//  MyHomePage({Key key, this.title}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Text(title),
//      ),
//      body: Center(child: MyButton()),
//    );
//  }
//}
//
//class MyButton extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    // The InkWell Wraps our custom flat button Widget
//    return InkWell(
//      // When the user taps the button, show a snackbar
//      onTap: () {
//        Scaffold.of(context).showSnackBar(SnackBar(
//          content: Text('Tap'),
//        ));
//      },
//      child: Container(
//        padding: EdgeInsets.all(12.0),
//        child: Text('Flat Button'),
//      ),
//    );
//  }
//}
