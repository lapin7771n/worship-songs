import 'package:flutter/material.dart';
import 'package:worshipsongs/widgets/brand_list_item.dart';
import 'package:worshipsongs/widgets/sorted_list_headline.dart';

class BrandContentList extends StatelessWidget {
  final String title;
  final List<ContentForList> content;
  final EdgeInsets contentPadding;
  final bool withArrow;

  const BrandContentList({
    this.title,
    @required this.content,
    this.contentPadding,
    this.withArrow = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (item, index) {
        if (index == content.length) {
          return buildLoadingIndicator();
        }

        final previousContent = index > 0 ? content[index - 1] : null;
        final currentContent = content[index];

        Widget header;
        if (previousContent == null ||
            !_isFirstLetterEqual(currentContent, previousContent)) {
          header = _buildHeader(currentContent, context);
        }

        return Column(
          children: [
            if (index == 0 && title != null) buildTitle(context),
            if (header != null) header,
            BrandListItem(
              title: currentContent.title,
              subtitle: currentContent.subtitle,
              chipText: currentContent.chipText,
              imageUrl: currentContent.imageUrl,
              onTap: currentContent.onTap,
              contentPadding: contentPadding,
              withArrow: withArrow,
            ),
          ],
        );
      },
      itemCount: content.length + 1,
    );
  }

  Widget buildLoadingIndicator() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildHeader(ContentForList currentSong, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 32),
      child: SortedListHeadline(text: currentSong.title.substring(0, 1)),
    );
  }

  Widget buildTitle(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.only(
          top: 16.0,
          left: 16.0,
          right: 16.0,
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
    );
  }

  bool _isFirstLetterEqual(
      ContentForList currentSong, ContentForList previousSong) {
    return currentSong.title.substring(0, 1) ==
        previousSong.title.substring(0, 1);
  }
}

class ContentForList {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String chipText;
  final Function onTap;

  ContentForList({
    this.imageUrl,
    this.title,
    this.subtitle,
    this.chipText,
    this.onTap,
  });
}
