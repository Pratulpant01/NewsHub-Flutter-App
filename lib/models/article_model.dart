// ignore_for_file: public_member_api_docs, sort_constructors_first
class ArticleModel {
  String description;
  String title;
  String url;
  String urlToImage;
  String content;
  ArticleModel({
    required this.description,
    required this.title,
    required this.url,
    required this.urlToImage,
    required this.content,
  });

  @override
  String toString() {
    return 'ArticleModel(description: $description, title: $title, url: $url, urlToImage: $urlToImage, content: $content)';
  }
}
