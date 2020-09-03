import 'package:flutter/material.dart';

class GenericListItem extends StatelessWidget {
  final BuildContext context;
  final String heading;
  final int trailing;
  final Widget iconData;
  final VoidCallback onTap;
  final Widget forwordIconData;

  GenericListItem({
    Key key,
    @required this.context,
    @required this.heading,
    this.trailing,
    @required this.iconData,
    @required this.forwordIconData,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (heading == '') {
      return Container();
    } else {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.fromLTRB(10.0, .0, 10.0, 5.0),
          //margin: EdgeInsets.only(top:getHeight(context)*0.75*0.05),
          height: getHeight(context) * 0.75 / 6.8,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 2.0)],
              borderRadius: BorderRadius.circular(4)),
          child: ListTile(
            contentPadding: EdgeInsets.fromLTRB(
                5.0, getHeight(context) * 0.3 * 0.05, 10.0, 1.0),
            isThreeLine: false,
            leading: Container(
              //decoration: BoxDecoration(color: Colors.white,boxShadow: [BoxShadow(color: Colors.blue,blurRadius: 2.0)]),
              height: getHeight(context) * 0.3 / 7.2,
              width: getWidth(context) * 0.7 * 0.25,
              child: this.iconData,
            ),
            title: Text(heading,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                )),
            trailing: Container(
              //decoration: BoxDecoration(color: Colors.white,boxShadow: [BoxShadow(color: Colors.blue,blurRadius: 2.0)]),
              height: getHeight(context) * 0.9 / 7.2,
              width: getWidth(context) * 0.7 * 0.25,
              child: this.forwordIconData,
            ),
          ),
        ),
      );
    }
  }

  Widget getTrailing() {
    if (this.trailing == null) {
      return Container(
        width: 1.0,
        height: 1.0,
      );
    }

    if (this.trailing > 0) {
      return CircleAvatar(
        radius: 14.0,
        backgroundColor: Colors.green,
        child: Text(
          this.trailing.toString(),
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      );
    } else {
      return Container(
        width: 1.0,
        height: 1.0,
      );
    }
  }

  double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  Widget _getLeading(IconData iconData) {
    return Icon(iconData, color: Colors.green, size: 32);
  }

  Widget _buildDateRow() {
    return Row(
      children: <Widget>[
        Icon(
          Icons.home,
          size: 13,
          color: Colors.grey,
        ),
        SizedBox(width: 2),
        Flexible(
          child: FittedBox(
            child: Text(''),
          ),
        ),
      ],
    );
  }
}
