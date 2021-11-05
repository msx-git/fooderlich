import 'package:flutter/material.dart';

import 'constants/fooderlich_theme.dart';
import 'models/grocery_manager.dart';
import 'pages/home_page.dart';
import 'models/models.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const Fooderlich());
}

class Fooderlich extends StatelessWidget {
  const Fooderlich({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = FooderlichTheme.light();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      title: 'Fooderlich',
      home: MultiProvider(
        providers: [
          // 2
          ChangeNotifierProvider(
            create: (context) => TabManager(),
          ),
          ChangeNotifierProvider(
            create: (context) => GroceryManager(),
          ),
        ],
        child: const Home(),
      ),
    );
  }
}
