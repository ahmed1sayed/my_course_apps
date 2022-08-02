class CategoryModel{

late bool status;

late CategoryData data;
 CategoryModel.fromJson(Map<String,dynamic>json){
  status=json["status"];
  data=CategoryData.fromJson(json['data']) ;
}

}
class CategoryData{
  late int currentPage;
  late List<DataList>data=[];

/*
  late int first_page_url;
  late int from;
  late int last_page;
  late int last_page_url;
   late int path;
  late int per_page;
  late int to;
  late int total;
*/

  CategoryData.fromJson(Map<String,dynamic>json){
    currentPage=json["current_page"];
   json["data"].forEach((element)=>data.add(DataList.fromJson(element)));


  }

}

class DataList{
  late int id;
  late String name;
  late String image;
  DataList.fromJson(Map<String,dynamic>json){

    id=json["id"];
    name=json["name"];
    image=json["image"];

  }

}
/*
{
"status": true,
 "data": {
"current_page": 1,
"data": [
{
"id": 44,
"name": "اجهزه الكترونيه",
"image": "https://student.valuxapps.com/storage/uploads/categories/16301438353uCFh.29118.jpg"
},
],
"first_page_url": "https://student.valuxapps.com/api/categories?page=1",
"from": 1,
"last_page": 1,
"last_page_url": "https://student.valuxapps.com/api/categories?page=1",
"next_page_url": null,
"path": "https://student.valuxapps.com/api/categories",
"per_page": 35,
"prev_page_url": null,
"to": 5,
"total": 5
}
}*/
