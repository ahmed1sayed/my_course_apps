class ShopModel{
late bool status;
//late String message;
late ShopDataModel data;
Map<String,dynamic>empty={
  "status": false,
  "message": null,
  "data": {
    "banners": [

      {
        "id": 26,
        "image": "no image",
        "category": null,
        "product": null
      }
    ],
    "products": [

      {
        "id": 91,
        "price": 404,
        "old_price": 692,
        "discount": 42,
        "image": "https://student.valuxap18pTaSB.10.jpg",
        "name": "جاكيت رجا بلون موحد",
        "description": "الطول: بأكمام)",
        "images": [
          "https://cts/1644374518j1Fb5.10.jpg",
          "https:ads/products/1644374518J6Ymx.11.jpg",
          "https://studentads/products/1644374518W2nLz.12.jpg",
          "https://student.DLfk.13.jpg"
        ],
        "in_favorites": false,
        "in_cart": false
      }
    ],
    "ad": "no add"
  }
};

  ShopModel(this.status, this.data, this.empty);

  ShopModel.fromJson(Map<String,dynamic>json){
   status=json['status'];
   //message=json['message']??'no message';
   data=json['data']!=null?ShopDataModel.fromJson(json['data']):ShopDataModel.fromJson(empty['data']);
}
}
class ShopDataModel{
   List<BannerModel> banners=[];
    List<ProductModel> products=[];
  late String ad;
  ShopDataModel.fromJson(Map<String,dynamic>json){
    json['banners'].forEach((element)=>
      banners.add( BannerModel.fromJson( element)));

    json['products'].forEach((element)=>
     products.add( ProductModel.fromJson(element)));
  ad=json['ad'];
  }
}
class BannerModel{

  late int id;
  late String image;
  // late String category;
  // late String product;
  BannerModel.fromJson(Map<String,dynamic>json){
    id=json['id'];
    image=json['image'] ;
    // category=json['category'] ;
    // product=json['product']??'no message';

  }

}
/*"id": 11,
"image": "https://student.valuxapps.com/storage/uploads/banners/1619472351ITAM5.3bb51c97376281.5ec3ca8c1e8c5.jpg",
"category": null,
"product": null*/
class ProductModel{
  late int id;
  late dynamic price;
   late dynamic oldPrice;
  late dynamic discount;
  late String image;
  late String name;
 // late String description;
 // late List<String> images;
  late bool inFavorites;
  late bool inCart;
  ProductModel.fromJson(Map<String,dynamic>json){
    id=json['id'];
    price=json['price'] ;
     oldPrice=json['old_price'] ;
    discount=json['discount'];
    image=json['image'] ;
    name=json['name']  ;
  //  images=json['images'] ;
    inFavorites=json['in_favorites'];
    inCart=json['in_cart'] ;

  }


}
/*
"id": 52,
"price": 25000,
"old_price": 25000,
"discount": 0,
"image": "https://student.valuxapps.com/storage/uploads/products/1615440322npwmU.71DVgBTdyLL._SL1500_.jpg",
"name": "ابل ايفون 12 برو ماكس - 256جيجابيت, ازرق",
"description": "الحجم: ٦.٧ بوصة\",
"images": [
"https://student.valuxapps.com/storage/uploads/products/1615440322UAwSF.81KcqNGQIsL._SL1500_.jpg",
"https://student.valuxapps.com/storage/uploads/products/1615440322UjY4o.71DVgBTdyLL._SL1500_.jpg"
],
"in_favorites": false,
"in_cart": false
},*/
