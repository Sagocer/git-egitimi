import 'dart:convert';
import 'package:flutter/material.dart';

import 'dart:async';

import 'dart:core';

import 'package:intl/intl.dart';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

//todo: this file will be reviewed

class ListingsItem with ChangeNotifier {
  int? listingID;
  int? locationID;
  String? categoryIDs;
  bool? display;
  int? viewCount;
  bool? isPaid;
  int? contactID;
  int? moduleID;
  int? relationID;
  String? coordinate;
  String? address;
  String? phone;
  String? website;
  String? email;
  String? facebook;
  String? instagram;
  String? youtube;
  String? pinterest;
  String? twitter;
  String? whatsapp;
  int? contentID;
  int? categoryID;
  String? lang;
  int? showAll;
  String? title;
  String? sef;
  String? summary;
  String? content;
  List<bool>? trueFalseArray;

  List<String>? startingTimeArray;

  List<String>? finishingTimearray;
  ////100222
  List? imglang;
  List? sortOrder;
  List? mainImage;
  List? name;
  ////100222

  ListingsItem(
      {this.listingID,
      this.locationID,
      this.categoryIDs,
      this.display,
      this.viewCount,
      this.isPaid,
      this.contactID,
      this.moduleID,
      this.relationID,
      this.coordinate,
      this.address,
      this.phone,
      this.website,
      this.email,
      this.facebook,
      this.instagram,
      this.youtube,
      this.pinterest,
      this.twitter,
      this.whatsapp,
      this.contentID,
      this.categoryID,
      this.lang,
      this.showAll,
      this.title,
      this.sef,
      this.summary,
      this.content,
      this.trueFalseArray,
      this.finishingTimearray,
      this.startingTimeArray,
      ////100222
      this.imglang,
      this.sortOrder,
      this.mainImage,
      this.name});
  ////100222
  void _setDisplayValue(bool newValue) {
    display = newValue;
    notifyListeners();
  }
}

class Listings with ChangeNotifier {
  List<ListingsItem> _listings = [];

  List<ListingsItem> get listings {
    return [..._listings];
  }

  int? _responseMap;

  int? get responseMap {
    return _responseMap;
  }

  int? _returnedNewId;

  int? get returnedNewId {
    return _returnedNewId;
  }

  ListingsItem findById(int id) {
    return _listings.firstWhere((list) => list.listingID == id);
  }

  Future<void> fetchAndSetListings() async {
    var url = Uri.parse('https://agestmet.com/yigit/v2/listings/displayable');
    final response = await http.get(url);
    final List<ListingsItem> loadedListings = [];
    final extractedData = json.decode(response.body);
    print("*************************************");
    print("*************************************");
    print("*************************************");
    print("*************************************");
    print(extractedData);
    print("*************************************");
    print("*************************************");
    print("*************************************");
    print("*************************************");
    print("*************************************");
    final parsed = extractedData['data']['listings'];

    parsed.forEach((k, v) => print('${k}: ${v}'));

    parsed.forEach((listingId, listingData) {
      loadedListings.add(
        ListingsItem(
            listingID: listingData['listingID'],
            locationID: listingData['locationID'],
            categoryIDs: listingData['categoryIDs'],
            display: listingData['display'],
            viewCount: listingData['viewCount'],
            isPaid: listingData['isPaid'],
            contactID: listingData['contactID'],
            moduleID: listingData['moduleID'],
            relationID: listingData['relationID'],
            coordinate: listingData['coordinate'],
            address: listingData['address'],
            phone: listingData['phone'],
            website: listingData['website'],
            email: listingData['email'],
            facebook: listingData['facebook'],
            instagram: listingData['instagram'],
            youtube: listingData['youtube'],
            pinterest: listingData['pinterest'],
            twitter: listingData['twitter'],
            whatsapp: listingData['whatsapp'],
            contentID: listingData['contentID'],
            categoryID: listingData['categoryID'],
            lang: listingData['lang'],
            showAll: listingData['showAll'],
            title: listingData['title'],
            sef: listingData['sef'],
            summary: listingData['summary'],
            content: listingData['content'],
            imglang: listingData['imglang'],
            sortOrder: listingData['sortOrder'],
            mainImage: listingData['mainImage'],
            name: listingData['name']),
      );
    });
    _listings = loadedListings.reversed.toList();
    notifyListeners();
  }

  Future<int> makePatchRequest(int id, ListingsItem newlisting) async {
    try {
      final listingIndex = _listings.indexWhere((element) => element.listingID == id);
      print("listing indexxxxxx");
      print(listingIndex);
      final url = Uri.parse('https://agestmet.com/yigit/v2/listings/${id}');
      //  final headers = {"Content-type": "application/json"};
      //final json = '{"title": "Hello"}';
      var jsonmap2;
      if (newlisting.name != null) {
        jsonmap2 = json.encode(<String, dynamic>{
          'locationID': newlisting.locationID,

          'categoryIDs': newlisting.categoryIDs,

          'display': newlisting.display,
          'viewCount': newlisting.viewCount,
          'isPaid': newlisting.isPaid,

          //   'displayed': business.displayed,
          //   'category': business.category,

          'contactID': newlisting.contactID,
          'moduleID': newlisting.moduleID,
          'coordinate': newlisting.coordinate,
          'address': newlisting.address,
          'phone': newlisting.phone,
          'website': newlisting.website,
          'email': newlisting.email,
          'facebook': newlisting.facebook,
          'instagram': newlisting.instagram,
          'youtube': newlisting.youtube,
          'pinterest': newlisting.pinterest,
          'twitter': newlisting.twitter,
          'whatsapp': newlisting.whatsapp,
          'contentID': newlisting.contentID,
          'categoryID': newlisting.categoryID,
          'lang': newlisting.lang,
          'showAll': newlisting.showAll,
          'title': newlisting.title,
          'sef': newlisting.sef,
          'summary': newlisting.summary,
          'content': newlisting.content,
          ////100222
          'imglang': newlisting.imglang,
          'sortOrder': newlisting.sortOrder,
          'mainImage': newlisting.mainImage,
          'name': newlisting.name
        });
      } else {
        jsonmap2 = json.encode(<String, dynamic>{
          'locationID': newlisting.locationID,

          'categoryIDs': newlisting.categoryIDs,

          'display': newlisting.display,
          'viewCount': newlisting.viewCount,
          'isPaid': newlisting.isPaid,

          //   'displayed': business.displayed,
          //   'category': business.category,

          'contactID': newlisting.contactID,
          'moduleID': newlisting.moduleID,
          'coordinate': newlisting.coordinate,
          'address': newlisting.address,
          'phone': newlisting.phone,
          'website': newlisting.website,
          'email': newlisting.email,
          'facebook': newlisting.facebook,
          'instagram': newlisting.instagram,
          'youtube': newlisting.youtube,
          'pinterest': newlisting.pinterest,
          'twitter': newlisting.twitter,
          'whatsapp': newlisting.whatsapp,
          'contentID': newlisting.contentID,
          'categoryID': newlisting.categoryID,
          'lang': newlisting.lang,
          'showAll': newlisting.showAll,
          'title': newlisting.title,
          'sef': newlisting.sef,
          'summary': newlisting.summary,
          'content': newlisting.content,
        });
      }

      final response = await http.patch(url, body: jsonmap2);

      // final existingProductIndex =
      //     _listings.indexWhere((list) => list.listingID == id);
      // _listings.removeAt(existingProductIndex);

      //_listings.removeAt(id);
      // _listings.add(newlisting);

      _listings[listingIndex] = newlisting;

      //_listings.replaceRange(listingIndex,listingIndex ,newlisting);
      print("INDEXX LİSTİNGG");
      print(_listings[listingIndex].title);
      print(_listings[listingIndex].address);

      notifyListeners();

      // map2:
      print(jsonmap2);

      print('Status code: ${response.statusCode}');
      print('Body: ${response.body}');
      return id;
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<int> addListings(ListingsItem listing) async {
    var url = Uri.parse('https://agestmet.com/yigit/v2/listings');

    print(listing.locationID);
    try {
      var map = new Map<String, dynamic>();
      //print(listing.categoryIDs);
      map['locationID'] = listing.locationID;

      map['categoryIDs'] = listing.categoryIDs;

      map['display'] = listing.display;
      map['viewCount'] = listing.viewCount;
      map['isPaid'] = listing.isPaid;

      //   'displayed': business.displayed,
      //   'category': business.category,

      map['contactID'] = listing.contactID;
      map['moduleID'] = listing.moduleID;
      map['coordinate'] = listing.coordinate;
      map['address'] = listing.address;
      map['phone'] = listing.phone;
      map['website'] = listing.website;
      map['email'] = listing.email;
      map['facebook'] = listing.facebook;
      map['instagram'] = listing.instagram;
      map['youtube'] = listing.youtube;
      map['pinterest'] = listing.pinterest;
      map['twitter'] = listing.twitter;
      map['whatsapp'] = listing.whatsapp;
      map['contentID'] = listing.contentID;
      map['categoryID'] = listing.categoryID;
      map['lang'] = listing.lang;
      map['showAll'] = listing.showAll;
      map['title'] = listing.title;
      map['sef'] = listing.sef;
      map['summary'] = listing.summary;
      map['content'] = listing.content;
      map['imglang'] = listing.imglang;
      map['sortOrder'] = listing.sortOrder;
      map['mainImage'] = listing.mainImage;
      map['name'] = listing.name;
      var jsonBody = json.encode(map);

      var jsonmap2 = json.encode(<String, dynamic>{
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
        'truefalsearray': listing.trueFalseArray,

        'finishingtimearray': listing.finishingTimearray,

        'startingtimearray': listing.startingTimeArray,
        'imglang': listing.imglang,
        'sortOrder': listing.sortOrder,
        'mainImage': listing.mainImage,
        'name': listing.name
      });

      // map2:
      print(jsonmap2);
      // print(map);
      //final response = await Dio().post('https://agestmet.com/yigit/v2/listings', data: jsonBody);
      http.Response response = await http.post(
        url,
        body: jsonmap2,
      );
      //print(response.body);
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
      final newListing = ListingsItem(
          listingID: 0,
          locationID: listing.locationID,
          categoryIDs: listing.categoryIDs,
          display: listing.display,
          viewCount: listing.viewCount,
          coordinate: listing.coordinate,
          //  displayed: business.displayed,
          //  category: business.category,
          address: listing.address,
          phone: listing.phone,
          website: listing.website,
          email: listing.email,
          facebook: listing.facebook,
          instagram: listing.instagram,
          youtube: listing.youtube,
          pinterest: listing.pinterest,
          twitter: listing.twitter,
          whatsapp: listing.whatsapp,
          contentID: listing.contentID,
          lang: listing.lang,
          showAll: listing.showAll,
          title: listing.title,
          sef: listing.sef,
          summary: listing.summary,
          content: listing.content,
          imglang: listing.imglang,
          sortOrder: listing.sortOrder,
          mainImage: listing.mainImage,
          name: listing.name

          //listingid: json.decode(response.body)['data']['listings'][0]
          //  ['listingID'],
          // businessid: json.decode(response.body)['phone'],
          );
      //todo:

      //_listings.insert(0, newListing);
      _listings.add(newListing);

      // _items.insert(0, newProduct); // at the start of the list
      notifyListeners();
      print(json.decode(response.body));
      var responseMap;
      responseMap = json.decode(response.body);

      print("I'm printing responsemap");
      print(responseMap);
      print(responseMap['data']['listings'][0]['listingID']);

      _returnedNewId = responseMap['data']['listings'][0]['listingID'];

      return _returnedNewId!;

      //   print(json.decode(response.body));
    } catch (error) {
      print(error);
      throw error;
    }
  }

  ////100222
  Future<void> deleteImage(int listingID, String name) async {
    var request = new http.MultipartRequest("POST", Uri.parse("https://agestmet.com/yigit/v2/controller/imageuploader.php"));

    //reguestte dosyalar ile birlikte gonderilecek bilgiler (request.fields) ile eklenir
    request.fields['deleteimg'] = name;
    request.fields['deleteid'] = listingID.toString();
    //var streamedResponse = await request.send();
    final response = await request.send();
    final ex = _listings.firstWhere((element) => element.listingID == listingID);
    print("*********************");
    print(ex.name);
    ex.name!.remove(name);
    print("*********************");
    print(ex.name);
    notifyListeners();
    //print(http.Response.fromStream(streamedResponse));
    // return await http.Response.fromStream(streamedResponse);
  }

////100222
  Future<void> deleteListing(int id) async {
    final url = Uri.parse('https://agestmet.com/yigit/v2/listings/${id}');

    final request = http.Request(
      "DELETE",
      url,
    );
    request.headers.clear();

    final response = await request.send();

    final existingProductIndex = _listings.indexWhere((list) => list.listingID == id);
    _listings.removeAt(existingProductIndex);
    notifyListeners();

    print(response.statusCode);
  }

  Future<ListingsItem> fetchAndSetListing(int id) async {
    var url = Uri.parse('https://agestmet.com/yigit/v2/listings/${id}');
    final response = await http.get(url);
    final List<ListingsItem> loadedListings = [];
    final extractedData = json.decode(response.body);

    final parsed = extractedData['data']['listings'];

    parsed.forEach((k, v) => print('${k}: ${v}'));

    var listing = ListingsItem(listingID: parsed['listingID'], locationID: parsed['locationID'], categoryIDs: parsed['categoryIDs'], display: parsed['display'], viewCount: parsed['viewCount'], isPaid: parsed['isPaid'], contactID: parsed['contactID'], moduleID: parsed['moduleID'], relationID: parsed['relationID'], coordinate: parsed['coordinate'], address: parsed['address'], phone: parsed['phone'], website: parsed['website'], email: parsed['email'], facebook: parsed['facebook'], instagram: parsed['instagram'], youtube: parsed['youtube'], pinterest: parsed['pinterest'], twitter: parsed['twitter'], whatsapp: parsed['whatsapp'], contentID: parsed['contentID'], categoryID: parsed['categoryID'], lang: parsed['lang'], showAll: parsed['showAll'], title: parsed['title'], sef: parsed['sef'], summary: parsed['summary'], content: parsed['content'], imglang: parsed['imglang'], sortOrder: parsed['sortOrder'], mainImage: parsed['mainImage'], name: parsed['name']);

    return listing;
  }

  Future<void> fetchByListingsCategory(int id) async {
    var url = Uri.parse('https://agestmet.com/yigit/v2/listings/category/${id}');
    // todo: we gonna addd moduleID here and subcategory Apı
    final response = await http.get(
      url,
    );
    final List<ListingsItem> loadedListings = [];
    final extractedData = json.decode(response.body);

    _responseMap = response.statusCode;

    print("RESPONSE");
    print(_responseMap);

    final parsed = extractedData['data']['listings'];

    parsed.forEach((k, v) => print('${k}: ${v}'));

    parsed.forEach((listingId, listingData) {
      loadedListings.add(
        ListingsItem(
            listingID: listingData['listingID'],
            locationID: listingData['locationID'],
            categoryIDs: listingData['categoryIDs'],
            display: listingData['display'],
            viewCount: listingData['viewCount'],
            isPaid: listingData['isPaid'],
            contactID: listingData['contactID'],
            moduleID: listingData['moduleID'],
            relationID: listingData['relationID'],
            coordinate: listingData['coordinate'],
            address: listingData['address'],
            phone: listingData['phone'],
            website: listingData['website'],
            email: listingData['email'],
            facebook: listingData['facebook'],
            instagram: listingData['instagram'],
            youtube: listingData['youtube'],
            pinterest: listingData['pinterest'],
            twitter: listingData['twitter'],
            whatsapp: listingData['whatsapp'],
            contentID: listingData['contentID'],
            categoryID: listingData['categoryID'],
            lang: listingData['lang'],
            showAll: listingData['showAll'],
            title: listingData['title'],
            sef: listingData['sef'],
            summary: listingData['summary'],
            content: listingData['content'],
            imglang: listingData['imglang'],
            sortOrder: listingData['sortOrder'],
            mainImage: listingData['mainImage'],
            name: listingData['name']),
      );
    });
    _listings = loadedListings.reversed.toList();

    notifyListeners();
  }

  Future<void> fetchByListingsCategoryAndLocation(int categid, int locid) async {
    var url = Uri.parse('https://agestmet.com/yigit/v2/controller/listing.php?locationid=${locid}&categoryid=${categid}');
    // todo: we gonna addd moduleID here and subcategory Apı
    final response = await http.get(
      url,
    );
    final List<ListingsItem> loadedListings = [];
    final extractedData = json.decode(response.body);

    _responseMap = response.statusCode;

    print("RESPONSE");
    print(_responseMap);

    final parsed = extractedData['data']['listings'];

    parsed.forEach((k, v) => print('${k}: ${v}'));

    parsed.forEach((listingId, listingData) {
      loadedListings.add(
        ListingsItem(
            listingID: listingData['listingID'],
            locationID: listingData['locationID'],
            categoryIDs: listingData['categoryIDs'],
            display: listingData['display'],
            viewCount: listingData['viewCount'],
            isPaid: listingData['isPaid'],
            contactID: listingData['contactID'],
            moduleID: listingData['moduleID'],
            relationID: listingData['relationID'],
            coordinate: listingData['coordinate'],
            address: listingData['address'],
            phone: listingData['phone'],
            website: listingData['website'],
            email: listingData['email'],
            facebook: listingData['facebook'],
            instagram: listingData['instagram'],
            youtube: listingData['youtube'],
            pinterest: listingData['pinterest'],
            twitter: listingData['twitter'],
            whatsapp: listingData['whatsapp'],
            contentID: listingData['contentID'],
            categoryID: listingData['categoryID'],
            lang: listingData['lang'],
            showAll: listingData['showAll'],
            title: listingData['title'],
            sef: listingData['sef'],
            summary: listingData['summary'],
            content: listingData['content'],
            ////100222
            imglang: listingData['imglang'],
            sortOrder: listingData['sortOrder'],
            mainImage: listingData['mainImage'],
            name: listingData['name']),
      );
    });
    _listings = loadedListings.reversed.toList();

    notifyListeners();
  }
}
