import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_deliver_bd/models/cart_request_model.dart';
import 'package:we_deliver_bd/models/product.dart';
import 'package:we_deliver_bd/provider/cart_provider.dart';
import 'package:we_deliver_bd/provider/loader_provider.dart';
import 'package:we_deliver_bd/utils/custom_stepper.dart';
import 'package:we_deliver_bd/utils/expand_text.dart';
import 'package:we_deliver_bd/widgets/widget_related_products.dart';

class ProductDetailsWidget extends StatelessWidget {
  ProductDetailsWidget({Key key, this.data}) : super(key: key);

  Product data;
  int qty = 0;

  CartProducts cartProducts = CartProducts();
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                productImages(data.images, context),
                SizedBox(height: 10),
                Visibility(
                  visible: data.calculateDiscount() > 0,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(color: Colors.green),
                      child: Text(
                        '${data.calculateDiscount()}% OFF',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  data.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      //test out later for results. currently not showing
                      data.attributes != null && data.attributes.length > 0
                          ? (data.attributes[0].options.join("-").toString() +
                              "" +
                              data.attributes[0].name)
                          : "",
                    ),
                    Text(
                      '${data.salePrice}৳',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomStepper(
                      lowerLimit: 0,
                      upperLimit: 20,
                      stepValue: 1,
                      iconSize: 22.0,
                      value: this.qty,
                      onChanged: (value) {
                        cartProducts.quantity = value;
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        Provider.of<LoaderProvider>(context, listen: false)
                            .setLoadingStatus(true);
                        var cartProvider =
                            Provider.of<CartProvider>(context, listen: true);
                        cartProducts.productId = data.id;
                        cartProvider.addToCart(
                          cartProducts,
                          (val) {
                            Provider.of<LoaderProvider>(context, listen: false)
                                .setLoadingStatus(false);
                          },
                        );
                      },
                      child: Text(
                        "Add to Cart",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        padding: EdgeInsets.all(15),
                        shape: StadiumBorder(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                ExpandText(
                  labelHeader: "Product Details",
                  desc: data.description,
                  shortDesc: data.shortDescription,
                ),
                Divider(),
                SizedBox(height: 10),
                WidgetRelatedProducts(
                  //filter for related isnt working
                  labelName: "Related Items",
                  products: this.data.relatedIds,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget productImages(List<Images> images, BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 250,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            child: CarouselSlider.builder(
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Center(
                    child: Image.network(
                      // images[index].src,
                      images != null
                          ? images[index].src
                          : "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/1200px-No_image_available.svg.png",
                      height: 160,
                      fit: BoxFit.fill,
                    ),
                  ),
                );
              },
              options: CarouselOptions(
                autoPlay: false,
                enlargeCenterPage: true,
                viewportFraction: 1,
                aspectRatio: 1.0,
              ),
              carouselController: _controller,
            ),
          ),
          Positioned(
            top: 100,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                _controller.previousPage();
              },
            ),
          ),
          Positioned(
            top: 100,
            left: MediaQuery.of(context).size.width - 80,
            child: IconButton(
              icon: Icon(Icons.arrow_forward_ios),
              onPressed: () {
                _controller.nextPage();
              },
            ),
          ),
        ],
      ),
    );
  }
}
