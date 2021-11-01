import 'package:flutter/material.dart';
import 'package:fooderlich/constants/fooderlich_theme.dart';

class Card3 extends StatelessWidget {
  const Card3({Key? key}) : super(key: key);

  Widget customChips(String label) {
    return Chip(
      label: Text(
        label,
        style: FooderlichTheme.darkTextTheme.bodyText1,
      ),
      backgroundColor: Colors.black.withOpacity(0.5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        //padding: const EdgeInsets.all(16.0),

        constraints: const BoxConstraints.expand(
          height: 450,
          width: 350,
        ),

        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/mag2.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  )),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.book,
                    color: Colors.white,
                    size: 40.0,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Recipe Trends',
                    style: FooderlichTheme.darkTextTheme.headline2,
                  ),
                  const SizedBox(height: 30)
                ],
              ),
            ),
            Center(
              child: Wrap(
                alignment: WrapAlignment.start,
                spacing: 10,
                children: [
                  Chip(
                    label: Text('Healthy',
                        style: FooderlichTheme.darkTextTheme.bodyText1),
                    backgroundColor: Colors.black.withOpacity(0.5),
                    onDeleted: () {
                      print('delete');
                    },
                  ),
                  Chip(
                    label: Text('Vegan',
                        style: FooderlichTheme.darkTextTheme.bodyText1),
                    backgroundColor: Colors.black.withOpacity(0.5),
                    onDeleted: () {
                      print('delete');
                    },
                  ),
                  customChips('Carrots'),
                  customChips('Greens'),
                  customChips('Wheat'),
                  customChips('Pescetarian'),
                  customChips('Mint'),
                  customChips('Lemongrass'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
