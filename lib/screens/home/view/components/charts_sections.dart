import 'package:flutter/material.dart';

import '../../models/charts.dart';

class Charts extends StatelessWidget {
  const Charts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Charts",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                    side: BorderSide(color: Colors.grey.shade800, width: 1),
                    minimumSize: Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize
                        .shrinkWrap, // Reduce tap target size
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onPressed: () {
                    // Define your onPressed action here
                  },
                  child: Text(
                    "More",
                    style: Theme.of(context).textTheme.headlineSmall,
                  )),
            ],
          ),
        ),
        SizedBox(
          height: 320,
          child: GridView.builder(
            itemCount: 3,
            scrollDirection: Axis.horizontal,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, childAspectRatio: 1.55),
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Container(
                    // width: 150,
                    height: 180,
                    decoration: BoxDecoration(
                        color: Color(0xff1d1d1d),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(chartsList[index].imageUrl),
                        ),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    chartsList[index].title,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    chartsList[index].subtitle,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
