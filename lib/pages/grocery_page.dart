import 'package:flutter/material.dart';
import 'package:fooderlich/models/grocery_manager.dart';
import 'package:fooderlich/pages/empty_grocery_page.dart';
import 'package:fooderlich/pages/grocery_item_page.dart';
import 'package:provider/provider.dart';

class GroceryPage extends StatelessWidget {
  const GroceryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildGroceryPage(),
      floatingActionButton: FloatingActionButton(
        mini: true,
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
        onPressed: () {
          final manager = Provider.of<GroceryManager>(context, listen: false);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return GroceryItemPage(onCreate: (item){
                  manager.addItem(item);
                  Navigator.pop(context);
                }, onUpdate: (item){});
              },
            ),
          );
        },
      ),
    );
  }

  Widget buildGroceryPage() {
    return Consumer<GroceryManager>(
      builder: (context, manager, child) {
        if (manager.groceryItems.isNotEmpty) {
          // TODO 25: Add GroceryListScreen
          return Container();
        } else {
          return const EmptyGroceryPage();
        }
      },
    );
  }
}
