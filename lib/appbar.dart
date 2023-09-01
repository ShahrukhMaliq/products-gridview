import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const double BAR_HEIGHT = 25;
const double BUTTON_CONTAINER_WIDTH = 32;
const double ICON_SIZE = 18;
const double FONT_SIZE = 12;

class MyAppBar {
  static PreferredSize create(BuildContext context, String leftTitle, String centerTitle,
      bool showBackButton, List<Widget> buttons) {
    List<Widget> widgets = [];

    if (showBackButton) {
      widgets.add(MyAppBarButton(
          icon: CupertinoIcons.back,
          onPressed: () {
            Navigator.maybePop(context);
          }));
    }

    if (leftTitle != null) {
      widgets.add(
        Expanded(
            flex: 1,
            child: Container(
                padding: EdgeInsets.only(left: 0),
                child: Text(
                  leftTitle,
                  textAlign: TextAlign.left,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.normal, fontSize: FONT_SIZE),
                ))),
      );
    }

    if (centerTitle != null) {
      widgets.add(Expanded(
          flex: 12,
          child: Text(
            centerTitle,
            textAlign: TextAlign.center,
            style:
                TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: FONT_SIZE),
          )));
    }

    if (buttons != null) {
      widgets.add(Row(mainAxisAlignment: MainAxisAlignment.end, children: buttons));
    }

    return PreferredSize(
        preferredSize: Size.fromHeight(BAR_HEIGHT),
        child: AppBar(
          title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[...widgets]),
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          bottom: PreferredSize(
              child: Container(
                color: Colors.grey,
                height: 1.0,
              ),
              preferredSize: Size.fromHeight(1.0)),
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ));
  }
}

class MyAppBarButton extends StatelessWidget {
  final IconData? icon;
  final VoidCallback? onPressed;
  final Key? key;

  const MyAppBarButton({this. key, this.icon,  this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: BUTTON_CONTAINER_WIDTH,
        margin: EdgeInsets.only(left: 2),
        child: IconButton(
            icon: Icon(this.icon),
            iconSize: ICON_SIZE,
            color: Colors.black,
            onPressed: this.onPressed));
  }
}
