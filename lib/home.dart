import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO: Style the title
      appBar: AppBar(
        title: Text(
          'Fooderlich',
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      // TODO: Style the body text
      body: Center(
        child: Text(
          'Let\'s get cooking 👩‍🍳',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );
  }
}
