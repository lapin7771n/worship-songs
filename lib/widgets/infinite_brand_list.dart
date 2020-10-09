import 'package:flutter/material.dart';
import 'package:worshipsongs/widgets/brand_content_list.dart';

class InfiniteBrandList extends StatefulWidget {
  final List<ContentForList> contentForList;
  final Function loadMoreCallback;
  final String title;
  final bool withArrow;

  const InfiniteBrandList({
    Key key,
    @required this.loadMoreCallback,
    @required this.contentForList,
    this.title,
    this.withArrow = false,
  }) : super(key: key);

  @override
  _InfiniteBrandListState createState() => _InfiniteBrandListState();
}

class _InfiniteBrandListState extends State<InfiniteBrandList> {
  bool isDataLoading = false;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      // ignore: missing_return
      onNotification: (ScrollNotification scrollInfo) {
        if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          loadMoreData();
        }
      },
      child: BrandContentList(
        title: widget.title,
        content: widget.contentForList,
        withArrow: widget.withArrow,
        contentPadding: EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 16.0,
        ),
      ),
    );
  }

  void loadMoreData() async {
    if (isDataLoading) return;
    isDataLoading = true;
    await widget.loadMoreCallback();
    isDataLoading = false;
  }
}
