import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:movies_details/utils/api_key.dart';

import '../model/movies.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    getMovies();
  }

  List<Result> moviesList = [];
  bool isLoading = true;

  String baseUrl = 'https://api.themoviedb.org/3/';
  String posterUrl = 'https://image.tmdb.org/t/p/original';
  void getMovies() async {
    String moviesListUrl = '${baseUrl}discover/movie?page=1&api_key=$apiKey';

    Response response = await get(Uri.parse(moviesListUrl));
    print(response.statusCode);

    if(response.statusCode == 200) {
      Map<String, dynamic> decodedResponse = jsonDecode(response.body);
      print(decodedResponse['page']);
      print(response.body);

      for(var e in decodedResponse['results']) {
        moviesList.add(
          Result.fromJson(e)
        );
      }
      setState(() {});
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black54,
      appBar: AppBar(title: Text('Movie'),),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65
        ),
        itemCount: moviesList.length,
        //Image.network('${posterUrl}${moviesList[index].posterPath}',
        itemBuilder: (context, index) {
          return Card(
            color: Colors.black54,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    '${posterUrl}${moviesList[index].posterPath}'
                  ), fit: BoxFit.fill
                )
              ),
            ),
          );
        },
      )

    );
  }
}
