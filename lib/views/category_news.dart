import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newshub/helper/news.dart';
import 'package:newshub/models/article_model.dart';

import 'home.dart';

class CategoryNews extends StatefulWidget {
  final String category;
  bool _isLoading = true;

  CategoryNews({super.key, required this.category});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ArticleModel> articles = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNewsClass categoryNews = CategoryNewsClass();
    await categoryNews.getNews(widget.category);
    articles = categoryNews.newsList;
    setState(() {
      widget._isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'NewsHub',
          style: GoogleFonts.aclonica(
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple,
          ),
        ),
      ),
      body: widget._isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: ListView.builder(
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      return BlogTile(
                        url: articles[index].url,
                        imgUrl: articles[index].urlToImage,
                        title: articles[index].title,
                        description: articles[index].description,
                      );
                    }),
              ),
            ),
    );
  }
}
