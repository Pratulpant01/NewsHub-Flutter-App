import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newshub/bloc/news_bloc.dart';
import 'package:newshub/helper/data.dart';
import 'package:newshub/helper/news.dart';
import 'package:newshub/models/article_model.dart';
import 'package:newshub/models/category_model.dart';
import 'package:newshub/views/articleview.dart';
import 'package:newshub/views/category_news.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _loading = true;
  List<CategoryModel> categories = getCategories();
  List<ArticleModel> articles = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsBloc(
        RepositoryProvider.of<News>(context),
      )..add(GetNewsApi()),
      child: Scaffold(
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
        body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    height: 70,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return CategoryTile(
                            imageUrl: categories[index].imageUrl,
                            categoryName: categories[index].categoryName,
                          );
                        }),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: 16,
                    ),
                    child: BlocBuilder<NewsBloc, NewsState>(
                      builder: (context, state) {
                        if (state is NewsLoading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (state is NewsLoaded) {
                          print(state.newsData);
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: state.newsData.length,
                            itemBuilder: (context, index) {
                              return BlogTile(
                                url: state.newsData[index].url,
                                imgUrl: state.newsData[index].urlToImage,
                                title: state.newsData[index].title,
                                description: state.newsData[index].description,
                              );
                            },
                          );
                        }
                        return Container();
                      },
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final imageUrl, categoryName;
  const CategoryTile({this.imageUrl, this.categoryName, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                CategoryNews(category: categoryName.toString().toLowerCase()),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(
          right: 16,
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                width: 120,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(8)),
              child: Text(
                categoryName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imgUrl, title, description, url;
  const BlogTile(
      {Key? key,
      required this.imgUrl,
      required this.url,
      required this.title,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleView(
              webUrl: url,
            ),
          ),
        );
      },
      child: Container(
        child: Column(children: [
          ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(imgUrl)),
          SizedBox(
            height: 8,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.aleo(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            description,
            style: GoogleFonts.alatsi(
              color: Colors.grey[700],
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 8,
          ),
        ]),
      ),
    );
  }
}
