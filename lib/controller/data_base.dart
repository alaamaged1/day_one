import 'dart:convert';

import 'package:day_one/model/news_model.dart';
import 'package:http/http.dart' as http;

class NewsController {
  final String apiUrl =
      'https://newsapi.org/v2/top-headlines?country=us&category=general&apiKey=8593b281ba054ae08c2ee222e39e669c&page=1';
  Future<List<Articles>>? fetchNews() async {
    var response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      List<Articles> newsList = [];
      for (var news in jsonResponse["articles"]) {
        newsList.add(Articles.fromJson(news));
      }
      return newsList;
    } else {
      throw ('canot get the news');
    }
  }
}
