import 'package:flutter/material.dart';
import 'package:second/json/search_json.dart';
import 'package:second/theme/colors.dart';
import 'package:second/widgets/story_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return getBody();
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    return /*SingleChildScrollView(
      child: Row(
        children: <Widget>[*/
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          Wrap(
            spacing: 1,
            runSpacing: 1,
            children: List.generate(searchImages.length, (index) {
              return Container(
                  width: (size.width-3)/3,
                  height: (size.width-3)/3,
                  decoration: BoxDecoration(image: DecorationImage(
                    image: NetworkImage(searchImages[index]),
                    fit:BoxFit.cover,
                    ),
                    ),
                );
            }),
          ),
              ],
            ),
        );
  }
}
