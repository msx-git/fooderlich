import 'package:flutter/material.dart';
import 'package:fooderlich/components/grocery_tile.dart';
import 'package:fooderlich/models/grocery_manager.dart';
import 'package:fooderlich/pages/grocery_item_page.dart';

class GroceryListPage extends StatelessWidget {
  const GroceryListPage({Key? key, required this.manager}) : super(key: key);

  final GroceryManager manager;

  @override
  Widget build(BuildContext context) {
    final groceryItems = manager.groceryItems;
// 2
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
      // 4
      itemCount: groceryItems.length,
      itemBuilder: (context, index) {
        final item = groceryItems[index];
        return Dismissible(
          // 6
          key: Key(item.id),
          // 7
          direction: DismissDirection.endToStart,
          // 8
          background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              child: const Icon(Icons.delete_forever,
                  color: Colors.white, size: 50.0)),
          // 9
          onDismissed: (direction) {
            // 10
            manager.deleteItem(index);
            // 11
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${item.name} deleted')));
          },
          child:
          InkWell(
            child: GroceryTile(
                key: Key(item.id),
                item: item,
                onComplete: (change) {
                  if (change != null) {
                    manager.completeItem(index, change);
                  }
                }),
            // 2
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GroceryItemPage(
                    originalItem: item,
                    // 3
                    onUpdate: (item) {
                      // 4
                      manager.updateItem(item, index);
                      // 5
                      Navigator.pop(context);
                    },
                    // 6
                    onCreate: (item) {},
                  ),
                ),
              );
            },
          ),
        );

      },
      // 8
      separatorBuilder: (context, index) {
        return const SizedBox(height: 16.0);
      },
    );
  }
}
