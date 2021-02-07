import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  DrawerTile(this.page, this.pageController, this.icon, this.text, {Key key})
      : super(key: key);

  final IconData icon;
  final String text;
  final PageController pageController;
  final int page;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
          pageController.jumpToPage(page);
        },
        child: Container(
          height: 60.0,
          child: Row(
            children: [
              Icon(
                icon,
                size: 32.0,
                color: pageController.page.round() == page
                    ? Theme.of(context).primaryColor
                    : Colors.black,
              ),
              SizedBox(
                width: 32.0,
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 16.0,
                  color: pageController.page.round() == page
                      ? Theme.of(context).primaryColor
                      : Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
