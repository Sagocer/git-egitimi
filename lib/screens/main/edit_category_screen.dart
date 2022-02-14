import 'package:antalyacomtr_v2/controllers/MenuController.dart';
import 'package:antalyacomtr_v2/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:antalyacomtr_v2/constants.dart';
import 'components/header.dart';
import 'components/side_menu.dart';

import 'dart:async';

import '../../routes.dart';

import '../../providers/categories.dart';

class EditCategoryScreen extends StatefulWidget {
  static const routeName = 'new-category';
  @override
  _EditCategoryScreenState createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {
  //loc

//choicechip
  List<String>? _choices;
  int? _choiceIndex;
//choicechip

/////
  final _form = GlobalKey<FormState>();

  final _categorydisplayFocusNode = FocusNode();
  final _forFilterFocusNode = FocusNode();
  final _forDiscoveryFocusNode = FocusNode();
  final _showHomePageFocusNode = FocusNode();
  final _sortOrderFocusNode = FocusNode();
  final _langFocusNode = FocusNode();
  final _contentdisplayFocusNode = FocusNode();
  final _showAllFocusNode = FocusNode();
  final _titleFocusNode = FocusNode();
  final _sefFocusNode = FocusNode();
  final _contentFocusNode = FocusNode();

  var _categoryListing = CategoriesItem(displayCategory: true, forFilter: false, forDiscovery: false, showHomePage: false, sortOrder: false, lang: "tr", displayContent: false, showAll: 1, title: "", sef: "", summary: "", content: "");

  var _isInit = true;
  var _isLoading = false;

  var _initValues = {"displayCategory": false, "forFilter": false, "forDiscovery": false, "showHomePage": false, "sortOrder": false, "lang": "tr", "displayContent": false, "showAll": 1, "title": "", "sef": "", "summary": "", "content": ""};

  @override
  void initState() {
    // _choiceIndex = 0;
    _choices = ["Kaş", "Kemer", "Muratpaşa", "Alanya", "Side"];
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final categoryId = ModalRoute.of(context)!.settings.arguments as int;
      if (categoryId != 0) {
        _categoryListing = Provider.of<Categories>(context, listen: false).findById(categoryId);

        _initValues = {"displayCategory": _categoryListing.displayCategory!, "forFilter": _categoryListing.forFilter!, "forDiscovery": _categoryListing.forDiscovery!, "showHomePage": _categoryListing.showHomePage!, "sortOrder": _categoryListing.sortOrder!, "lang": _categoryListing.lang!, "displayContent": _categoryListing.displayContent!, "showAll": _categoryListing.showAll!, "title": _categoryListing.title!, "sef": _categoryListing.sef!, "summary": _categoryListing.summary!, "content": _categoryListing.content!};
        print(_initValues);
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _forFilterFocusNode.dispose();

    _categorydisplayFocusNode.dispose();
    _forFilterFocusNode.dispose();
    _forDiscoveryFocusNode.dispose();
    _showHomePageFocusNode.dispose();
    _sortOrderFocusNode.dispose();
    _langFocusNode.dispose();
    _contentdisplayFocusNode.dispose();
    _showAllFocusNode.dispose();
    _titleFocusNode.dispose();
    _sefFocusNode.dispose();
    _contentFocusNode.dispose();

    super.dispose();
  }

  Future<void> _saveParentCategory() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      final parentId = ModalRoute.of(context)!.settings.arguments as int;
      await Provider.of<Categories>(context, listen: false).addCategory(_categoryListing, 0).then((value) => Navigator.of(context).pushNamed(Routes.home));
    } catch (error) {
      print(error);
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occurred!'),
          content: Text('Something went wrong.'),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: () {
                // Navigator.of(context).pushReplacementNamed(ListingsScreen.routeName);
              },
            )
          ],
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _saveSubCategory() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      final parentId = ModalRoute.of(context)!.settings.arguments as int;

      await Provider.of<Categories>(context, listen: false).addCategory(_categoryListing, parentId).then((value) => Navigator.of(context).pushNamed(Routes.home));
    } catch (error) {
      print(error);
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occurred!'),
          content: Text('Something went wrong.'),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: () {
                // Navigator.of(context).pushReplacementNamed(ListingsScreen.routeName);
              },
            )
          ],
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _changeForm() async {
    final categoryId = ModalRoute.of(context)!.settings.arguments as int;
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();

    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Categories>(context, listen: false).makePatchRequest(categoryId, _categoryListing).then((value) => Navigator.of(context).pushNamed(Routes.home));
    } catch (error) {
      print(error);
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An error occurred!'),
          content: Text('Something went wrong.'),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(Routes.home);
              },
            )
          ],
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final parentId = ModalRoute.of(context)!.settings.arguments as int;

    return Scaffold(
      key: context.read<MenuController>().scaffoldKeyEditCategory,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              const Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      const Header(
                        title: "Edit Category",
                      ),
                      const SizedBox(height: defaultPadding),
                      ElevatedButton.icon(
                        onPressed: _changeForm,
                        icon: Icon(Icons.change_circle, size: 18),
                        label: Text("Save Changes"),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Form(
                                      key: _form,
                                      child: SizedBox(
                                        height: 900,
                                        child: ListView(children: <Widget>[
                                          ///choice chips
                                          /*                         FormField( 

                          builder: 
                          
                          SizedBox(
                              height: 100,
                              width: 100,
                              child: Container(
                                height: MediaQuery.of(context).size.height / 4,
                                child: ListView.builder(
                                  itemCount: _choices!.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    return ChoiceChip(
                                      label: Text(_choices![index]),
                                      selected: _choiceIndex == index,
                                      selectedColor: Colors.red,
                                      onSelected: (bool selected) {
                                        setState(() {
                                          _choiceIndex = selected ? index : 0;
                                        });
                                      },
                                      backgroundColor: Colors.green,
                                      labelStyle: TextStyle(color: Colors.white),
                                    );
                                  },
                                ),
                              ),
                            ),
                            
                        ), */

                                          /*
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                              height: 500, width: 400, child: Summary_Screen()),
                        ),
                        */

                                          Divider(
                                            color: Colors.red,
                                          ),
                                          Divider(color: Colors.red),
                                          Divider(color: Colors.red),

                                          Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              child: ConstrainedBox(
                                                  constraints: BoxConstraints.tight(const Size(400, 50)),
                                                  child: InputDecorator(
                                                    decoration: InputDecoration(hintText: 'displayCategory', labelText: 'displayCategory', border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                                                    child: DropdownButtonHideUnderline(
                                                        child: DropdownButton<bool>(
                                                      value: _categoryListing.displayCategory,
                                                      isDense: true,
                                                      icon: const Icon(Icons.arrow_downward),
                                                      elevation: 16,
                                                      style: const TextStyle(color: Colors.deepPurple),
                                                      underline: Container(
                                                        height: 2,
                                                        color: Colors.deepPurpleAccent,
                                                      ),
                                                      onChanged: (bool? newValue) {
                                                        FocusScope.of(context).requestFocus(_categorydisplayFocusNode);
                                                        _categoryListing = CategoriesItem(
                                                          displayCategory: newValue,
                                                          forFilter: _categoryListing.forFilter,
                                                          forDiscovery: _categoryListing.forDiscovery,
                                                          showHomePage: _categoryListing.showHomePage,
                                                          sortOrder: _categoryListing.sortOrder,
                                                          lang: _categoryListing.lang,
                                                          displayContent: _categoryListing.displayContent,
                                                          showAll: _categoryListing.showAll,
                                                          title: _categoryListing.title,
                                                          sef: _categoryListing.sef,
                                                          summary: _categoryListing.summary,
                                                          content: _categoryListing.content,
                                                        );
                                                      },
                                                      items: <bool>[true, false].map<DropdownMenuItem<bool>>((bool value) {
                                                        return DropdownMenuItem<bool>(
                                                          value: value,
                                                          child: Text(value.toString()),
                                                        );
                                                      }).toList(),
                                                    )),
                                                  )),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              child: ConstrainedBox(
                                                  constraints: BoxConstraints.tight(const Size(400, 50)),
                                                  child: InputDecorator(
                                                    decoration: InputDecoration(hintText: 'forDiscovery', labelText: 'forDiscovery', border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                                                    child: DropdownButtonHideUnderline(
                                                        child: DropdownButton<bool>(
                                                      value: _categoryListing.forDiscovery,
                                                      isDense: true,
                                                      icon: const Icon(Icons.arrow_downward),
                                                      elevation: 16,
                                                      style: const TextStyle(color: Colors.deepPurple),
                                                      underline: Container(
                                                        height: 2,
                                                        color: Colors.deepPurpleAccent,
                                                      ),
                                                      onChanged: (bool? newValue) {
                                                        FocusScope.of(context).requestFocus(_forDiscoveryFocusNode);
                                                        _categoryListing = CategoriesItem(
                                                          displayCategory: _categoryListing.displayCategory,
                                                          forFilter: _categoryListing.forFilter,
                                                          forDiscovery: newValue,
                                                          showHomePage: _categoryListing.showHomePage,
                                                          sortOrder: _categoryListing.sortOrder,
                                                          lang: _categoryListing.lang,
                                                          displayContent: _categoryListing.displayContent,
                                                          showAll: _categoryListing.showAll,
                                                          title: _categoryListing.title,
                                                          sef: _categoryListing.sef,
                                                          summary: _categoryListing.summary,
                                                          content: _categoryListing.content,
                                                        );
                                                      },
                                                      items: <bool>[true, false].map<DropdownMenuItem<bool>>((bool value) {
                                                        return DropdownMenuItem<bool>(
                                                          value: value,
                                                          child: Text(value.toString()),
                                                        );
                                                      }).toList(),
                                                    )),
                                                  )),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              child: ConstrainedBox(
                                                  constraints: BoxConstraints.tight(const Size(400, 50)),
                                                  child: InputDecorator(
                                                    decoration: InputDecoration(hintText: 'forFilter', labelText: 'forFilter', border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                                                    child: DropdownButtonHideUnderline(
                                                        child: DropdownButton<bool>(
                                                      value: _categoryListing.forFilter,
                                                      isDense: true,
                                                      icon: const Icon(Icons.arrow_downward),
                                                      elevation: 16,
                                                      style: const TextStyle(color: Colors.deepPurple),
                                                      underline: Container(
                                                        height: 2,
                                                        color: Colors.deepPurpleAccent,
                                                      ),
                                                      onChanged: (bool? newValue) {
                                                        FocusScope.of(context).requestFocus(_forFilterFocusNode);
                                                        _categoryListing = CategoriesItem(
                                                          displayCategory: _categoryListing.displayCategory,
                                                          forFilter: newValue,
                                                          forDiscovery: _categoryListing.forDiscovery,
                                                          showHomePage: _categoryListing.showHomePage,
                                                          sortOrder: _categoryListing.sortOrder,
                                                          lang: _categoryListing.lang,
                                                          displayContent: _categoryListing.displayContent,
                                                          showAll: _categoryListing.showAll,
                                                          title: _categoryListing.title,
                                                          sef: _categoryListing.sef,
                                                          summary: _categoryListing.summary,
                                                          content: _categoryListing.content,
                                                        );
                                                      },
                                                      items: <bool>[true, false].map<DropdownMenuItem<bool>>((bool value) {
                                                        return DropdownMenuItem<bool>(
                                                          value: value,
                                                          child: Text(value.toString()),
                                                        );
                                                      }).toList(),
                                                    )),
                                                  )),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              child: ConstrainedBox(
                                                  constraints: BoxConstraints.tight(const Size(400, 50)),
                                                  child: InputDecorator(
                                                    decoration: InputDecoration(hintText: 'showHomePage', labelText: 'showHomePage', border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                                                    child: DropdownButtonHideUnderline(
                                                        child: DropdownButton<bool>(
                                                      value: _categoryListing.showHomePage,
                                                      isDense: true,
                                                      icon: const Icon(Icons.arrow_downward),
                                                      elevation: 16,
                                                      style: const TextStyle(color: Colors.deepPurple),
                                                      underline: Container(
                                                        height: 2,
                                                        color: Colors.deepPurpleAccent,
                                                      ),
                                                      onChanged: (bool? newValue) {
                                                        FocusScope.of(context).requestFocus(_showHomePageFocusNode);
                                                        _categoryListing = CategoriesItem(
                                                          displayCategory: _categoryListing.displayCategory,
                                                          forFilter: _categoryListing.forFilter,
                                                          forDiscovery: _categoryListing.forDiscovery,
                                                          showHomePage: newValue,
                                                          sortOrder: _categoryListing.sortOrder,
                                                          lang: _categoryListing.lang,
                                                          displayContent: _categoryListing.displayContent,
                                                          showAll: _categoryListing.showAll,
                                                          title: _categoryListing.title,
                                                          sef: _categoryListing.sef,
                                                          summary: _categoryListing.summary,
                                                          content: _categoryListing.content,
                                                        );
                                                      },
                                                      items: <bool>[true, false].map<DropdownMenuItem<bool>>((bool value) {
                                                        return DropdownMenuItem<bool>(
                                                          value: value,
                                                          child: Text(value.toString()),
                                                        );
                                                      }).toList(),
                                                    )),
                                                  )),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              child: ConstrainedBox(
                                                  constraints: BoxConstraints.tight(const Size(200, 50)),
                                                  child: InputDecorator(
                                                    decoration: InputDecoration(hintText: 'sortOrder', labelText: 'sortOrder', border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                                                    child: DropdownButtonHideUnderline(
                                                        child: DropdownButton<bool>(
                                                      value: _categoryListing.sortOrder,
                                                      isDense: true,
                                                      icon: const Icon(Icons.arrow_downward),
                                                      elevation: 16,
                                                      style: const TextStyle(color: Colors.deepPurple),
                                                      underline: Container(
                                                        height: 2,
                                                        color: Colors.deepPurpleAccent,
                                                      ),
                                                      onChanged: (bool? newValue) {
                                                        FocusScope.of(context).requestFocus(_sortOrderFocusNode);
                                                        _categoryListing = CategoriesItem(
                                                          displayCategory: _categoryListing.displayCategory,
                                                          forFilter: _categoryListing.forFilter,
                                                          forDiscovery: _categoryListing.forDiscovery,
                                                          showHomePage: _categoryListing.showHomePage,
                                                          sortOrder: newValue,
                                                          lang: _categoryListing.lang,
                                                          displayContent: _categoryListing.displayContent,
                                                          showAll: _categoryListing.showAll,
                                                          title: _categoryListing.title,
                                                          sef: _categoryListing.sef,
                                                          summary: _categoryListing.summary,
                                                          content: _categoryListing.content,
                                                        );
                                                      },
                                                      items: <bool>[true, false].map<DropdownMenuItem<bool>>((bool value) {
                                                        return DropdownMenuItem<bool>(
                                                          value: value,
                                                          child: Text(value.toString()),
                                                        );
                                                      }).toList(),
                                                    )),
                                                  )),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              child: ConstrainedBox(
                                                  constraints: BoxConstraints.tight(const Size(200, 50)),
                                                  child: InputDecorator(
                                                    decoration: InputDecoration(hintText: 'lang', labelText: 'lang', border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                                                    child: DropdownButtonHideUnderline(
                                                        child: DropdownButton<String>(
                                                      value: _categoryListing.lang,
                                                      isDense: true,
                                                      icon: const Icon(Icons.arrow_downward),
                                                      elevation: 16,
                                                      style: const TextStyle(color: Colors.deepPurple),
                                                      underline: Container(
                                                        height: 2,
                                                        color: Colors.deepPurpleAccent,
                                                      ),
                                                      onChanged: (String? newValue) {
                                                        FocusScope.of(context).requestFocus(_sortOrderFocusNode);
                                                        _categoryListing = CategoriesItem(
                                                          displayCategory: _categoryListing.displayCategory,
                                                          forFilter: _categoryListing.forFilter,
                                                          forDiscovery: _categoryListing.forDiscovery,
                                                          showHomePage: _categoryListing.showHomePage,
                                                          sortOrder: _categoryListing.sortOrder,
                                                          lang: newValue,
                                                          displayContent: _categoryListing.displayContent,
                                                          showAll: _categoryListing.showAll,
                                                          title: _categoryListing.title,
                                                          sef: _categoryListing.sef,
                                                          summary: _categoryListing.summary,
                                                          content: _categoryListing.content,
                                                        );
                                                      },
                                                      items: <String>["tr", "en", "de", "py"].map<DropdownMenuItem<String>>((String value) {
                                                        return DropdownMenuItem<String>(
                                                          value: value,
                                                          child: Text(value.toString()),
                                                        );
                                                      }).toList(),
                                                    )),
                                                  )),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              child: ConstrainedBox(
                                                  constraints: BoxConstraints.tight(const Size(400, 50)),
                                                  child: InputDecorator(
                                                    decoration: InputDecoration(hintText: 'displayContent', labelText: 'displayContent', border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                                                    child: DropdownButtonHideUnderline(
                                                        child: DropdownButton<bool>(
                                                      value: _categoryListing.displayContent,
                                                      isDense: true,
                                                      icon: const Icon(Icons.arrow_downward),
                                                      elevation: 16,
                                                      style: const TextStyle(color: Colors.deepPurple),
                                                      underline: Container(
                                                        height: 2,
                                                        color: Colors.deepPurpleAccent,
                                                      ),
                                                      onChanged: (bool? newValue) {
                                                        FocusScope.of(context).requestFocus(_categorydisplayFocusNode);
                                                        _categoryListing = CategoriesItem(
                                                          displayCategory: _categoryListing.displayCategory,
                                                          forFilter: _categoryListing.forFilter,
                                                          forDiscovery: _categoryListing.forDiscovery,
                                                          showHomePage: _categoryListing.showHomePage,
                                                          sortOrder: _categoryListing.sortOrder,
                                                          lang: _categoryListing.lang,
                                                          displayContent: newValue,
                                                          showAll: _categoryListing.showAll,
                                                          title: _categoryListing.title,
                                                          sef: _categoryListing.sef,
                                                          summary: _categoryListing.summary,
                                                          content: _categoryListing.content,
                                                        );
                                                      },
                                                      items: <bool>[true, false].map<DropdownMenuItem<bool>>((bool value) {
                                                        return DropdownMenuItem<bool>(
                                                          value: value,
                                                          child: Text(value.toString()),
                                                        );
                                                      }).toList(),
                                                    )),
                                                  )),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              child: ConstrainedBox(
                                                  constraints: BoxConstraints.tight(const Size(400, 50)),
                                                  child: InputDecorator(
                                                    decoration: InputDecoration(hintText: 'showAll', labelText: 'showAll', border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                                                    child: DropdownButtonHideUnderline(
                                                        child: DropdownButton<int>(
                                                      value: _categoryListing.showAll,
                                                      isDense: true,
                                                      icon: const Icon(Icons.arrow_downward),
                                                      elevation: 16,
                                                      style: const TextStyle(color: Colors.deepPurple),
                                                      underline: Container(
                                                        height: 2,
                                                        color: Colors.deepPurpleAccent,
                                                      ),
                                                      onChanged: (int? newValue) {
                                                        FocusScope.of(context).requestFocus(_showAllFocusNode);
                                                        _categoryListing = CategoriesItem(
                                                          displayCategory: _categoryListing.displayCategory,
                                                          forFilter: _categoryListing.forFilter,
                                                          forDiscovery: _categoryListing.forDiscovery,
                                                          showHomePage: _categoryListing.showHomePage,
                                                          sortOrder: _categoryListing.sortOrder,
                                                          lang: _categoryListing.lang,
                                                          displayContent: _categoryListing.displayContent,
                                                          showAll: newValue,
                                                          title: _categoryListing.title,
                                                          sef: _categoryListing.sef,
                                                          summary: _categoryListing.summary,
                                                          content: _categoryListing.content,
                                                        );
                                                      },
                                                      items: <int>[0, 1].map<DropdownMenuItem<int>>((int value) {
                                                        return DropdownMenuItem<int>(
                                                          value: value,
                                                          child: Text(value.toString()),
                                                        );
                                                      }).toList(),
                                                    )),
                                                  )),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              child: ConstrainedBox(
                                                constraints: BoxConstraints.tight(const Size(400, 50)),
                                                child: TextFormField(
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Please provide a value.';
                                                    }
                                                    return null;
                                                  },
                                                  initialValue: _initValues['title'].toString(),
                                                  decoration: InputDecoration(labelText: 'Title'),
                                                  //     readOnly: listingId != 0 ? true : false,
                                                  onSaved: (value) {
                                                    _categoryListing = CategoriesItem(
                                                      displayCategory: _categoryListing.displayCategory,
                                                      forFilter: _categoryListing.forFilter,
                                                      forDiscovery: _categoryListing.forDiscovery,
                                                      showHomePage: _categoryListing.showHomePage,
                                                      sortOrder: _categoryListing.sortOrder,
                                                      displayContent: _categoryListing.displayContent,
                                                      lang: _categoryListing.lang,
                                                      showAll: _categoryListing.showAll,
                                                      title: value,
                                                      sef: _categoryListing.sef,
                                                      summary: _categoryListing.summary,
                                                      content: _categoryListing.content,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              child: ConstrainedBox(
                                                constraints: BoxConstraints.tight(const Size(400, 50)),
                                                child: TextFormField(
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Please provide a value.';
                                                    }
                                                    return null;
                                                  },
                                                  initialValue: _initValues['sef'].toString(),
                                                  decoration: InputDecoration(labelText: 'Sef'),
                                                  //      readOnly: listingId != 0 ? true : false,
                                                  onSaved: (value) {
                                                    _categoryListing = CategoriesItem(
                                                      displayCategory: _categoryListing.displayCategory,
                                                      forFilter: _categoryListing.forFilter,
                                                      forDiscovery: _categoryListing.forDiscovery,
                                                      showHomePage: _categoryListing.showHomePage,
                                                      sortOrder: _categoryListing.sortOrder,
                                                      displayContent: _categoryListing.displayContent,
                                                      lang: _categoryListing.lang,
                                                      showAll: _categoryListing.showAll,
                                                      title: _categoryListing.title,
                                                      sef: value,
                                                      summary: _categoryListing.summary,
                                                      content: _categoryListing.content,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              child: ConstrainedBox(
                                                constraints: BoxConstraints.tight(const Size(400, 50)),
                                                child: TextFormField(
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Please provide a value.';
                                                    }
                                                    return null;
                                                  },
                                                  initialValue: _initValues['summary'].toString(),
                                                  //  readOnly: listingId != 0 ? true : false,
                                                  decoration: InputDecoration(labelText: 'Summary'),
                                                  onSaved: (value) {
                                                    _categoryListing = CategoriesItem(
                                                      displayCategory: _categoryListing.displayCategory,
                                                      forFilter: _categoryListing.forFilter,
                                                      forDiscovery: _categoryListing.forDiscovery,
                                                      showHomePage: _categoryListing.showHomePage,
                                                      sortOrder: _categoryListing.sortOrder,
                                                      displayContent: _categoryListing.displayContent,
                                                      lang: _categoryListing.lang,
                                                      showAll: _categoryListing.showAll,
                                                      title: _categoryListing.title,
                                                      sef: _categoryListing.sef,
                                                      summary: value,
                                                      content: _categoryListing.content,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(20.0),
                                              child: ConstrainedBox(
                                                constraints: BoxConstraints.tight(const Size(400, 50)),
                                                child: TextFormField(
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Please provide a value.';
                                                    }
                                                    return null;
                                                  },
                                                  initialValue: _initValues['content'].toString(),
                                                  decoration: InputDecoration(labelText: 'Content'),
                                                  //     readOnly: listingId != 0 ? true : false,
                                                  onSaved: (value) {
                                                    _categoryListing = CategoriesItem(
                                                      displayCategory: _categoryListing.displayCategory,
                                                      forFilter: _categoryListing.forFilter,
                                                      forDiscovery: _categoryListing.forDiscovery,
                                                      showHomePage: _categoryListing.showHomePage,
                                                      sortOrder: _categoryListing.sortOrder,
                                                      displayContent: _categoryListing.displayContent,
                                                      lang: _categoryListing.lang,
                                                      showAll: _categoryListing.showAll,
                                                      title: _categoryListing.title,
                                                      sef: _categoryListing.sef,
                                                      summary: _categoryListing.summary,
                                                      content: value,
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ]),
                                        ]),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
