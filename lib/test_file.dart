import 'package:flutter/material.dart';

import 'material/constants.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          TransitionAppBar(
            extent: 250,
            avatar: Text('DR. Magdy Ebrahim'),
            // title: Container(
            //   margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
            //   decoration: BoxDecoration(
            //       color: Colors.grey[200],
            //       borderRadius: BorderRadius.all(Radius.circular(5.0))),
            //   child: Row(children: <Widget>[
            //     Padding(
            //       padding: EdgeInsets.only(left: 20.0, right: 10.0),
            //       child: Icon(Icons.search),
            //     ),
            //     Expanded(
            //       child: TextFormField(
            //         keyboardType: TextInputType.text,
            //         textInputAction: TextInputAction.done,
            //         cursorColor: Colors.black,
            //         autofocus: false,
            //         decoration: InputDecoration(
            //             filled: true,
            //             fillColor: Colors.transparent,
            //             contentPadding:
            //             EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            //             hintText: "Search",
            //             border: InputBorder.none,
            //             disabledBorder: OutlineInputBorder(
            //               borderSide: new BorderSide(color: Colors.transparent),
            //               borderRadius: new BorderRadius.circular(2),
            //             ),
            //             focusedBorder: OutlineInputBorder(
            //               borderSide: new BorderSide(color: Colors.transparent),
            //               borderRadius: new BorderRadius.circular(2),
            //             )),
            //       ),
            //     )
            //   ]),
            // ),
            title: Padding(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: Text(
                    'Dr. MagdyEbrahim',
                  )),
                  IconButton(
                      icon: Icon(
                        Icons.favorite_border,
                        color: darkBlueColor.withOpacity(.7),
                        size: 18,
                      ),
                      onPressed: () {}),
                ],
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            return Container(
                color: Colors.blue,
                child: ListTile(
                  title: Text("${index}a"),
                ));
          }, childCount: 25))
        ],
      ),
    );
  }
}

class TransitionAppBar extends StatelessWidget {
  final Widget avatar;
  final Widget title;
  final double extent;

  TransitionAppBar({this.avatar, this.title, this.extent = 250, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _TransitionAppBarDelegate(
          avatar: avatar, title: title, extent: extent > 200 ? extent : 200),
    );
  }
}

class _TransitionAppBarDelegate extends SliverPersistentHeaderDelegate {
  final _avatarMarginTween = EdgeInsetsTween(
      begin: EdgeInsets.only(bottom: 70, left: 30),
      end: EdgeInsets.only(left: 0.0, top: 30.0));
  final _avatarAlignTween =
      AlignmentTween(begin: Alignment.bottomLeft, end: Alignment.topCenter);

  final Widget avatar;
  final Widget title;
  final double extent;

  _TransitionAppBarDelegate({this.avatar, this.title, this.extent = 250})
      : assert(avatar != null),
        assert(extent == null || extent >= 200),
        assert(title != null);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double tempVal = 34 * maxExtent / 100;
    final progress = shrinkOffset > tempVal ? 1.0 : shrinkOffset / tempVal;
    print("Objechjkf === $progress $shrinkOffset");
    final avatarMargin = _avatarMarginTween.lerp(progress);
    final avatarAlign = _avatarAlignTween.lerp(progress);
    return Stack(
      children: <Widget>[
        AnimatedContainer(
          duration: Duration(milliseconds: 100),
          height: shrinkOffset * 2,
          constraints: BoxConstraints(maxHeight: minExtent),
          color: Colors.redAccent,
        ),
        Padding(
          padding: avatarMargin,
          child: Align(alignment: avatarAlign, child: avatar),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: title,
          ),
        )
      ],
    );
  }

  @override
  double get maxExtent => extent;

  @override
  double get minExtent => (maxExtent * 68) / 100;

  @override
  bool shouldRebuild(_TransitionAppBarDelegate oldDelegate) {
    return avatar != oldDelegate.avatar || title != oldDelegate.title;
  }
}
