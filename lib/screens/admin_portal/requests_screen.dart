import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:worshipsongs/app_colors.dart';
import 'package:worshipsongs/localizations/strings.dart';

class RequestsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(Strings.of(context).requests),
          actions: [
            Ink(
              decoration: ShapeDecoration(
                shape: CircleBorder(),
                color: Color(0xFFFAFAFA),
              ),
              child: IconButton(
                icon: SvgPicture.asset(
                  'assets/images/Archive.svg',
                ),
                onPressed: () {},
              ),
            ),
          ],
          bottom: TabBar(
            isScrollable: true,
            labelPadding: EdgeInsets.only(
              left: 24,
              right: 24,
            ),
            unselectedLabelColor: AppColors.black,
            labelColor: AppColors.blue,
            indicatorColor: AppColors.blue,
            labelStyle: Theme.of(context).textTheme.headline5,
            tabs: [
              Tab(text: Strings.of(context).all),
              Tab(text: Strings.of(context).lyrics),
              Tab(text: Strings.of(context).albums(10)),
              Tab(text: Strings.of(context).artists(10)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Tab(text: Strings.of(context).all),
            Tab(text: Strings.of(context).lyrics),
            Tab(text: Strings.of(context).albums(1)),
            Tab(text: Strings.of(context).artists(1)),
          ],
        ),
      ),
    );
  }
}
