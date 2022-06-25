//todo model class

class News {
  final String publishedAt;
  final String title;
  final String urlToImage;

  News({required this.title,required this.publishedAt,required this.urlToImage});

  factory News.fromJson(Map<String,dynamic> json) => News(
      publishedAt: json['publishedAt'],
      urlToImage: json['urlToImage'],
      title: json['title']);
}

//todo cubit class

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_bloc_and_cubit/data_service.dart';
// import 'post.dart';

// class PostsCubit extends Cubit<List<Post>> {
//   final _dataService = DataService();
//
//   PostsCubit() : super([]);
//
//   void getPosts() async => emit(await _dataService.getPosts());
// }
//todo dataService class
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'post.dart';
//
// class DataService {
//   final _baseUrl = 'jsonplaceholder.typicode.com';
//
//   Future<List<Post>> getPosts() async {
//     try {
//       final uri = Uri.https(_baseUrl, '/posts');
//       final response = await http.get(uri);
//       final json = jsonDecode(response.body) as List;
//       final posts = json.map((postJson) => Post.fromJson(postJson)).toList();
//       return posts;
//     } catch (e) {
//       throw e;
//     }
//   }
// }

//todo main class

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_bloc_and_cubit/posts_cubit.dart';
// import 'package:flutter_bloc_and_cubit/posts_view.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: BlocProvider<PostsCubit>(
//             create: (context) => PostsCubit()..getPosts(), child: PostsView()));
//   }
// }



//todo cardview class

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_bloc_and_cubit/posts_cubit.dart';
//
// import 'post.dart';

// class PostsView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Posts'),
//       ),
//       body: BlocBuilder<PostsCubit, List<Post>>(
//         builder: (context, posts) {
//           if (posts.isEmpty) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//
//           return ListView.builder(itemBuilder: (context, index) {
//             return Card(
//               child: ListTile(
//                 title: Text(posts[index].title),
//               ),
//             );
//           });
//         },
//       ),
//     );
//   }
// }
