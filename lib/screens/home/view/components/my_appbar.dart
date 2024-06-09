import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../provider/home.dart';
import 'my_categories.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    super.key,
    required this.homeProvider,
  });
  final HomeProvider homeProvider;
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      primary: true,
      backgroundColor: Colors.black,
      toolbarHeight: !homeProvider.hasScrolled ? 80 : 70,
      pinned: true,

      expandedHeight: 130,
      flexibleSpace: FlexibleSpaceBar(
        title: MyCategories(),
        titlePadding:
            EdgeInsets.symmetric(vertical: !homeProvider.hasScrolled ? 5 : 10),
        expandedTitleScale: 1,
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff0F2634),
                Color(0xff0E163B),
                Color(0xff0E163B),
              ],
            ),
          ),
        ),
      ),
      // backgroundColor: Colors.transparent,
      title: !homeProvider.hasScrolled
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/icons/Youtube_Music_icon.svg",
                  height: 25,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Music",
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              ],
            )
          : null,
      actions: [
        !homeProvider.hasScrolled
            ? Row(
                children: [
                  IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: Icon(
                        Icons.notifications_none,
                        color: Colors.grey,
                      )),
                  IconButton(
                      // padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: Icon(
                        Icons.search,
                        color: Colors.grey,
                      )),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    height: 27,
                    width: 27,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.brown,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      "A",
                      style: TextStyle(
                          fontFamily: "EuclidRegular",
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ),
                ],
              )
            : Container()
      ],

      // bottom: PreferredSize(
      //     preferredSize: Size.fromHeight(40), child: MyCategories()),
    );
  }
}
