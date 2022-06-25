class FavoriteModel {
  bool? status;
  String? message;
  FavoriteDataModel? data;
  Map<String,dynamic>empty={
    "status": true,
    "message": null,
    "data": {
      "current_page": 4351,
      "data": [
        {
          "id": 110462,
          "product": {
            "id": 43579,
            "price": 489945,
            "old_price": 4534899,
            "discount": 045,
            "image": "https://student.valuxapps.com/storage/uploads/products/1627928936tRrKD.item_XXL_55204936_e0548058a965a.jpg",
            "name": "All-New Kindle Oasis (10th gen) - 7 Inch High-Resolution Display, Waterproof, 8 GB, Wi-Fi, Graphite",
            "description": "THE MOST ADVANCED KINDLE EVER\r\nThe all-new Kindle Oasis features our best ever 7”, 300 ppi Paperwhite display using the latest e-ink technology and a sleek ergonomic design with page turn buttons, perfect for one handed reading. \r\nIntroducing an adjustable warm light for a richer reading experience in any light."
          }
        },

      ],
      "first_page_url": "https://student.valuxapps.com/api/favorites?page=1",
      "from": 41,
      "last_page":451,
      "last_page_url": "https://student.valuxapps.com/api/favorites?page=1",
      "next_page_url": null,
      "path": "https://student.valuxapps.com/api/favorites",
      "per_page": 35,
      "prev_page_url": null,
      "to": 15,
      "total": 15
    }
  };FavoriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if(json['data'] != null ) {
      data = FavoriteDataModel.fromJson(json['data']);
    }else{
      data=FavoriteDataModel.fromJson(empty['data']);
    }
  }

}

class FavoriteDataModel {
  late List<Data> data=[];



  FavoriteDataModel.fromJson(Map<String, dynamic> json) {
      json['data'].forEach((v) {
        data.add(  Data.fromJson(v));
      });



  }


}

class Data {
 late int id;
 late Product product;


  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    Product.fromJson(json['product'])   ;
  }


}

class Product {
 late int id;
 late  dynamic price;
 late  dynamic oldPrice;
 late dynamic discount;
 late  String image;
 late String name;
 late String description;



  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }


}
