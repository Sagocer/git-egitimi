import 'package:flutter/material.dart';

class MenuController extends ChangeNotifier {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _scaffoldKeyAddlistings = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _scaffoldKeyListings = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _scaffoldKeyEditlistings = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _scaffoldKeyAddCategory = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _scaffoldKeyEditCategory = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _scaffoldKeyNews = GlobalKey<ScaffoldState>();

  GlobalKey<ScaffoldState> get scaffoldKey => _scaffoldKey; //main
  GlobalKey<ScaffoldState> get scaffoldKeyAddlistings => _scaffoldKeyAddlistings; //addListings-NewListingScreen
  GlobalKey<ScaffoldState> get scaffoldKeyListings => _scaffoldKeyListings; //listings-ListingsScreen
  GlobalKey<ScaffoldState> get scaffoldKeyEditlistings => _scaffoldKeyEditlistings; //editListings-EditListingScreen
  GlobalKey<ScaffoldState> get scaffoldKeyAddCategory => _scaffoldKeyAddCategory; //addCategories-NewCategoryScreen
  GlobalKey<ScaffoldState> get scaffoldKeyEditCategory => _scaffoldKeyEditCategory; //editCategories-EditCategoryScreen
  GlobalKey<ScaffoldState> get scaffoldKeyNews => _scaffoldKeyNews; //newsScreen-NewsScreen
  void controlMenu() {
    if (!_scaffoldKey.currentState!.isDrawerOpen) {
      _scaffoldKey.currentState!.openDrawer();
    }
    if (!_scaffoldKeyAddlistings.currentState!.isDrawerOpen) {
      _scaffoldKeyAddlistings.currentState!.openDrawer();
    }
    if (!_scaffoldKeyListings.currentState!.isDrawerOpen) {
      _scaffoldKeyListings.currentState!.openDrawer();
    }
    if (!_scaffoldKeyEditlistings.currentState!.isDrawerOpen) {
      _scaffoldKeyEditlistings.currentState!.openDrawer();
    }
    if (!_scaffoldKeyAddCategory.currentState!.isDrawerOpen) {
      _scaffoldKeyAddCategory.currentState!.openDrawer();
    }
    if (!_scaffoldKeyEditCategory.currentState!.isDrawerOpen) {
      _scaffoldKeyEditCategory.currentState!.openDrawer();
    }
    if (!_scaffoldKeyNews.currentState!.isDrawerOpen) {
      _scaffoldKeyNews.currentState!.openDrawer();
    }
  }
}
