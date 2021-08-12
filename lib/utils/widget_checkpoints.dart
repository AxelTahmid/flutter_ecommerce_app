import 'package:flutter/material.dart';

class CheckPoints extends StatelessWidget {
  CheckPoints(
      {Key key,
      this.checkedTill = 1,
      this.checkPoints,
      this.checkPointFilledColor})
      : super(key: key);

  final int checkedTill;
  final List<String> checkPoints;
  final Color checkPointFilledColor;

  final double circleDia = 32;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (c, s) {
        //one extra 32 for left and right padding to check point of row
        final double cWidth =
            ((s.maxWidth - (32.0 * (checkPoints.length + 1))) /
                (checkPoints.length - 1));
        //this checkpoint.length -1 is because we have checkpoint.length -1, middle sticks
        return Container(
          height: 56,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: checkPoints.map(
                    (e) {
                      int index = checkPoints.indexOf(e);
                      print(index);
                      return Container(
                        height: circleDia,
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: circleDia,
                              padding: EdgeInsets.all(4),
                              child: Icon(
                                Icons.done,
                                color: Colors.white,
                                size: 18,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: index <= checkedTill
                                    ? checkPointFilledColor
                                    : checkPointFilledColor.withOpacity(0.2),
                              ),
                            ),
                            index != (checkPoints.length - 1)
                                ? Container(
                                    color: index < checkedTill
                                        ? checkPointFilledColor
                                        : checkPointFilledColor
                                            .withOpacity(0.2),
                                    height: 4,
                                    width: cWidth,
                                  )
                                : Container(),
                          ],
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: checkPoints.map(
                    (e) {
                      return Text(
                        e,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
