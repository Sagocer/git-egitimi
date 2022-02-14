import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class CategoriesItem with ChangeNotifier {
  int? categoryID;
  int? moduleID;
  int? parentID;
  bool? displayCategory;
  bool? forFilter;
  bool? forDiscovery;
  bool? showHomePage;
  bool? sortOrder;
  int? contentID;
  int? relationID;
  String? lang;

  bool? displayContent;
  int? showAll;
  String? title;
  String? sef;
  String? summary;
  String? content;

  CategoriesItem({this.categoryID, this.moduleID, this.parentID, this.displayCategory, this.forFilter, this.forDiscovery, this.showHomePage, this.sortOrder, this.contentID, this.relationID, this.lang, this.displayContent, this.showAll, this.title, this.sef, this.summary, this.content});

  void _setDisplayValue(bool newValue) {
    displayCategory = newValue;
    notifyListeners();
  }
}

class Categories with ChangeNotifier {
  List<CategoriesItem> _categories = [];

  List<CategoriesItem> get categories {
    return [..._categories];
  }

  int? _responseMap;

  int? get responseMap {
    return _responseMap;
  }

  CategoriesItem findById(int id) {
    return _categories.firstWhere((categs) => categs.categoryID == id);
  }

  Future<void> makePatchRequest(int id, CategoriesItem newCategory) async {
    try {
      final categoryIndex = _categories.indexWhere((element) => element.categoryID == id);

      print("burdaaa");
      final url = Uri.parse('https://agestmet.com/yigit/v2/category/parent/${id}');
      //final headers = {"Content-type": "application/json"};
      //final json = '{"title": "Hello"}';

      var jsonmap2 = json.encode(<String, dynamic>{
        'displayCategory': newCategory.displayCategory,
        'forFilter': newCategory.forFilter,
        'forDiscovery': newCategory.forDiscovery,
        'showHomePage': newCategory.showHomePage,
        'sortOrder': newCategory.sortOrder,
        'lang': newCategory.lang,
        'displayContent': newCategory.displayContent,
        'showAll': newCategory.showAll,
        'title': newCategory.title,
        'sef': newCategory.sef,
        'summary': newCategory.summary,
        'content': newCategory.content,
      });

      print(jsonmap2);
      final response = await http.patch(url, body: jsonmap2);

      print("rresppponsebdoddyy");
      print(response.body);

      _categories[categoryIndex] = newCategory;

      print("INDEXX LİSTİNGG");
      print(_categories[categoryIndex].title);
      print(_categories[categoryIndex].summary);

      notifyListeners();

      // map2:
      print(jsonmap2);

      print('Status code: ${response.statusCode}');
      print('Body: ${response.body}');
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> fetchAndSetCategoriesByParents(int id) async {
    var url = Uri.parse('https://agestmet.com/yigit/v2/category/parent/${id}');
    final response = await http.get(url);

    _responseMap = response.statusCode;

    print("RESPONSECATEGORRYY");
    print(_responseMap);

    //_responseMap = response.body;

    final List<CategoriesItem> loadedListings = [];
    final extractedData = json.decode(response.body);

    final parsed = extractedData['data']['category'];

    parsed.forEach((k, v) => print('${k}: ${v}'));

    parsed.forEach((categoryId, categoryData) {
      loadedListings.add(
        CategoriesItem(
          categoryID: categoryData['categoryID'],
          moduleID: categoryData['moduleID'],
          parentID: categoryData['parentID'],
          displayCategory: categoryData['display'],
          forFilter: categoryData['forFilter'],
          forDiscovery: categoryData['forDiscovery'],
          showHomePage: categoryData['showHomePage'],
          sortOrder: categoryData['sortOrder'],
          contentID: categoryData['contentID'],
          relationID: categoryData['relationID'],
          lang: categoryData['lang'],
          displayContent: categoryData['display'],
          showAll: categoryData['showAll'],
          title: categoryData['title'],
          sef: categoryData['sef'],
          summary: categoryData['summary'],
          content: categoryData['content'],
        ),
      );
    });
    _categories = loadedListings.reversed.toList();
    notifyListeners();
  }

  Future<void> addCategory(CategoriesItem parentCategoryItem, int parentId) async {
    try {
      var map = new Map<String, dynamic>();
      //print(listing.categoryIDs);

      map['displayCategory'] = parentCategoryItem.displayCategory;
      map['forFilter'] = parentCategoryItem.forFilter;
      map['forDiscovery'] = parentCategoryItem.forDiscovery;

      map['showHomePage'] = parentCategoryItem.showHomePage;
      map['sortOrder'] = parentCategoryItem.sortOrder;
      map['displayContent'] = parentCategoryItem.displayContent;
      map['lang'] = parentCategoryItem.lang;
      map['showAll'] = parentCategoryItem.showAll;
      map['title'] = parentCategoryItem.title;
      map['sef'] = parentCategoryItem.sef;
      map['summary'] = parentCategoryItem.summary;
      map['content'] = parentCategoryItem.content;
      var jsonBody = json.encode(map);

      var jsonmap2 = json.encode(<String, dynamic>{
        'displayCategory': parentCategoryItem.displayCategory,
        'forFilter': parentCategoryItem.forFilter,
        'forDiscovery': parentCategoryItem.forDiscovery,
        'showHomePage': parentCategoryItem.showHomePage,
        'sortOrder': parentCategoryItem.sortOrder,
        'displayContent': parentCategoryItem.displayContent,
        'lang': parentCategoryItem.lang,
        'showAll': parentCategoryItem.showAll,
        'title': parentCategoryItem.title,
        'sef': parentCategoryItem.sef,
        'summary': parentCategoryItem.summary,
        'content': parentCategoryItem.content,
      });

      // map2:
      print(jsonmap2);
      // print(map);
      //final response = await Dio().post('https://agestmet.com/yigit/v2/listings', data: jsonBody);
      if (parentId == 0) {
        var url = Uri.parse('https://agestmet.com/yigit/v2/category/parent/');
        http.Response response = await http.post(url, body: jsonmap2);
        print(response.body);
        print(json.decode(response.body));
      } else {
        var url = Uri.parse('https://agestmet.com/yigit/v2/category/parent/${parentId}');
        http.Response response = await http.post(url, body: jsonmap2);
        print(response.body);
        print(json.decode(response.body));
      }
      //todo (if check):  if( 'Task created' == json.decode(response.body)['name']['messages']) {

/*
    try {
      var res = await http.post(
        Uri.parse('https://agestmet.com/yigit/v2/listings'),
        body: jsonEncode({
          'locationID': listing.locationID,

          'categoryIDs': listing.categoryIDs,

          'display': listing.display,
          'viewCount': listing.viewCount,
          'isPaid': listing.isPaid,

          //   'displayed': business.displayed,
          //   'category': business.category,

          'contactID': listing.contactID,
          'moduleID': listing.moduleID,
          'coordinate': listing.coordinate,
          'address': listing.address,
          'phone': listing.phone,
          'website': listing.website,
          'email': listing.email,
          'facebook': listing.facebook,
          'instagram': listing.instagram,
          'youtube': listing.youtube,
          'pinterest': listing.pinterest,
          'twitter': listing.twitter,
          'whatsapp': listing.whatsapp,
          'contentID': listing.contentID,
          'categoryID': listing.categoryID,
          'lang': listing.lang,
          'showAll': listing.showAll,
          'title': listing.title,
          'sef': listing.sef,
          'summary': listing.summary,
          'content': listing.content,
        }),
        //encoding to json
      );
      print(res.body);
      //int statuscodee = News.fromJson(json.decode(res.body) as Map<String, dynamic>).statusCode;
      //print(statuscodee);
*/
      //print(jsonDecode(response.body)['data']['listings']['listingID']);
      final newCategory = CategoriesItem(
        categoryID: 0,
        parentID: 0,
        displayCategory: parentCategoryItem.displayCategory,
        forDiscovery: parentCategoryItem.forDiscovery,
        showHomePage: parentCategoryItem.showHomePage,
        sortOrder: parentCategoryItem.sortOrder,
        forFilter: parentCategoryItem.forFilter,
        lang: parentCategoryItem.lang,
        displayContent: parentCategoryItem.displayContent,
        showAll: parentCategoryItem.showAll,
        title: parentCategoryItem.title,
        sef: parentCategoryItem.sef,
        summary: parentCategoryItem.summary,
        content: parentCategoryItem.content,
      );
      //todo:

      //_listings.insert(0, newListing);
      _categories.add(newCategory);

      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();

      //   print(json.decode(response.body));
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<void> deleteCategories(int id) async {
    final url = Uri.parse('https://agestmet.com/yigit/v2/category/parent/${id}');

    final request = http.Request(
      "DELETE",
      url,
    );
    request.headers.clear();

    final response = await request.send();

    final existingProductIndex = _categories.indexWhere((categs) => categs.categoryID == id);
    _categories.removeAt(existingProductIndex);
    notifyListeners();

    print(response.statusCode);
  }
}
