import 'package:flutter/material.dart';

import '../../../../utils/categories_list.dart';

class MyCategories extends StatelessWidget {
  const MyCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 4.0,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white
                      .withOpacity(0.2), // Adjust color and opacity as needed
                  width: 0.7,
                ),
                borderRadius: BorderRadius.circular(8),
                color: Colors.white.withOpacity(0.11)),
            child: Text(
              categories[index],
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
        ),
        itemCount: categories.length,
      ),
    );
  }
}
