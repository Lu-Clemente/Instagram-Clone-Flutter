//import 'dart:ffi';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:second/json/story_json.dart';
import 'package:second/json/post_json.dart';
import 'package:second/theme/colors.dart';
import 'package:second/widgets/story_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return getBody();
  }

  Widget getBody() {
    return Column(
      children: <Widget>[
/* ===================== ADD NEW STORY ===================== */
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20, left: 15),
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 65,
                      height: 65,
                      child: Stack(children: <Widget>[
                        Container(
                          width: 65,
                          height: 65,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(profile),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 19,
                            width: 19,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: white),
                            child: Icon(Icons.add_circle,
                                color: buttonFollowColor, size: 19),
                          ),
                        )
                      ]),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: 70,
                      child: Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: white),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: List.generate(stories.length, (index) {
                  return StoryBar(
                      img: stories[index]["img"], name: stories[index]["name"]);
                }),
              ),
            ],
          ),
        ),
        Divider(
          color: white.withOpacity(0.3),
        ),
        Column(
          children: List.generate(posts.length, (index) {
            return PostItem(
              postImg: posts[index]["postImg"],
              profileImg: posts[index]["profileImg"],
              name: posts[index]["name"],
              caption: posts[index]["caption"],
              isLoved: posts[index]["isLoved"],
              commentCount: posts[index]["commentCount"],
              timeAgo: posts[index]["timeAgo"],
              likes: posts[index]["likes"],
            );
          }),
        ),
      ],
    );
  }
}

/* ===================== POSTS AREA ========================== */
class PostItem extends StatelessWidget {
  final String profileImg;
  final String name;
  final String postImg;
  final String caption;
  final String likes;
  final isLoved;
  final String commentCount;
  final String timeAgo;
  const PostItem({
    Key? key,
    required this.profileImg,
    required this.name,
    required this.postImg,
    this.isLoved,
    required this.commentCount,
    required this.timeAgo,
    required this.caption, required this.likes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

/* --------------------- Who posted -------------------------- */
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(profileImg), fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    name,
                    style: TextStyle(
                        color: white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Icon(
                Icons.more_vert,
                color: white,
              ),
            ],
          ),
        ),
        Container(
          height: 340,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(postImg), fit: BoxFit.cover),
          ),
        ),

/* ------------------------ Interations ----------------------- */
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  isLoved ? Icon(
                     Icons.favorite,
                    color: Colors.red,
                    size: 27,
                  ) : Icon(
                     Icons.favorite_border,
                    color: white,
                    size: 27,
                  ),
                  SizedBox(width: 27),
                  Icon(
                    Icons.chat_bubble_outline,
                    color: white,
                    size: 27,
                  ),
                  SizedBox(width: 27),
                  Transform.rotate(
                    angle: -math.pi / 5,
                    child: Icon(Icons.send_outlined, color: white, size: 27),
                  )
                ],
              ),
              Icon(
                Icons.bookmark_border,
                color: white,
                size: 27,
              ),
            ],
          ),
        ),

/* ---------------------------- Likes --------------------------- */
        SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: RichText(
            text: TextSpan(children: [
              TextSpan(
                  text: "$likes likes",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  )),
            ]),
          ),
        ),

/* ------------------------ Photo's description ----------------------- */
        SizedBox(height: 12),
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: RichText(
            text: TextSpan(children: [
              TextSpan(
                text: "$name ",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextSpan(
                text: "$caption",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ]),
          ),
        ),

/* ----------------------- Comments -------------------------- */
        SizedBox(
          height: 12,
        ),
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Text(
            "View all $commentCount comments",
            style: TextStyle(
                color: white.withOpacity(0.3),
                fontSize: 15,
                fontWeight: FontWeight.w500),
          ),
        ),

/* ----------------------- Post date -------------------------- */
        SizedBox(
          height: 12,
        ),
        Padding(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Text(
            "$timeAgo",
            style: TextStyle(
                color: white.withOpacity(0.3),
                fontSize: 15,
                fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}