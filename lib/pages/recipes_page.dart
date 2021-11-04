import 'package:flutter/material.dart';
import 'package:fooderlich/api/mock_fooderlich_service.dart';
import 'package:fooderlich/components/recipes_grid_view.dart';
import 'package:fooderlich/models/simple_recipe.dart';

class RecipesPage extends StatelessWidget {
  RecipesPage({Key? key}) : super(key: key);

  final exploreService = MockFooderlichService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: exploreService.getRecipes(),
      builder: (context, AsyncSnapshot<List<SimpleRecipe>> snapshot) {
        if(snapshot.connectionState == ConnectionState.done){
          // TODO: Add RecipesGridView Here
          return RecipesGridView(recipes: snapshot.data ?? []);
        }else{
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
