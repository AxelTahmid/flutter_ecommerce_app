import 'package:flutter/cupertino.dart';
import 'package:we_deliver_bd/api_service.dart';
import 'package:we_deliver_bd/models/product.dart';

class SortBy {
  String value;
  String text;
  String sortOrder;

  SortBy(this.value, this.text, this.sortOrder);
}

enum LoadMoreStatus { INITIAL, LOADING, STABLE }

class ProductProvider with ChangeNotifier {
  APIService _apiService;
  List<Product> _productList;
  SortBy _sortBy;
  int pageSize = 10;

  List<Product> get allProducts => _productList;
  double get totalRecords => _productList.length.toDouble();

  LoadMoreStatus _loadMoreStatus = LoadMoreStatus.STABLE;

  getLoadMoreStatus() => _loadMoreStatus;

  ProductProvider() {
    resetStreams();
    _sortBy = SortBy("price", "Low to High", "asc");
  }

  void resetStreams() {
    _apiService = APIService();
    _productList = [];
  }

  setLoadingState(LoadMoreStatus loadMoreStatus) {
    _loadMoreStatus = loadMoreStatus;
    //notifyListeners();
  }

  setSortOrder(SortBy sortBy) {
    _sortBy = sortBy;
    //notifyListeners();
  }

  fetchProducts(pageNumber,
      {String strSerarch,
      String tagName,
      String categoryId,
      String sortBy,
      String sortOder = "asc"}) async {
    List<Product> itemModel = await _apiService.getProducts(
      strSearch: strSerarch,
      tagName: tagName,
      pageNumber: pageNumber,
      pageSize: this.pageSize,
      categoryId: categoryId,
      sortBy: this._sortBy.value,
      sortOrder: this._sortBy.sortOrder,
    );

    if (itemModel.length > 0) {
      _productList.addAll(itemModel);
    }

    setLoadingState(LoadMoreStatus.STABLE);
    //notifyListeners();
  }
}
