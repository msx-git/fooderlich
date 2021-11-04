import 'package:flutter/material.dart';
import 'package:fooderlich/components/recipe_thumbnail.dart';

import 'package:fooderlich/models/models.dart';

class RecipesGridView extends StatelessWidget {
  const RecipesGridView({Key? key, required this.recipes}) : super(key: key);

  final List<SimpleRecipe> recipes;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: recipes.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index){
        final simpleRecipe = recipes[index];
        return RecipeThumbnail(recipe: simpleRecipe);
      },
    );
  }
}
