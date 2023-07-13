import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:movies_details/utils/api_key.dart';

import '../model/movies.dart';
import '../utils/colors.dart';

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
    return Scaffold(
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
            shape: const RoundedRectangleBorder(
              side: BorderSide(
                color: mainColor,
              ),
            ),
            elevation: 4,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    mainColor.shade700,
                    mainColor.shade700,
                    mainColor,
                    mainColor.shade400,
                  ]
                )
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Image.network('$posterUrl${moviesList[index].posterPath}',
                        alignment: Alignment.center,
                        height: double.infinity,
                        width: double.infinity,
                        fit: BoxFit.fitWidth,
                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loading) {
                          if (loading == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loading.expectedTotalBytes != null
                                  ? loading.cumulativeBytesLoaded/loading.expectedTotalBytes! : null,
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(moviesList[index].originalTitle.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(Icons.star, size: 14,),
                              Text(moviesList[index].voteAverage.toString()),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          );
        },
      )

    );
  }
}
