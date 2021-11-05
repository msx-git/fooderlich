import 'package:flutter/material.dart';
import 'package:fooderlich/models/models.dart';

class RecipeThumbnail extends StatelessWidget {
  const RecipeThumbnail({Key? key, required this.recipe}) : super(key: key);

  final SimpleRecipe recipe;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              child: Image.asset(recipe.dishImage,fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            recipe.title,
            maxLines: 1,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            recipe.duration,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}
