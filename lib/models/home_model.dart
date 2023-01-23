class HomeModel {
  late bool status;
  late String message;

  late DataHomeModel data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = DataHomeModel.fromJson(json['data']);
  }
}

class DataHomeModel {
  late List<BannerModel> banners = [];
  late List<ProductsModel> products = [];

  DataHomeModel.fromJson(Map<String, dynamic> json) {
    json['banners'].forEach((element) {
      banners.add(BannerModel.fromJson(element));
    });
    json['products'].forEach((element) {
      products.add(ProductsModel.fromJson(element));
    });
  }
}

class BannerModel {
  late dynamic id;
  late String image;

  BannerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class ProductsModel {
  late dynamic id;
  late dynamic price;
  late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
  late bool isFavourite;
  late bool inCart;

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    id = json['price'];
    id = json['old_price'];
    id = json['discount'];
    id = json['image'];
    id = json['name'];
    id = json['in_favorites'];
    id = json['in_cart'];
  }
}
