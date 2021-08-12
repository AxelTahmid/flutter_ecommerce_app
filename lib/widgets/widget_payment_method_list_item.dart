import 'package:flutter/material.dart';
import 'package:we_deliver_bd/models/payment_method.dart';

class PaymentMethodListItem extends StatelessWidget {
  PaymentMethodListItem({Key key, this.paymentMethod}) : super(key: key);

  PaymentMethod paymentMethod;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).accentColor,
      focusColor: Theme.of(context).accentColor,
      highlightColor: Theme.of(context).primaryColor,
      onTap: () {
        if (this.paymentMethod.isRouteRedirect) {
          Navigator.of(context).pushNamed(this.paymentMethod.route);
        } else {
          this.paymentMethod.onTap();
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Theme.of(context).focusColor.withOpacity(0.1),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).focusColor.withOpacity(0.1),
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
                image: DecorationImage(
                  image: AssetImage(paymentMethod.logo),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(width: 15),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          paymentMethod.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        Text(
                          paymentMethod.description,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Theme.of(context).focusColor,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
