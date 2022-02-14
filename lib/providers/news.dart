import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class NewsItem with ChangeNotifier {
  int? newsID;
  int? locationID;
  DateTime? publishDate;
  bool? sortOrder;
  bool? showManset;
  bool? showGuncel;
  int? viewCount;
  int? contentID;
  int? moduleID;
  int? relationID;
  int? categoryID;
  String? lang;
  bool? display;
  int? showAll;
  String? title;
  String? sef;
  String? summary;
  String? content;
  List? imgname;

  NewsItem({this.newsID, this.locationID, this.publishDate, this.sortOrder, this.showManset, this.showGuncel, this.viewCount, this.contentID, this.moduleID, this.relationID, this.categoryID, this.lang, this.display, this.showAll, this.title, this.sef, this.summary, this.content, this.imgname});

  void _setDisplayValue(bool newValue) {
    display = newValue;
    notifyListeners();
  }
}

class News with ChangeNotifier {
  List<NewsItem> _news = [];

  List<NewsItem> get news {
    return [..._news];
  }

  NewsItem findById(int id) {
    return _news.firstWhere((news) => news.newsID == id);
  }

  Future<int> fetchAndSetNewss(int? locationID) async {
    var url = Uri.parse('https://agestmet.com/yigit/v2/news?locationID=$locationID');
    final response = await http.get(url);
    print("HERE IS THE PROBLEM");
    print(response.statusCode);
    if (response.statusCode == 404) {
      return response.statusCode;
    } else {
      final List<NewsItem> loadedNews = [];
      final extractedData = json.decode(response.body);
      print(extractedData);
      final parsed = extractedData['data']['news'];
      //print(parsed);
      parsed.forEach((k, v) => print('${k}: ${v}'));

      parsed.forEach((newsId, newsData) {
        loadedNews.add(
          NewsItem(
            newsID: newsData["newsID"],
            locationID: newsData["locationID"],
            publishDate: DateTime.parse(newsData["publishDate"]),
            sortOrder: newsData["sortOrder"],
            showManset: newsData["showManset"],
            showGuncel: newsData["showGuncel"],
            viewCount: newsData["viewCount"],
            contentID: newsData["contentID"],
            moduleID: newsData["moduleID"],
            relationID: newsData["relationID"],
            categoryID: newsData["categoryID"],
            lang: newsData["lang"],
            display: newsData["display"],
            showAll: newsData["showAll"],
            title: newsData["title"],
            sef: newsData["sef"],
            summary: newsData["summary"],
            content: newsData["content"],
            imgname: newsData["imgname"],
          ),
        );
      });
      _news = loadedNews.reversed.toList();
      // print(_news);
      notifyListeners();

      return response.statusCode;
    }
  }

  Future<void> makePatchRequest(int id, NewsItem news) async {
    final url = Uri.parse('https://agestmet.com/yigit/v2/news/${id}');
    //  final headers = {"Content-type": "application/json"};
    //final json = '{"title": "Hello"}';

    var jsonmap2 = json.encode(<String, dynamic>{
      'locationID': news.locationID,

      'publishDate': news.publishDate,

      'sortOrder': news.sortOrder,
      'showManset': news.showManset,
      'showGuncel': news.showGuncel,

      //   'displayed': business.displayed,
      //   'category': business.category,

      'viewCount': news.viewCount,
      'contentID': news.contentID,
      'moduleID': news.moduleID,
      'relationID': news.relationID,
      'categoryID': news.categoryID,
      'lang': news.lang,
      'display': news.display,
      'showAll': news.showAll,
      'title': news.title,
      'sef': news.sef,
      'summary': news.summary,
      'content': news.content,
      'imgname': news.imgname,
    });

    // map2:
    //print(jsonmap2);

    final response = await http.patch(url, body: jsonmap2);
    //print('Status code: ${response.statusCode}');
    //print('Body: ${response.body}');
  }

  Future<List<int>> addNews(NewsItem news) async {
    var url = Uri.parse('https://agestmet.com/yigit/v2/news');
    try {
      var map = new Map<String, dynamic>();

      map['newsID'] = news.newsID;
      map['locationID'] = news.locationID;
      map['display'] = news.display;
      map['viewCount'] = news.viewCount;
      map['publishDate'] = news.publishDate!.toIso8601String();
      map['sortOrder'] = news.sortOrder;
      map['showManset'] = news.showManset;
      map['showGuncel'] = news.showGuncel;
      map['contentID'] = news.contentID;
      map['moduleID'] = news.moduleID;
      map['relationID'] = news.relationID;
      map['categoryID'] = news.categoryID;
      map['lang'] = news.lang;
      map['display'] = news.display;
      map['showAll'] = news.showAll;
      map['title'] = news.title;
      map['sef'] = news.sef;
      map['summary'] = news.summary;
      map['content'] = news.content;
      map['imgname'] = news.imgname;
      var jsonBody = json.encode(map);

      var jsonmap2 = json.encode(<String, dynamic>{
        'newsID': news.newsID,
        'locationID': news.locationID,
        'display': news.display,
        'viewCount': news.viewCount,
        'publishDate': news.publishDate!.toIso8601String(),
        'sortOrder': news.sortOrder,
        'showManset': news.showManset,
        'showGuncel': news.showGuncel,
        'contentID': news.contentID,
        'moduleID': news.moduleID,
        'relationID': news.relationID,
        'categoryID': news.categoryID,
        'lang': news.lang,
        'showAll': news.showAll,
        'title': news.title,
        'sef': news.sef,
        'summary': news.summary,
        'content': news.content,
        'imgname': news.imgname,
      });

      http.Response response = await http.post(url, body: jsonmap2);
      print(response);
      final newNews = NewsItem(
        newsID: news.newsID,
        locationID: news.locationID,
        display: news.display,
        viewCount: news.viewCount,
        publishDate: news.publishDate,
        sortOrder: news.sortOrder,
        showManset: news.showManset,
        showGuncel: news.showGuncel,
        contentID: news.contentID,
        moduleID: news.moduleID,
        relationID: news.relationID,
        categoryID: news.categoryID,
        lang: news.lang,
        showAll: news.showAll,
        title: news.title,
        sef: news.sef,
        summary: news.summary,
        content: news.content,
        imgname: news.imgname,
      );
      //todo:

      _news.insert(0, newNews);

      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();

      return [response.statusCode, int.parse(json.decode("[" + response.body + "]")[0]['messages'][0])];
      //   print(json.decode(response.body));
    } catch (error) {
      // print(error);
      throw error;
    }
  }

  Future<void> deleteNews(int id) async {
    final url = Uri.parse('https://agestmet.com/yigit/v2/news/${id}');

    final request = http.Request(
      "DELETE",
      url,
    );
    request.headers.clear();

    final response = await request.send();
    final existingProductIndex = _news.indexWhere((news) => news.newsID == id);
    _news.removeAt(existingProductIndex);
    notifyListeners();
    // print(response.statusCode);
  }

  ///tektek
  Future<NewsItem> fetchAndSetNews(int id) async {
    var url = Uri.parse('https://agestmet.com/yigit/v2/news/${id}');
    final response = await http.get(url);
    final List<NewsItem> loadedNews = [];
    final extractedData = json.decode(response.body);

    final parsed = extractedData['data']['news'];

    parsed.forEach((k, v) => print('${k}: ${v}'));

    var news = NewsItem(
      newsID: parsed["newsId"],
      locationID: parsed["locationID"],
      publishDate: parsed["publishDate"],
      sortOrder: parsed["sortOrder"],
      showManset: parsed["showManset"],
      showGuncel: parsed["showGuncel"],
      viewCount: parsed["viewCount"],
      contentID: parsed["contentID"],
      moduleID: parsed["moduleID"],
      relationID: parsed["relationID"],
      categoryID: parsed["categoryID"],
      lang: parsed["lang"],
      display: parsed["display"],
      showAll: parsed["showAll"],
      title: parsed["title"],
      sef: parsed["sef"],
      summary: parsed["summary"],
      content: parsed["content"],
      imgname: parsed["imgname"],
    );

    return news;
  }
}
