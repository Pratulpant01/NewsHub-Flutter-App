import 'dart:convert';

import 'package:flutter/material.dart';

import '../models/article_model.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArticleModel> newsList = [];

  Future<void> getNews() async {
    String apiKey = '39f13baa0f694b4a9d78e4955cb1e80a';
    String url =
        'https://newsapi.org/v2/top-headlines?country=in&apiKey=${apiKey}';

    var response = await http.get(Uri.parse(url));

    var data = jsonDecode(response.body);

    if (data['status'] == 'ok') {
      data['articles'].forEach(
        (element) {
          if (element['urlToImage'] != null &&
              element['description'] != null &&
              element['content'] != null) {
            ArticleModel articleModel = ArticleModel(
              description: element['description'],
              title: element['title'],
              url: element['url'],
              urlToImage: element['urlToImage'],
              content: element['content'],
            );
            newsList.add(articleModel);
          }
        },
      );
    } else {
      throw Exception(data['status']);
    }
  }
}

class CategoryNewsClass {
  List<ArticleModel> newsList = [];

  Future<void> getNews(String categories) async {
    String apiKey = '39f13baa0f694b4a9d78e4955cb1e80a';
    String url =
        'https://newsapi.org/v2/top-headlines?country=in&category=$categories&apiKey=${apiKey}';

    var response = await http.get(Uri.parse(url));

    var data = jsonDecode(response.body);

    if (data['status'] == 'ok') {
      data['articles'].forEach(
        (element) {
          if (element['urlToImage'] != null &&
              element['description'] != null &&
              element['content'] != null) {
            ArticleModel articleModel = ArticleModel(
              description: element['description'],
              title: element['title'],
              url: element['url'],
              urlToImage: element['urlToImage'],
              content: element['content'],
            );
            newsList.add(articleModel);
          }
        },
      );
    } else {
      throw Exception(data['status']);
    }
  }
}
