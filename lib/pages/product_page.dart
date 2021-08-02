import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:we_deliver_bd/models/product.dart';
import 'package:we_deliver_bd/pages/base_page.dart';
import 'package:we_deliver_bd/provider/products_provider.dart';
import 'package:we_deliver_bd/widgets/widget_product_card.dart';

class ProductPage extends BasePage {
  ProductPage({Key key, this.categoryId}) : super(key: key);
  int categoryId;
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends BasePageState<ProductPage> {
  int _page = 1;
  ScrollController _scrollController = ScrollController();

  final _searchQuery = TextEditingController();
  Timer _debounce;

  final _sortByOptions = [
    SortBy("popularity", "Popularity", "asc"),
    SortBy("date", "Latest", "asc"),
    SortBy("price", "Price: High to Low", "desc"),
    SortBy("price", "Price: Low to High", "asc"),
  ];
//, categoryId: this.widget.categoryId.toString()
  @override
  void initState() {
    var productList = Provider.of<ProductProvider>(context, listen: false);
    productList.resetStreams();
    productList.setLoadingState(LoadMoreStatus.INITIAL);
    productList.fetchProducts(_page,
        categoryId: this.widget.categoryId.toString());

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        productList.setLoadingState(LoadMoreStatus.LOADING);
        productList.fetchProducts(++_page,
            categoryId: this.widget.categoryId.toString());
      }
    });
    //filter with category id here. has issues with debugger

    _searchQuery.addListener(_onSearchChange);
    super.initState();
  }

  _onSearchChange() {
    var productList = Provider.of<ProductProvider>(context, listen: false);

    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 2000), () {
      productList.resetStreams();
      productList.setLoadingState(LoadMoreStatus.INITIAL);
      productList.fetchProducts(_page,
          strSerarch: _searchQuery.text,
          categoryId: this.widget.categoryId.toString());
    });
  }

  @override
  Widget pageUI() {
    return _productsList();
  }

  Widget _productsList() {
    return Consumer<ProductProvider>(
      builder: (context, productsModel, child) {
        if (productsModel.allProducts != null &&
            productsModel.allProducts.length > 0 &&
            productsModel.getLoadMoreStatus() != LoadMoreStatus.INITIAL) {
          return _buildList(productsModel.allProducts,
              productsModel.getLoadMoreStatus() == LoadMoreStatus.LOADING);
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildList(List<Product> items, bool isLoadMore) {
    return Column(
      children: [
        _productFilters(),
        Flexible(
          child: GridView.count(
            shrinkWrap: true,
            controller: _scrollController,
            crossAxisCount: 2,
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            children: items.map((Product item) {
              return ProductCard(
                data: item,
              );
            }).toList(),
          ),
        ),
        Visibility(
          child: Container(
            padding: EdgeInsets.all(5),
            height: 35.0,
            width: 35.0,
            child: CircularProgressIndicator(),
          ),
          visible: isLoadMore,
        )
      ],
    );
  }

  Widget _productFilters() {
    return Container(
      height: 51,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _searchQuery,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: "Search",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none),
                fillColor: Color(0xffe6e6ec),
                filled: true,
              ),
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Container(
            decoration: BoxDecoration(
              color: Color(0xffe6e6ec),
              borderRadius: BorderRadius.circular(9.0),
            ),
            child: PopupMenuButton(
              onSelected: (sortBy) {
                var productList =
                    Provider.of<ProductProvider>(context, listen: false);
                productList.resetStreams();
                productList.setSortOrder(sortBy);
                productList.fetchProducts(_page,
                    categoryId: this.widget.categoryId.toString());
              }, // write code later
              itemBuilder: (BuildContext context) {
                return _sortByOptions.map((item) {
                  return PopupMenuItem(
                    value: item,
                    child: Container(
                      child: Text(item.text),
                    ),
                  );
                }).toList();
              },
              icon: Icon(Icons.tune),
            ),
          ),
        ],
      ),
    );
  }
} // end bracket
