import 'package:antalyacomtr_v2/controllers/MenuController.dart';
import 'package:antalyacomtr_v2/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:antalyacomtr_v2/constants.dart';
import '../../providers/listings.dart';
import '../../routes.dart';
import 'components/header.dart';
import 'components/side_menu.dart';
import 'dart:html';
import 'dart:typed_data';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter/foundation.dart';

class EditListingScreen extends StatefulWidget {
  const EditListingScreen({Key? key}) : super(key: key);

  @override
  State<EditListingScreen> createState() => _EditListingScreenState();
}

class _EditListingScreenState extends State<EditListingScreen> {
  final HtmlEditorController htmlController = HtmlEditorController();
  final _locationIDFocusNode = FocusNode();
  final _categoryIDsNode = FocusNode();
  final _displayFocusNode = FocusNode();
  final _viewCountFocusNode = FocusNode();
  final _isPaidFocusNode = FocusNode();
  final _contactIDFocusNode = FocusNode();

  final _coordinateFocusNode = FocusNode();

  //final _imageUrlFocusNode = FocusNode();
  //final _imageUrlController = TextEditingController();

  final _addressFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _websiteFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _facebookFocusNode = FocusNode();
  final _instagramFocusNode = FocusNode();
  final _youtubeFocusNode = FocusNode();
  final _pinterestFocusNode = FocusNode();
  final _twitterFocusNode = FocusNode();
  final _whatsappFocusNode = FocusNode();

  final _langFocusNode = FocusNode();
  final _showAllFocusNode = FocusNode();
  final _titleFocusNode = FocusNode();
  final _sefFocusNode = FocusNode();
  final _contentFocusNode = FocusNode();
  ////100222
  final _imagelangFocusNode = FocusNode();
  final _imagesortOrderFocusNode = FocusNode();
  final _imageMainImageFocusNode = FocusNode();
  ////100222
  final _form = GlobalKey<FormState>();

  var _editedListing = ListingsItem(locationID: 5, categoryIDs: "", display: true, viewCount: 3214, isPaid: true, contactID: 1, moduleID: 23, relationID: 3, coordinate: "", address: "", phone: "", website: "", email: "", facebook: "", instagram: "", youtube: "", pinterest: "", twitter: "", whatsapp: "", contentID: 1, categoryID: 5, lang: "", showAll: 1, title: "", sef: "", summary: "", content: "");

  var _isInit = true;
  var _isLoading = false;

  var _initValues = {"locationID": 5, "categoryIDs": "", "display": true, "viewCount": 3214, "isPaid": true, "contactID": 1, "moduleID": 23, "coordinate": "", "address": "", "phone": "", "website": "", "email": "", "facebook": "", "instagram": "", "youtube": "", "pinterest": "", "twitter": "", "whatsapp": "", "contentID": 1, "categoryID": 4, "lang": "TR", "showAll": 1, "title": "", "sef": "", "summary": "", "content": ""};
  List imagenamekeeper = [];
  @override
  void initState() {
    super.initState();
  }

//!! PROVİDER

/*   Future<void> makePatchRequest() async {
    final id = ModalRoute.of(context)!.settings.arguments as int;
    final url = Uri.parse('https://agestmet.com/yigit/v2/listings/${id}');
    final headers = {"Content-type": "application/json"};
    final json = '{"title": "Hello"}';
    final response = await http.patch(url, headers: headers, body: json);
    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');
  }
 */
//!! PROVİDER

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final listingId = ModalRoute.of(context)!.settings.arguments as int;
      if (listingId != 0) {
        _editedListing = Provider.of<Listings>(context, listen: false).findById(listingId);
        ////100222
        if (_editedListing.name != null) {
          for (int j = 0; j < _editedListing.name!.length; j++) {
            imagenamekeeper.add(_editedListing.name![j]);
          }

          _initValues = {
            "locationID": _editedListing.locationID!,
            "categoryIDs": _editedListing.categoryIDs!,
            "display": _editedListing.display!,
            "viewCount": _editedListing.viewCount!,
            "isPaid": _editedListing.isPaid!,
            "contactID": _editedListing.contactID!,
            "moduleID": _editedListing.moduleID!,
            "relationID": _editedListing.relationID!,
            "coordinate": _editedListing.coordinate!,
            "address": _editedListing.address!,
            "phone": _editedListing.phone!,
            "website": _editedListing.website!,
            "email": _editedListing.email!,
            "facebook": _editedListing.facebook!,
            "instagram": _editedListing.instagram!,
            "youtube": _editedListing.youtube!,
            "pinterest": _editedListing.pinterest!,
            "twitter": _editedListing.twitter!,
            "whatsapp": _editedListing.whatsapp!,
            "contentID": _editedListing.contentID!,
            "categoryID": _editedListing.categoryID!,
            "lang": _editedListing.lang!,
            "showAll": _editedListing.showAll!,
            "title": _editedListing.title!,
            "sef": _editedListing.sef!,
            "summary": _editedListing.summary!,
            "content": _editedListing.content!,
            "imglang": _editedListing.imglang!,
            "sortOrder": _editedListing.sortOrder!,
            "mainImage": _editedListing.mainImage!,
            "name": _editedListing.name!
          };
        } else {
          _initValues = {
            "locationID": _editedListing.locationID!,
            "categoryIDs": _editedListing.categoryIDs!,
            "display": _editedListing.display!,
            "viewCount": _editedListing.viewCount!,
            "isPaid": _editedListing.isPaid!,
            "contactID": _editedListing.contactID!,
            "moduleID": _editedListing.moduleID!,
            "relationID": _editedListing.relationID!,
            "coordinate": _editedListing.coordinate!,
            "address": _editedListing.address!,
            "phone": _editedListing.phone!,
            "website": _editedListing.website!,
            "email": _editedListing.email!,
            "facebook": _editedListing.facebook!,
            "instagram": _editedListing.instagram!,
            "youtube": _editedListing.youtube!,
            "pinterest": _editedListing.pinterest!,
            "twitter": _editedListing.twitter!,
            "whatsapp": _editedListing.whatsapp!,
            "contentID": _editedListing.contentID!,
            "categoryID": _editedListing.categoryID!,
            "lang": _editedListing.lang!,
            "showAll": _editedListing.showAll!,
            "title": _editedListing.title!,
            "sef": _editedListing.sef!,
            "summary": _editedListing.summary!,
            "content": _editedListing.content!
          };
        }
////100222
        print(_initValues);
        // _imageUrlController.text = _editedBusiness.imageurl;
      } /* else {
        _initValues = {
          "locationID": _editedListing.locationID!,
          "categoryIDs": _editedListing.categoryIDs!,
          "display": _editedListing.display!,
          "viewCount": _editedListing.viewCount!,
          "isPaid": _editedListing.isPaid!,
          "contactID": _editedListing.contactID!,
          "moduleID": _editedListing.moduleID!,
          "relationID": _editedListing.relationID!,
          "coordinate": _editedListing.coordinate!,
          "address": _editedListing.address!,
          "phone": _editedListing.phone!,
          "website": _editedListing.website!,
          "email": _editedListing.email!,
          "facebook": _editedListing.facebook!,
          "instagram": _editedListing.instagram!,
          "youtube": _editedListing.youtube!,
          "pinterest": _editedListing.pinterest!,
          "twitter": _editedListing.twitter!,
          "whatsapp": _editedListing.whatsapp!,
          "contentID": _editedListing.contentID!,
          "categoryID": _editedListing.categoryID!,
          "lang": _editedListing.lang!,
          "showAll": _editedListing.showAll!,
          "title": _editedListing.title!,
          "sef": _editedListing.sef!,
          "summary": _editedListing.summary!,
          "content": _editedListing.content!
          // 'imageUrl': _editedProduct.imageUrl,
        };
      } */
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _locationIDFocusNode.dispose();
    _categoryIDsNode.dispose();
    _displayFocusNode.dispose();
    _viewCountFocusNode.dispose();
    _isPaidFocusNode.dispose();
    _contactIDFocusNode.dispose();

    _coordinateFocusNode.dispose();
    //final _imageUrlFocusNode = FocusNode();
    //final _imageUrlController = TextEditingController();

    _addressFocusNode.dispose();
    _phoneFocusNode.dispose();
    _websiteFocusNode.dispose();
    _emailFocusNode.dispose();
    _facebookFocusNode.dispose();
    _instagramFocusNode.dispose();
    _youtubeFocusNode.dispose();
    _pinterestFocusNode.dispose();
    _twitterFocusNode.dispose();
    _whatsappFocusNode.dispose();

    _langFocusNode.dispose();
    _showAllFocusNode.dispose();
    _titleFocusNode.dispose();
    _sefFocusNode.dispose();
    _contentFocusNode.dispose();

    // _imageUrlController.dispose();
    // _imageUrlFocusNode.dispose();

    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Listings>(context, listen: false).addListings(_editedListing).then((value) => Navigator.of(context).pushNamed(Routes.home));
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

  Future<void> _changeForm() async {
    final listingId = ModalRoute.of(context)!.settings.arguments as int;
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();

    setState(() {
      _isLoading = true;
    });
    try {
      ////100222
      await Provider.of<Listings>(context, listen: false).makePatchRequest(listingId, _editedListing).then((int id) => uploadFile(id, 0).then((value) => {Navigator.of(context).pushNamed(Routes.home)}));
      ////100222
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

////100222
  ///**********************************///IMAGE ZONE///**********************************///

  int? selectedfilessize; //secilen dosyalarin total boyutu
  List<int>? selectedfileslistasint; //secilen dosyalarin int formatinda tutuldugu liste
  List<File>? selectedfiles; //secilen dosyalarin tutuldugu liste
  List<Uint8List>? selectedfilesasUint8; //secilen dosyalarin Uint8 formatina donusturulmus halini tutar
  List<Uint8List>? imageshow;
  bool imageloading = false;

  List<String> imglang = [];
  List<bool> imgSortOrder = [];
  List<bool> imgMainImage = [];

  startFilePicker() {
    setState(() {
      imageloading = true;
    });
    selectedfilessize = 0;
    selectedfilesasUint8 = [];
    imageshow = [];
    selectedfileslistasint = [];
    FileUploadInputElement uploadInput = FileUploadInputElement();
    uploadInput.multiple = true;
    uploadInput.draggable = true;
    uploadInput.accept = '.png,.jpg'; //Hangi turlerde dosya secilebeilecekse uzantisi yazilir. tum dosya tiplerine izin vermek icin bu satırı yoruma al.
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      setState(() {
        selectedfiles = uploadInput.files; //secilen dosyalar selectedfiles degiskenine atılır.
      });

      //secilen dosyalarin toplam boyutu hesaplanir
      for (var i = 0; i < selectedfiles!.length; i++) {
        selectedfilessize = selectedfilessize! + selectedfiles![i].size;
      }

      //secilen dosyalar Uint8List formatinda yeni bir listeye aktarilir
      for (var i = 0; i < selectedfiles!.length; i++) {
        final reader = FileReader();
        reader.onLoadEnd.listen((e) {
          setState(() {
            selectedfilesasUint8!.add(reader.result as Uint8List);
            imglang.add("ml");
            imgSortOrder.add(false);
            imgMainImage.add(false);
          });
        });

        reader.readAsArrayBuffer(selectedfiles![i]);
      }
      imageloading = false;
    });
  }

  Future<http.Response?> uploadFile(int? newsID, int? countlastimages) async {
    print(newsID);

    try {
      var request = new http.MultipartRequest("POST", Uri.parse("https://agestmet.com/yigit/v2/controller/imageuploader.php"));

      //reguestte dosyalar ile birlikte gonderilecek bilgiler (request.fields) ile eklenir
      request.fields['listingID'] = newsID.toString();
      request.fields['imglang'] = imglang.toString();
      request.fields['imgSortOrder'] = imgSortOrder.toString();
      request.fields['imgMainImage'] = imgMainImage.toString();

      //gonderilecek dosyalar requeste eklenir
      for (var i = 0; i < selectedfilesasUint8!.length; i++) {
        selectedfileslistasint = List.from(selectedfilesasUint8![i]); //Uint8List formatındaki yuklenecek olan dosyaları int formatında listeye cevirir
        request.files.add(http.MultipartFile.fromBytes('file[]', selectedfileslistasint!, contentType: MediaType('application', 'octet-stream'), filename: selectedfiles![i].name));
      }

      //gerekli bilgiler eklenmis request gonderilir
      var streamedResponse = await request.send();

      return await http.Response.fromStream(streamedResponse);
    } catch (e) {
      Exception(e);
    }
  }

  ///**********************************///IMAGE ZONE///**********************************///

  ///////100222
  @override
  Widget build(BuildContext context) {
    String htmlResult = '';
    return Scaffold(
      key: context.read<MenuController>().scaffoldKeyEditlistings,
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
                        title: "Edit Listing",
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
                            child: Wrap(
                              children: [
                                SingleChildScrollView(
                                  child: Center(
                                    child: Column(children: <Widget>[
/*               SizedBox(
                height: 400,
                width: 400,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                        "https://agestmet.com/yigit/v2/images/news/newsimage150-2")),
              ), */
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
                                                Wrap(children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: ConstrainedBox(
                                                      constraints: BoxConstraints.tight(const Size(400, 100)),
                                                      child: TextFormField(
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return 'Please provide a value.';
                                                          }
                                                          return null;
                                                        },
                                                        textInputAction: TextInputAction.next,
                                                        initialValue: _initValues['categoryIDs'].toString(),
                                                        decoration: InputDecoration(labelText: 'Category'),
                                                        onFieldSubmitted: (_) {
                                                          FocusScope.of(context).requestFocus(_coordinateFocusNode);
                                                        },
//readOnly: listingId != 0 ? true : false,
                                                        onSaved: (value) {
                                                          // print(_editedListing.categoryIDs);
                                                          _editedListing = ListingsItem(locationID: 5, categoryIDs: value, display: _editedListing.display, viewCount: _editedListing.viewCount, isPaid: _editedListing.isPaid, contactID: _editedListing.contactID, moduleID: _editedListing.moduleID, coordinate: _editedListing.coordinate, address: _editedListing.address, phone: _editedListing.phone, website: _editedListing.website, email: _editedListing.email, facebook: _editedListing.facebook, instagram: _editedListing.instagram, youtube: _editedListing.youtube, pinterest: _editedListing.pinterest, twitter: _editedListing.twitter, whatsapp: _editedListing.whatsapp, contentID: 2, categoryID: 5, lang: _editedListing.lang, showAll: 1, title: _editedListing.title, sef: _editedListing.sef, summary: _editedListing.summary, content: _editedListing.content, imglang: _editedListing.imglang, sortOrder: _editedListing.sortOrder, mainImage: _editedListing.mainImage, name: _editedListing.name);
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  /*
                          todo: For category selection
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ConstrainedBox(
                              constraints:
                                  BoxConstraints.tight(const Size(200, 60)),
                              child: DropdownButton<String>(
                                value: dropdownValue,
                                isExpanded: true,
                                icon: const Icon(Icons.arrow_downward),
                                elevation: 16,
                                style:
                                    const TextStyle(color: Colors.deepPurple),
                                underline: Container(
                                    height: 2, color: Colors.deepPurpleAccent),
                                onChanged: (String newValue) {
                                  setState(() {
                                    dropdownValue = newValue;
                                  });
                                },
                                items: <String>[
                                  'Category',
                                  'Two',
                                  'Free',
                                  'Four'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),

                          */
                                                ]),
                                                Wrap(
                                                  children: [
/*                             Container(
                                width: 300,
                                child: InputDecorator(
                                  isEmpty: _editedListing.display == '',
                                  decoration: InputDecoration(
                                      hintText: 'display',
                                      labelText: 'display',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(5.0))),
                                  child: DropdownButtonHideUnderline(
                                      child: DropdownButton<bool>(
                                    value: _editedListing.display,
                                    isDense: true,
                                    icon: const Icon(Icons.arrow_downward),
                                    elevation: 16,
                                    style: const TextStyle(
                                        color: Colors.deepPurple),
                                    underline: Container(
                                      height: 2,
                                      color: Colors.deepPurpleAccent,
                                    ),
                                    onChanged: (bool? newValue) {
                                      setState(() {
                                        _editedListing.display = newValue!;
                                      });
                                    },
                                    items: <bool>[
                                      true,
                                      false
                                    ].map<DropdownMenuItem<bool>>((bool value) {
                                      return DropdownMenuItem<bool>(
                                        value: value,
                                        child: Text(value.toString()),
                                      );
                                    }).toList(),
                                  )),
                                )), */
                                                    SizedBox(
                                                      width: 100,
                                                    ),
/*                             Container(
                                width: 300,
                                child: DropDownFormField(
                                  titleText: 'Lokasyon',
                                  hintText: 'please choose one',
                                  value: ,
                                  onSaved: ,
                                  onChanged: ,
                                  dataSource: [
                                    { "display" : "Kaş",
                                      "value" : 1,
                                    },
                                    { "display" : "Kemer",
                                      "value" : 2
                                    },
                                    {

                                    },
                                  ],
                                )), */
                                                  ],
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: ConstrainedBox(
                                                    constraints: BoxConstraints.tight(const Size(200, 100)),
                                                    child: TextFormField(
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return 'Please provide a value.';
                                                        }
                                                        return null;
                                                      },
                                                      initialValue: _initValues['coordinate'].toString(),
                                                      maxLines: null,
                                                      keyboardType: TextInputType.multiline,
                                                      focusNode: _addressFocusNode,
                                                      decoration: InputDecoration(labelText: 'Coordinate'),
                                                      //     readOnly: listingId != 0 ? true : false,
                                                      onSaved: (value) {
                                                        // print(_editedListing.coordinate);
                                                        _editedListing = ListingsItem(
                                                            locationID: _editedListing.locationID,
                                                            categoryIDs: _editedListing.categoryIDs,
                                                            display: _editedListing.display,
                                                            viewCount: _editedListing.viewCount,
                                                            isPaid: _editedListing.isPaid,
                                                            contactID: _editedListing.contactID,
                                                            moduleID: _editedListing.moduleID,
                                                            coordinate: value,
                                                            address: _editedListing.address,
                                                            phone: _editedListing.phone,
                                                            website: _editedListing.website,
                                                            email: _editedListing.email,
                                                            facebook: _editedListing.facebook,
                                                            instagram: _editedListing.instagram,
                                                            youtube: _editedListing.youtube,
                                                            pinterest: _editedListing.pinterest,
                                                            twitter: _editedListing.twitter,
                                                            whatsapp: _editedListing.whatsapp,
                                                            contentID: 2,
                                                            lang: _editedListing.lang,
                                                            showAll: 1,
                                                            categoryID: _editedListing.categoryID,
                                                            title: _editedListing.title,
                                                            sef: _editedListing.sef,
                                                            summary: _editedListing.summary,
                                                            content: _editedListing.content,
                                                            imglang: _editedListing.imglang,
                                                            sortOrder: _editedListing.sortOrder,
                                                            mainImage: _editedListing.mainImage,
                                                            name: _editedListing.name);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: ConstrainedBox(
                                                      constraints: BoxConstraints.tight(const Size(400, 50)),
                                                      child: TextFormField(
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return 'Please provide a value.';
                                                          }
                                                          return null;
                                                        },
                                                        initialValue: _initValues['address'].toString(),
                                                        decoration: InputDecoration(labelText: 'Address'),
                                                        //      readOnly: listingId != 0 ? true : false,
                                                        onSaved: (value) {
                                                          _editedListing = ListingsItem(categoryIDs: _editedListing.categoryIDs, display: _editedListing.display, viewCount: _editedListing.viewCount, isPaid: _editedListing.isPaid, contactID: _editedListing.contactID, moduleID: _editedListing.moduleID, coordinate: _editedListing.coordinate, address: value, phone: _editedListing.phone, website: _editedListing.website, email: _editedListing.email, facebook: _editedListing.facebook, instagram: _editedListing.instagram, youtube: _editedListing.youtube, pinterest: _editedListing.pinterest, twitter: _editedListing.twitter, whatsapp: _editedListing.whatsapp, contentID: 2, categoryID: 5, lang: _editedListing.lang, showAll: 1, title: _editedListing.title, sef: _editedListing.sef, summary: _editedListing.summary, content: _editedListing.content, imglang: _editedListing.imglang, sortOrder: _editedListing.sortOrder, mainImage: _editedListing.mainImage, name: _editedListing.name);
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
                                                        initialValue: _initValues['phone'].toString(),
                                                        inputFormatters: <TextInputFormatter>[
                                                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                                        ],
                                                        decoration: InputDecoration(labelText: 'Phone'),
                                                        //      readOnly: listingId != 0 ? true : false,
                                                        onSaved: (value) {
                                                          _editedListing = ListingsItem(locationID: 5, categoryIDs: _editedListing.categoryIDs, display: _editedListing.display, viewCount: _editedListing.viewCount, isPaid: _editedListing.isPaid, contactID: _editedListing.contactID, moduleID: _editedListing.moduleID, coordinate: _editedListing.coordinate, address: _editedListing.address, phone: value, website: _editedListing.website, email: _editedListing.email, facebook: _editedListing.facebook, instagram: _editedListing.instagram, youtube: _editedListing.youtube, pinterest: _editedListing.pinterest, twitter: _editedListing.twitter, whatsapp: _editedListing.whatsapp, contentID: 2, categoryID: 5, lang: _editedListing.lang, showAll: 1, title: _editedListing.title, sef: _editedListing.sef, summary: _editedListing.summary, content: _editedListing.content, imglang: _editedListing.imglang, sortOrder: _editedListing.sortOrder, mainImage: _editedListing.mainImage, name: _editedListing.name);
                                                        },
                                                      ),
                                                    ),
                                                  )
                                                ]),
                                                Wrap(crossAxisAlignment: WrapCrossAlignment.center, children: <Widget>[
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: ConstrainedBox(
                                                      constraints: BoxConstraints.tight(const Size(400, 50)),
                                                      child: TextFormField(
                                                        validator: (value) {
                                                          if (value!.isEmpty) {
                                                            return 'Please provide a value.';
                                                          }
                                                          return null;
                                                        },
                                                        //          readOnly: listingId != 0 ? true : false,
                                                        initialValue: _initValues['website'].toString(),
                                                        decoration: InputDecoration(labelText: 'Website'),
                                                        onSaved: (value) {
                                                          _editedListing = ListingsItem(locationID: 5, categoryIDs: _editedListing.categoryIDs, display: _editedListing.display, viewCount: _editedListing.viewCount, isPaid: _editedListing.isPaid, contactID: _editedListing.contactID, moduleID: _editedListing.moduleID, coordinate: _editedListing.coordinate, address: _editedListing.address, phone: _editedListing.phone, website: value, email: _editedListing.email, facebook: _editedListing.facebook, instagram: _editedListing.instagram, youtube: _editedListing.youtube, pinterest: _editedListing.pinterest, twitter: _editedListing.twitter, whatsapp: _editedListing.whatsapp, contentID: 2, categoryID: 5, lang: _editedListing.lang, showAll: 1, title: _editedListing.title, sef: _editedListing.sef, summary: _editedListing.summary, content: _editedListing.content, imglang: _editedListing.imglang, sortOrder: _editedListing.sortOrder, mainImage: _editedListing.mainImage, name: _editedListing.name);
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
                                                        initialValue: _initValues['email'].toString(),
                                                        decoration: InputDecoration(labelText: 'Email'),
                                                        //         readOnly: listingId != 0 ? true : false,
                                                        onSaved: (value) {
                                                          _editedListing = ListingsItem(locationID: 5, categoryIDs: _editedListing.categoryIDs, display: _editedListing.display, viewCount: _editedListing.viewCount, isPaid: _editedListing.isPaid, contactID: _editedListing.contactID, moduleID: _editedListing.moduleID, coordinate: _editedListing.coordinate, address: _editedListing.address, phone: _editedListing.phone, website: _editedListing.website, email: value, facebook: _editedListing.facebook, instagram: _editedListing.instagram, youtube: _editedListing.youtube, pinterest: _editedListing.pinterest, twitter: _editedListing.twitter, whatsapp: _editedListing.whatsapp, contentID: 2, categoryID: 5, lang: _editedListing.lang, showAll: 1, title: _editedListing.title, sef: _editedListing.sef, summary: _editedListing.summary, content: _editedListing.content, imglang: _editedListing.imglang, sortOrder: _editedListing.sortOrder, mainImage: _editedListing.mainImage, name: _editedListing.name);
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
                                                        initialValue: _initValues['facebook'].toString(),
                                                        decoration: InputDecoration(labelText: 'Facebook'),
                                                        //      readOnly: listingId != 0 ? true : false,
                                                        onSaved: (value) {
                                                          _editedListing = ListingsItem(locationID: 5, categoryIDs: _editedListing.categoryIDs, display: _editedListing.display, viewCount: _editedListing.viewCount, isPaid: _editedListing.isPaid, contactID: _editedListing.contactID, moduleID: _editedListing.moduleID, coordinate: _editedListing.coordinate, address: _editedListing.address, phone: _editedListing.phone, website: _editedListing.website, email: _editedListing.email, facebook: value, instagram: _editedListing.instagram, youtube: _editedListing.youtube, pinterest: _editedListing.pinterest, twitter: _editedListing.twitter, whatsapp: _editedListing.whatsapp, contentID: 2, categoryID: 5, lang: _editedListing.lang, showAll: 1, title: _editedListing.title, sef: _editedListing.sef, summary: _editedListing.summary, content: _editedListing.content, imglang: _editedListing.imglang, sortOrder: _editedListing.sortOrder, mainImage: _editedListing.mainImage, name: _editedListing.name);
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
                                                        initialValue: _initValues['instagram'].toString(),
                                                        decoration: InputDecoration(labelText: 'Instagram'),
                                                        //     readOnly: listingId != 0 ? true : false,
                                                        onSaved: (value) {
                                                          _editedListing = ListingsItem(locationID: 5, categoryIDs: _editedListing.categoryIDs, display: _editedListing.display, viewCount: _editedListing.viewCount, isPaid: _editedListing.isPaid, contactID: _editedListing.contactID, moduleID: _editedListing.moduleID, coordinate: _editedListing.coordinate, address: _editedListing.address, phone: _editedListing.phone, website: _editedListing.website, email: _editedListing.email, facebook: _editedListing.facebook, instagram: value, youtube: _editedListing.youtube, pinterest: _editedListing.pinterest, twitter: _editedListing.twitter, whatsapp: _editedListing.whatsapp, contentID: 2, categoryID: 5, lang: _editedListing.lang, showAll: 1, title: _editedListing.title, sef: _editedListing.sef, summary: _editedListing.summary, content: _editedListing.content, imglang: _editedListing.imglang, sortOrder: _editedListing.sortOrder, mainImage: _editedListing.mainImage, name: _editedListing.name);
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
                                                        initialValue: _initValues['youtube'].toString(),
                                                        decoration: InputDecoration(labelText: 'Youtube'),
                                                        //         readOnly: listingId != 0 ? true : false,
                                                        onSaved: (value) {
                                                          _editedListing = ListingsItem(locationID: 5, categoryIDs: _editedListing.categoryIDs, display: _editedListing.display, viewCount: _editedListing.viewCount, isPaid: _editedListing.isPaid, contactID: _editedListing.contactID, moduleID: _editedListing.moduleID, coordinate: _editedListing.coordinate, address: _editedListing.address, phone: _editedListing.phone, website: _editedListing.website, email: _editedListing.email, facebook: _editedListing.facebook, instagram: _editedListing.instagram, youtube: value, pinterest: _editedListing.pinterest, twitter: _editedListing.twitter, whatsapp: _editedListing.whatsapp, contentID: 2, categoryID: 5, lang: _editedListing.lang, showAll: 1, title: _editedListing.title, sef: _editedListing.sef, summary: _editedListing.summary, content: _editedListing.content, imglang: _editedListing.imglang, sortOrder: _editedListing.sortOrder, mainImage: _editedListing.mainImage, name: _editedListing.name);
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
                                                        initialValue: _initValues['pinterest'].toString(),
                                                        //            readOnly: listingId != 0 ? true : false,
                                                        decoration: InputDecoration(labelText: 'Pinterest'),
                                                        onSaved: (value) {
                                                          _editedListing = ListingsItem(locationID: 5, categoryIDs: _editedListing.categoryIDs, display: _editedListing.display, viewCount: _editedListing.viewCount, isPaid: _editedListing.isPaid, contactID: _editedListing.contactID, moduleID: _editedListing.moduleID, coordinate: _editedListing.coordinate, address: _editedListing.address, phone: _editedListing.phone, website: _editedListing.website, email: _editedListing.email, facebook: _editedListing.facebook, instagram: _editedListing.instagram, youtube: _editedListing.youtube, pinterest: value, twitter: _editedListing.twitter, whatsapp: _editedListing.whatsapp, contentID: 2, categoryID: 5, lang: _editedListing.lang, showAll: 1, title: _editedListing.title, sef: _editedListing.sef, summary: _editedListing.summary, content: _editedListing.content, imglang: _editedListing.imglang, sortOrder: _editedListing.sortOrder, mainImage: _editedListing.mainImage, name: _editedListing.name);
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
                                                        initialValue: _initValues['twitter'].toString(),
                                                        //          readOnly: listingId != 0 ? true : false,
                                                        decoration: InputDecoration(labelText: 'Twitter'),
                                                        onSaved: (value) {
                                                          _editedListing = ListingsItem(locationID: 5, categoryIDs: _editedListing.categoryIDs, display: _editedListing.display, viewCount: _editedListing.viewCount, isPaid: _editedListing.isPaid, contactID: _editedListing.contactID, moduleID: _editedListing.moduleID, coordinate: _editedListing.coordinate, address: _editedListing.address, phone: _editedListing.phone, website: _editedListing.website, email: _editedListing.email, facebook: _editedListing.facebook, instagram: _editedListing.instagram, youtube: _editedListing.youtube, pinterest: _editedListing.pinterest, twitter: value, whatsapp: _editedListing.whatsapp, contentID: 2, categoryID: 5, lang: _editedListing.lang, showAll: 1, title: _editedListing.title, sef: _editedListing.sef, summary: _editedListing.summary, content: _editedListing.content, imglang: _editedListing.imglang, sortOrder: _editedListing.sortOrder, mainImage: _editedListing.mainImage, name: _editedListing.name);
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
                                                        initialValue: _initValues['whatsapp'].toString(),
                                                        decoration: InputDecoration(labelText: 'Whatsapp'),
                                                        //        readOnly: listingId != 0 ? true : false,
                                                        onSaved: (value) {
                                                          _editedListing = ListingsItem(locationID: 5, categoryIDs: _editedListing.categoryIDs, display: _editedListing.display, viewCount: _editedListing.viewCount, isPaid: _editedListing.isPaid, contactID: _editedListing.contactID, moduleID: _editedListing.moduleID, coordinate: _editedListing.coordinate, address: _editedListing.address, phone: _editedListing.phone, website: _editedListing.website, email: _editedListing.email, facebook: _editedListing.facebook, instagram: _editedListing.instagram, youtube: _editedListing.youtube, pinterest: _editedListing.pinterest, twitter: _editedListing.twitter, whatsapp: value, contentID: 2, categoryID: 5, lang: _editedListing.lang, showAll: 1, title: _editedListing.title, sef: _editedListing.sef, summary: _editedListing.summary, content: _editedListing.content, imglang: _editedListing.imglang, sortOrder: _editedListing.sortOrder, mainImage: _editedListing.mainImage, name: _editedListing.name);
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
                                                        initialValue: _initValues['lang'].toString(),
                                                        decoration: InputDecoration(labelText: 'Language'),
                                                        //          readOnly: listingId != 0 ? true : false,
                                                        onSaved: (value) {
                                                          _editedListing = ListingsItem(locationID: 5, categoryIDs: _editedListing.categoryIDs, display: _editedListing.display, viewCount: _editedListing.viewCount, isPaid: _editedListing.isPaid, contactID: _editedListing.contactID, moduleID: _editedListing.moduleID, coordinate: _editedListing.coordinate, address: _editedListing.address, phone: _editedListing.phone, website: _editedListing.website, email: _editedListing.email, facebook: _editedListing.facebook, instagram: _editedListing.instagram, youtube: _editedListing.youtube, pinterest: _editedListing.pinterest, twitter: _editedListing.twitter, whatsapp: _editedListing.whatsapp, contentID: 2, categoryID: 5, lang: value, showAll: 1, title: _editedListing.title, sef: _editedListing.sef, summary: _editedListing.summary, content: _editedListing.content, imglang: _editedListing.imglang, sortOrder: _editedListing.sortOrder, mainImage: _editedListing.mainImage, name: _editedListing.name);
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
                                                        initialValue: _initValues['title'].toString(),
                                                        decoration: InputDecoration(labelText: 'Title'),
                                                        //        readOnly: listingId != 0 ? true : false,
                                                        onSaved: (value) {
                                                          _editedListing = ListingsItem(locationID: 5, categoryIDs: _editedListing.categoryIDs, display: _editedListing.display, viewCount: _editedListing.viewCount, isPaid: _editedListing.isPaid, contactID: _editedListing.contactID, moduleID: _editedListing.moduleID, coordinate: _editedListing.coordinate, address: _editedListing.address, phone: _editedListing.phone, website: _editedListing.website, email: _editedListing.email, facebook: _editedListing.facebook, instagram: _editedListing.instagram, youtube: _editedListing.youtube, pinterest: _editedListing.pinterest, twitter: _editedListing.twitter, whatsapp: _editedListing.whatsapp, contentID: 2, categoryID: 5, lang: _editedListing.lang, showAll: 1, title: value, sef: _editedListing.sef, summary: _editedListing.summary, content: _editedListing.content, imglang: _editedListing.imglang, sortOrder: _editedListing.sortOrder, mainImage: _editedListing.mainImage, name: _editedListing.name);
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
                                                        //        readOnly: listingId != 0 ? true : false,
                                                        onSaved: (value) {
                                                          _editedListing = ListingsItem(locationID: 5, categoryIDs: _editedListing.categoryIDs, display: _editedListing.display, viewCount: _editedListing.viewCount, isPaid: _editedListing.isPaid, contactID: _editedListing.contactID, moduleID: _editedListing.moduleID, coordinate: _editedListing.coordinate, address: _editedListing.address, phone: _editedListing.phone, website: _editedListing.website, email: _editedListing.email, facebook: _editedListing.facebook, instagram: _editedListing.instagram, youtube: _editedListing.youtube, pinterest: _editedListing.pinterest, twitter: _editedListing.twitter, whatsapp: _editedListing.whatsapp, contentID: 2, categoryID: 5, lang: _editedListing.lang, showAll: 1, title: _editedListing.title, sef: value, summary: _editedListing.summary, content: _editedListing.content, imglang: _editedListing.imglang, sortOrder: _editedListing.sortOrder, mainImage: _editedListing.mainImage, name: _editedListing.name);
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
                                                        //        readOnly: listingId != 0 ? true : false,
                                                        decoration: InputDecoration(labelText: 'Summary'),
                                                        onSaved: (value) {
                                                          _editedListing = ListingsItem(locationID: 5, categoryIDs: _editedListing.categoryIDs, display: _editedListing.display, viewCount: _editedListing.viewCount, isPaid: _editedListing.isPaid, contactID: _editedListing.contactID, moduleID: _editedListing.moduleID, coordinate: _editedListing.coordinate, address: _editedListing.address, phone: _editedListing.phone, website: _editedListing.website, email: _editedListing.email, facebook: _editedListing.facebook, instagram: _editedListing.instagram, youtube: _editedListing.youtube, pinterest: _editedListing.pinterest, twitter: _editedListing.twitter, whatsapp: _editedListing.whatsapp, contentID: 2, categoryID: 5, lang: _editedListing.lang, showAll: 1, title: _editedListing.title, sef: _editedListing.sef, summary: value, content: _editedListing.content, imglang: _editedListing.imglang, sortOrder: _editedListing.sortOrder, mainImage: _editedListing.mainImage, name: _editedListing.name);
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  Card(
                                                    elevation: 10,
                                                    child: Wrap(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.all(20.0),
                                                          child: ConstrainedBox(
                                                            constraints: BoxConstraints.tight(const Size(1000, 50)),
                                                            child: Wrap(direction: Axis.horizontal, children: [
                                                              TextButton(
                                                                  child: Wrap(children: [
                                                                    Text("HTML Editor Refresh"),
                                                                    Icon(Icons.refresh),
                                                                  ]),
                                                                  onPressed: () {
                                                                    if (kIsWeb) {
                                                                      htmlController.reloadWeb();
                                                                    } else {
                                                                      htmlController.editorController!.reload();
                                                                    }
                                                                  }),
                                                              TextButton(
                                                                  child: Wrap(children: [
                                                                    Text("Undo"),
                                                                    Icon(Icons.undo),
                                                                  ]),
                                                                  onPressed: () {
                                                                    htmlController.undo();
                                                                  }),
                                                              TextButton(
                                                                onPressed: () async {
                                                                  var txt = await htmlController.getText();
                                                                  if (txt.contains('src=\"data:')) {
                                                                    txt = '<text removed due to base-64 data, displaying the text could cause the app to crash>';
                                                                  }
                                                                  setState(() {
                                                                    htmlResult = txt;

                                                                    _editedListing = ListingsItem(
                                                                        locationID: _editedListing.locationID,
                                                                        categoryIDs: _editedListing.categoryIDs,
                                                                        display: _editedListing.display,
                                                                        viewCount: _editedListing.viewCount,
                                                                        isPaid: _editedListing.isPaid,
                                                                        contactID: _editedListing.contactID,
                                                                        moduleID: _editedListing.moduleID,
                                                                        coordinate: _editedListing.coordinate,
                                                                        address: _editedListing.address,
                                                                        phone: _editedListing.phone,
                                                                        website: _editedListing.website,
                                                                        email: _editedListing.email,
                                                                        facebook: _editedListing.facebook,
                                                                        instagram: _editedListing.instagram,
                                                                        youtube: _editedListing.youtube,
                                                                        pinterest: _editedListing.pinterest,
                                                                        twitter: _editedListing.twitter,
                                                                        whatsapp: _editedListing.whatsapp,
                                                                        contentID: 2,
                                                                        categoryID: _editedListing.categoryID,
                                                                        lang: _editedListing.lang,
                                                                        showAll: 1,
                                                                        title: _editedListing.title,
                                                                        sef: _editedListing.sef,
                                                                        summary: _editedListing.summary,
                                                                        content: htmlResult,
                                                                        trueFalseArray: _editedListing.trueFalseArray,
                                                                        startingTimeArray: _editedListing.startingTimeArray,
                                                                        finishingTimearray: _editedListing.finishingTimearray,
                                                                        imglang: _editedListing.imglang,
                                                                        sortOrder: _editedListing.sortOrder,
                                                                        mainImage: _editedListing.mainImage,
                                                                        name: _editedListing.name);
                                                                  });

                                                                  htmlController.disable();
                                                                },
                                                                child: Wrap(children: [
                                                                  Text("Save HTML"),
                                                                  Icon(Icons.save),
                                                                ]),
                                                              ),
                                                              TextButton(
                                                                onPressed: () async {
                                                                  htmlController.enable();
                                                                },
                                                                child: Wrap(children: [
                                                                  Text("Continue Editing"),
                                                                  Icon(Icons.edit),
                                                                ]),
                                                              ),
                                                            ]),
                                                          ),
                                                        ),
                                                        Padding(
                                                            padding: const EdgeInsets.all(20.0),
                                                            child: ConstrainedBox(
                                                              constraints: BoxConstraints.tight(const Size(1000, 1000)),
                                                              child: HtmlEditor(
                                                                controller: htmlController,
                                                                htmlEditorOptions: HtmlEditorOptions(
                                                                  initialText: _initValues['content'].toString(),
                                                                  hint: 'Your content here...',
                                                                  shouldEnsureVisible: true,
                                                                  //initialText: "<p>text content initial, if any</p>",
                                                                ),
                                                                htmlToolbarOptions: HtmlToolbarOptions(
                                                                  toolbarPosition: ToolbarPosition.aboveEditor, //by default
                                                                  toolbarType: ToolbarType.nativeScrollable, //by default
                                                                  onButtonPressed: (ButtonType type, bool? status, Function? updateStatus) {
                                                                    print("button '${describeEnum(type)}' pressed, the current selected status is $status");
                                                                    return true;
                                                                  },
                                                                  onDropdownChanged: (DropdownType type, dynamic changed, Function(dynamic)? updateSelectedItem) {
                                                                    print("dropdown '${describeEnum(type)}' changed to $changed");
                                                                    return true;
                                                                  },
                                                                  mediaLinkInsertInterceptor: (String url, InsertFileType type) {
                                                                    print(url);
                                                                    return true;
                                                                  },
                                                                  mediaUploadInterceptor: (PlatformFile file, InsertFileType type) async {
                                                                    print(file.name); //filename
                                                                    print(file.size); //size in bytes
                                                                    print(file.extension); //file extension (eg jpeg or mp4)
                                                                    return true;
                                                                  },
                                                                ),
                                                                otherOptions: OtherOptions(height: 550),
                                                                callbacks: Callbacks(onBeforeCommand: (String? currentHtml) {
                                                                  print('html before change is $currentHtml');
                                                                }, onChangeContent: (String? changed) {
                                                                  print('content changed to $changed');
                                                                }, onChangeCodeview: (String? changed) {
                                                                  print('code changed to $changed');
                                                                }, onChangeSelection: (EditorSettings settings) {
                                                                  print('parent element is ${settings.parentElement}');
                                                                  print('font name is ${settings.fontName}');
                                                                }, onDialogShown: () {
                                                                  print('dialog shown');
                                                                }, onEnter: () {
                                                                  print('enter/return pressed');
                                                                }, onFocus: () {
                                                                  print('editor focused');
                                                                }, onBlur: () {
                                                                  print('editor unfocused');
                                                                }, onBlurCodeview: () {
                                                                  print('codeview either focused or unfocused');
                                                                }, onInit: () {
                                                                  print('init');
                                                                },
                                                                    //this is commented because it overrides the default Summernote handlers
                                                                    /*onImageLinkInsert: (String? url) {
                                                                     print(url ?? "unknown url");
                                                                   },
                                                                   onImageUpload: (FileUpload file) async {
                                                                     print(file.name);
                                                                     print(file.size);
                                                                     print(file.type);
                                                                     print(file.base64);
                                                                   },*/
                                                                    onImageUploadError: (FileUpload? file, String? base64Str, UploadError error) {
                                                                  print(describeEnum(error));
                                                                  print(base64Str ?? '');
                                                                  if (file != null) {
                                                                    print(file.name);
                                                                    print(file.size);
                                                                    print(file.type);
                                                                  }
                                                                }, onKeyDown: (int? keyCode) {
                                                                  print('$keyCode key downed');
                                                                  print('current character count: ${htmlController.characterCount}');
                                                                }, onKeyUp: (int? keyCode) {
                                                                  print('$keyCode key released');
                                                                }, onMouseDown: () {
                                                                  print('mouse downed');
                                                                }, onMouseUp: () {
                                                                  print('mouse released');
                                                                }, onNavigationRequestMobile: (String url) {
                                                                  print(url);
                                                                  return NavigationActionPolicy.ALLOW;
                                                                }, onPaste: () {
                                                                  print('pasted into editor');
                                                                }, onScroll: () {
                                                                  print('editor scrolled');
                                                                }),
                                                                plugins: [
                                                                  SummernoteAtMention(
                                                                      getSuggestionsMobile: (String value) {
                                                                        var mentions = <String>['test1', 'test2', 'test3'];
                                                                        return mentions.where((element) => element.contains(value)).toList();
                                                                      },
                                                                      mentionsWeb: ['test1', 'test2', 'test3'],
                                                                      onSelect: (String value) {
                                                                        print(value);
                                                                      }),
                                                                ],
                                                              ),
                                                            )),
                                                      ],
                                                    ),
                                                  ),

                                                  /* Padding(
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
                                                        //        readOnly: listingId != 0 ? true : false,
                                                        onSaved: (value) {
                                                          _editedListing = ListingsItem(locationID: 5, categoryIDs: _editedListing.categoryIDs, display: _editedListing.display, viewCount: _editedListing.viewCount, isPaid: _editedListing.isPaid, contactID: _editedListing.contactID, moduleID: _editedListing.moduleID, coordinate: _editedListing.coordinate, address: _editedListing.address, phone: _editedListing.phone, website: _editedListing.website, email: _editedListing.email, facebook: _editedListing.facebook, instagram: _editedListing.instagram, youtube: _editedListing.youtube, pinterest: _editedListing.pinterest, twitter: _editedListing.twitter, whatsapp: _editedListing.whatsapp, contentID: 2, categoryID: 5, lang: _editedListing.lang, showAll: 1, title: _editedListing.title, sef: _editedListing.sef, summary: _editedListing.summary, content: value);
                                                        },
                                                      ),
                                                    ),
                                                  ),*/
                                                ]),
                                                ////100222
                                                if (_editedListing.name!.length != null && _editedListing.name!.length != 0)
                                                  Wrap(
                                                    children: [
                                                      for (int j = 0; j < _editedListing.name!.length; j++)
                                                        Card(
                                                          elevation: 8,
                                                          child: Column(
                                                            children: [
                                                              SizedBox(width: 100, height: 100, child: Image.network('https://agestmet.com/yigit/v2/images/listings/' + _editedListing.name![j])),
                                                              ConstrainedBox(
                                                                  constraints: BoxConstraints.tight(const Size(200, 50)),
                                                                  child: InputDecorator(
                                                                    decoration: InputDecoration(hintText: 'lang', labelText: 'lang', border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                                                                    child: DropdownButtonHideUnderline(
                                                                        child: DropdownButton<String>(
                                                                      value: _editedListing.imglang![j].toString(),
                                                                      isDense: true,
                                                                      icon: const Icon(Icons.arrow_downward),
                                                                      elevation: 16,
                                                                      style: const TextStyle(color: Colors.deepPurple),
                                                                      underline: Container(
                                                                        height: 2,
                                                                        color: Colors.deepPurpleAccent,
                                                                      ),
                                                                      onChanged: (String? newValue) {
                                                                        FocusScope.of(context).requestFocus(_imagelangFocusNode);
                                                                        _editedListing.imglang![j] = newValue!;
                                                                      },
                                                                      items: <String>["ml", "tr", "en", "de", "py"].map<DropdownMenuItem<String>>((String value) {
                                                                        return DropdownMenuItem<String>(
                                                                          value: value,
                                                                          child: Text(value.toString()),
                                                                        );
                                                                      }).toList(),
                                                                    )),
                                                                  )),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              ConstrainedBox(
                                                                  constraints: BoxConstraints.tight(const Size(200, 50)),
                                                                  child: InputDecorator(
                                                                    decoration: InputDecoration(hintText: 'sortOrder', labelText: 'sortOrder', border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                                                                    child: DropdownButtonHideUnderline(
                                                                        child: DropdownButton<bool>(
                                                                      value: _editedListing.sortOrder![j] == 0 ? false : true,
                                                                      isDense: true,
                                                                      icon: const Icon(Icons.arrow_downward),
                                                                      elevation: 16,
                                                                      style: const TextStyle(color: Colors.deepPurple),
                                                                      underline: Container(
                                                                        height: 2,
                                                                        color: Colors.deepPurpleAccent,
                                                                      ),
                                                                      onChanged: (bool? newValue) {
                                                                        FocusScope.of(context).requestFocus(_imagesortOrderFocusNode);
                                                                        _editedListing.sortOrder![j] = newValue! == false ? 0 : 1;
                                                                      },
                                                                      items: <bool>[true, false].map<DropdownMenuItem<bool>>((bool value) {
                                                                        return DropdownMenuItem<bool>(
                                                                          value: value,
                                                                          child: Text(value.toString()),
                                                                        );
                                                                      }).toList(),
                                                                    )),
                                                                  )),
                                                              SizedBox(
                                                                height: 10,
                                                              ),
                                                              ConstrainedBox(
                                                                  constraints: BoxConstraints.tight(const Size(200, 50)),
                                                                  child: InputDecorator(
                                                                    decoration: InputDecoration(hintText: 'mainImage', labelText: 'mainImage', border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                                                                    child: DropdownButtonHideUnderline(
                                                                        child: DropdownButton<bool>(
                                                                      value: _editedListing.mainImage![j] == 0 ? false : true,
                                                                      isDense: true,
                                                                      icon: const Icon(Icons.arrow_downward),
                                                                      elevation: 16,
                                                                      style: const TextStyle(color: Colors.deepPurple),
                                                                      underline: Container(
                                                                        height: 2,
                                                                        color: Colors.deepPurpleAccent,
                                                                      ),
                                                                      onChanged: (bool? newValue) {
                                                                        FocusScope.of(context).requestFocus(_imageMainImageFocusNode);
                                                                        _editedListing.mainImage![j] = newValue! == false ? 0 : 1;
                                                                      },
                                                                      items: <bool>[true, false].map<DropdownMenuItem<bool>>((bool value) {
                                                                        return DropdownMenuItem<bool>(
                                                                          value: value,
                                                                          child: Text(value.toString()),
                                                                        );
                                                                      }).toList(),
                                                                    )),
                                                                  )),
                                                              TextButton.icon(
                                                                onPressed: () async {
                                                                  await Provider.of<Listings>(context, listen: false).deleteImage(_editedListing.listingID!, _editedListing.name![j]);
                                                                  setState(() {});
                                                                },
                                                                icon: const Icon(Icons.remove, size: 18),
                                                                label: const Text("Sil"),
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                    ],
                                                  ),

                                                Wrap(
                                                  children: [
                                                    if (selectedfilesasUint8 != null && selectedfilesasUint8!.length != 0)
                                                      for (var i = 0; i < selectedfilesasUint8!.length; i++)
                                                        Card(
                                                            elevation: 8,
                                                            child: Column(
                                                              children: [
                                                                Image.memory(
                                                                  selectedfilesasUint8![i],
                                                                  width: 100,
                                                                  height: 100,
                                                                ),
                                                                ConstrainedBox(
                                                                    constraints: BoxConstraints.tight(const Size(200, 50)),
                                                                    child: InputDecorator(
                                                                      decoration: InputDecoration(hintText: 'lang', labelText: 'lang', border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                                                                      child: DropdownButtonHideUnderline(
                                                                          child: DropdownButton<String>(
                                                                        value: imglang[i],
                                                                        isDense: true,
                                                                        icon: const Icon(Icons.arrow_downward),
                                                                        elevation: 16,
                                                                        style: const TextStyle(color: Colors.deepPurple),
                                                                        underline: Container(
                                                                          height: 2,
                                                                          color: Colors.deepPurpleAccent,
                                                                        ),
                                                                        onChanged: (String? newValue) {
                                                                          imglang[i] = newValue!;
                                                                        },
                                                                        items: <String>["ml", "tr", "en", "de", "py"].map<DropdownMenuItem<String>>((String value) {
                                                                          return DropdownMenuItem<String>(
                                                                            value: value,
                                                                            child: Text(value.toString()),
                                                                          );
                                                                        }).toList(),
                                                                      )),
                                                                    )),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                ConstrainedBox(
                                                                    constraints: BoxConstraints.tight(const Size(200, 50)),
                                                                    child: InputDecorator(
                                                                      decoration: InputDecoration(hintText: 'sortOrder', labelText: 'sortOrder', border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                                                                      child: DropdownButtonHideUnderline(
                                                                          child: DropdownButton<bool>(
                                                                        value: imgSortOrder[i],
                                                                        isDense: true,
                                                                        icon: const Icon(Icons.arrow_downward),
                                                                        elevation: 16,
                                                                        style: const TextStyle(color: Colors.deepPurple),
                                                                        underline: Container(
                                                                          height: 2,
                                                                          color: Colors.deepPurpleAccent,
                                                                        ),
                                                                        onChanged: (bool? newValue) {
                                                                          imgSortOrder[i] = newValue!;
                                                                        },
                                                                        items: <bool>[true, false].map<DropdownMenuItem<bool>>((bool value) {
                                                                          return DropdownMenuItem<bool>(
                                                                            value: value,
                                                                            child: Text(value.toString()),
                                                                          );
                                                                        }).toList(),
                                                                      )),
                                                                    )),
                                                                SizedBox(
                                                                  height: 10,
                                                                ),
                                                                ConstrainedBox(
                                                                    constraints: BoxConstraints.tight(const Size(200, 50)),
                                                                    child: InputDecorator(
                                                                      decoration: InputDecoration(hintText: 'mainImage', labelText: 'mainImage', border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                                                                      child: DropdownButtonHideUnderline(
                                                                          child: DropdownButton<bool>(
                                                                        value: imgMainImage[i],
                                                                        isDense: true,
                                                                        icon: const Icon(Icons.arrow_downward),
                                                                        elevation: 16,
                                                                        style: const TextStyle(color: Colors.deepPurple),
                                                                        underline: Container(
                                                                          height: 2,
                                                                          color: Colors.deepPurpleAccent,
                                                                        ),
                                                                        onChanged: (bool? newValue) {
                                                                          imgMainImage[i] = newValue!;
                                                                        },
                                                                        items: <bool>[true, false].map<DropdownMenuItem<bool>>((bool value) {
                                                                          return DropdownMenuItem<bool>(
                                                                            value: value,
                                                                            child: Text(value.toString()),
                                                                          );
                                                                        }).toList(),
                                                                      )),
                                                                    )),
                                                                TextButton.icon(
                                                                  onPressed: () {
                                                                    setState(() {
                                                                      selectedfilesasUint8?.removeAt(i);
                                                                      imglang.removeAt(i);
                                                                      imgMainImage.removeAt(i);
                                                                      imgSortOrder.removeAt(i);
                                                                    });
                                                                  },
                                                                  icon: const Icon(Icons.remove, size: 18),
                                                                  label: const Text("Sil"),
                                                                )
                                                              ],
                                                            )),
                                                    Card(
                                                        elevation: 8,
                                                        child: Column(
                                                          children: [
                                                            ElevatedButton.icon(
                                                                onPressed: () {
                                                                  startFilePicker();
                                                                },
                                                                icon: const Icon(Icons.add),
                                                                label: Text("Add Image")),
                                                          ],
                                                        ))
                                                  ],
                                                ),
                                                ////100222
                                              ]),
                                            ),
                                          )),
                                    ]),
                                  ),
                                )
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
