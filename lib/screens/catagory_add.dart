
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../controllers/MenuController.dart';
import 'main/components/header.dart';
import 'main/components/side_menu.dart';
import 'main/main_screen.dart';

import 'package:dropdown_button2/dropdown_button2.dart';

class SizeConfig {
  int count = 0;
   
   static late  MediaQueryData _mediaQueryData;
   static late  double screenWidth;
   static late double screenHeight;
   static late  double blockSizeHorizontal;
   static late double blockSizeVertical;
   static void init(BuildContext context) {
     _mediaQueryData = MediaQuery.of(context);
     screenWidth = _mediaQueryData.size.width;
     screenHeight = _mediaQueryData.size.height;
     blockSizeHorizontal = screenWidth / 100;
     blockSizeVertical = screenHeight / 100;
   }
 }

class NewCategoryScreenn extends StatefulWidget {
 static const routeName = 'new-categorys';

  @override
  _MyStatelessWidgetState createState() => _MyStatelessWidgetState();
}

class _MyStatelessWidgetState extends State<NewCategoryScreenn> {
 
  String _myActivity =" ";
  String _myActivityResult=" ";
 String? selectedValue;
List<String> items = [
  'Item1',
  'Item2',
  'Item3',
  'Item4',
];
  String dropdownValue = 'One';
   final formKey = new GlobalKey<FormState>();

  @override
  void initState() {

    super.initState();
        _myActivity = '';
    _myActivityResult = '';
  
  }


 

  // Platform messages are asynchronous, so we initialize in an async method.


  Widget _home() {
      Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    bool isChecked = false;
    //SizeConfig.init(context);
    var container_height = SizeConfig.blockSizeHorizontal * 100;
    var container_witdth = SizeConfig.blockSizeHorizontal * 100;
    return Container(
      height: container_height,
      width: container_witdth,
         decoration: BoxDecoration(
        
        color: Colors.white,
       // borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Color.fromARGB(26, 245, 11, 11)),
      ),
  
      child: Stack(
        children: [
        /*  Positioned(
            bottom: container_height / 1.8,
            left: container_witdth / 100,
            child: Container(
              height: container_height /1 ,
              width: container_witdth /9.6,
                   decoration: BoxDecoration(
        
        color: Color(0xFF103667),
       // borderRadius: const BorderRadius.all(Radius.circular(10)),rgba(16, 54, 103, 1)
        border: Border.all(color: Color.fromARGB(16, 54, 103, 1)),
      ),
             //child: SideMenu(),
            ),
          ),*/
////title /////////////////////////////////////////
           Positioned(
            bottom: container_height / 1.05,
            left: container_witdth / 7,
            child: Container(
              height: container_height /50 ,
              width: container_witdth /7,
                   decoration: BoxDecoration(
        
        color: Color.fromARGB(255, 252, 254, 255),


        borderRadius: const BorderRadius.all(Radius.circular(3)),
        border: Border.all(color: Color.fromARGB(16, 8, 8, 8)),
      ),

      
         child:  TextField(
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Title'
            
        ),
      ),
            ),
          ),

          




          ////********content */
                 Positioned(
            bottom: container_height / 1.62,
            left: container_witdth / 1.8,
            child: Container(
              height: container_height /3.2,
              width: container_witdth /3,
                   decoration: BoxDecoration(
        
        color: Color.fromARGB(255, 252, 254, 255),


        borderRadius: const BorderRadius.all(Radius.circular(3)),
        border: Border.all(color: Color.fromARGB(16, 8, 8, 8)),
      ),

      
         child:  TextField(
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Content'
            
        ),
      ),
            ),
          ),
          ///**content */
 ////title ///////////////////////////////////////////////////////////////////////
 
        Positioned(
            bottom: container_height / 1.05,
            left: container_witdth / 1.8,
            child: Container(
              height: container_height /50 ,
              width: container_witdth /7,
                   decoration: BoxDecoration(
        
        color: Color.fromARGB(255, 252, 254, 255),


        borderRadius: const BorderRadius.all(Radius.circular(3)),
        border: Border.all(color: Color.fromARGB(16, 8, 8, 8)),
      ),

      
         child:    DropdownButtonHideUnderline(
        child: DropdownButton2(
          hint: Text(
            'Language',
            style: TextStyle(
              fontSize: 14,
              color: Theme
                      .of(context)
                      .hintColor,
            ),
          ),
          items: items
                  .map((item) =>
                  DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
                  .toList(),
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value as String;
            });
          },
          buttonHeight: 40,
          buttonWidth: 140,
          itemHeight: 40,
        ),
      ),
            ),
          ),
 ///// summery //////////////////////////////////
        Positioned(
            bottom: container_height / 1.10,
            left: container_witdth / 7,
            child: Container(
              height: container_height /25 ,
              width: container_witdth /3,
                   decoration: BoxDecoration(
        
        color: Color.fromARGB(255, 252, 254, 255),


        borderRadius: const BorderRadius.all(Radius.circular(3)),
        border: Border.all(color: Color.fromARGB(16, 8, 8, 8)),
      ),

      
         child:  TextField(
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Summery'
            
        ),
      ),
            ),
          ),

 ///////////summeryyy //////////////////////////

        Positioned(
            bottom: container_height / 1.18,
            left: container_witdth / 7,
            child: Container(
              height: container_height /50 ,
              width: container_witdth /7,
                   decoration: BoxDecoration(
        
        color: Color.fromARGB(255, 252, 254, 255),


        borderRadius: const BorderRadius.all(Radius.circular(3)),
        border: Border.all(color: Color.fromARGB(16, 8, 8, 8)),
      ),

      
         child:    DropdownButtonHideUnderline(
        child: DropdownButton2(
          hint: Text(
            'Location',
            style: TextStyle(
              fontSize: 14,
              color: Theme
                      .of(context)
                      .hintColor,
            ),
          ),
          items: items
                  .map((item) =>
                  DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
                  .toList(),
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value as String;
            });
          },
          buttonHeight: 40,
          buttonWidth: 140,
          itemHeight: 40,
        ),
      ),
            ),
          ),

               Positioned(
            bottom: container_height / 1.23,
            left: container_witdth / 7,
            child: Container(
              height: container_height /50 ,
              width: container_witdth /7,
                   decoration: BoxDecoration(
        
        color: Color.fromARGB(255, 252, 254, 255),


        borderRadius: const BorderRadius.all(Radius.circular(3)),
        border: Border.all(color: Color.fromARGB(16, 8, 8, 8)),
      ),

      
         child:    DropdownButtonHideUnderline(
        child: DropdownButton2(
          hint: Text(
            'Working days',
            style: TextStyle(
              fontSize: 14,
              color: Theme
                      .of(context)
                      .hintColor,
            ),
          ),
          items: items
                  .map((item) =>
                  DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
                  .toList(),
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value as String;
            });
          },
          buttonHeight: 40,
          buttonWidth: 140,
          itemHeight: 40,
        ),
      ),
            ),
          ),



        


          
        Positioned(
            bottom: container_height / 1.18,
            left: container_witdth / 3,
            child: Container(
              height: container_height /50 ,
              width: container_witdth /7,
                   decoration: BoxDecoration(
        
        color: Color.fromARGB(255, 252, 254, 255),


        borderRadius: const BorderRadius.all(Radius.circular(3)),
        border: Border.all(color: Color.fromARGB(16, 8, 8, 8)),
      ),

      
         child:    DropdownButtonHideUnderline(
        child: DropdownButton2(
          hint: Text(
            'Coordinate',
            style: TextStyle(
              fontSize: 14,
              color: Theme
                      .of(context)
                      .hintColor,
            ),
          ),
          items: items
                  .map((item) =>
                  DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ))
                  .toList(),
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value as String;
            });
          },
          buttonHeight: 40,
          buttonWidth: 140,
          itemHeight: 40,
        ),
      ),
            ),
          ),




                Positioned(
            bottom: container_height / 1.33,
            left: container_witdth / 7,
            child: Container(
              height: container_height /25 ,
              width: container_witdth /3,
                   decoration: BoxDecoration(
        
        color: Color.fromARGB(255, 252, 254, 255),


        borderRadius: const BorderRadius.all(Radius.circular(3)),
        border: Border.all(color: Color.fromARGB(16, 8, 8, 8)),
      ),

      
         child:  TextField(
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Address'
            
        ),
      ),
            ),
          ),



            Positioned(
            bottom: container_height / 1.40,
            left: container_witdth / 7,
            child: Container(
              height: container_height /50 ,
              width: container_witdth /7,
                   decoration: BoxDecoration(
        
        color: Color.fromARGB(255, 252, 254, 255),


        borderRadius: const BorderRadius.all(Radius.circular(3)),
        border: Border.all(color: Color.fromARGB(16, 8, 8, 8)),
      ),

      
         child:   TextField(
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Phone'
            
        ),
      ),
            ),
          ),




          
        Positioned(
            bottom: container_height / 1.40,
            left: container_witdth / 3,
            child: Container(
              height: container_height /50 ,
              width: container_witdth /7,
                   decoration: BoxDecoration(
        
        color: Color.fromARGB(255, 252, 254, 255),


        borderRadius: const BorderRadius.all(Radius.circular(3)),
        border: Border.all(color: Color.fromARGB(16, 8, 8, 8)),
      ),

      
         child:   TextField(
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Whatsaap'
            
        ),
      ), 
            ),
          ),


                     Positioned(
            bottom: container_height / 1.45,
            left: container_witdth / 7,
            child: Container(
              height: container_height /50 ,
              width: container_witdth /7,
                   decoration: BoxDecoration(
        
        color: Color.fromARGB(255, 252, 254, 255),


        borderRadius: const BorderRadius.all(Radius.circular(3)),
        border: Border.all(color: Color.fromARGB(16, 8, 8, 8)),
      ),

      
         child:   TextField(
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Email'
            
        ),
      ),
            ),
          ),




          
        Positioned(
            bottom: container_height / 1.45,
            left: container_witdth / 3,
            child: Container(
              height: container_height /50 ,
              width: container_witdth /7,
                   decoration: BoxDecoration(
        
        color: Color.fromARGB(255, 252, 254, 255),


        borderRadius: const BorderRadius.all(Radius.circular(3)),
        border: Border.all(color: Color.fromARGB(16, 8, 8, 8)),
      ),

      
         child:   TextField(
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Website'
            
        ),
      ), 
            ),
          ),




          
            Positioned(
            bottom: container_height / 1.50,
            left: container_witdth / 7,
            child: Container(
              height: container_height /50 ,
              width: container_witdth /7,
                   decoration: BoxDecoration(
        
        color: Color.fromARGB(255, 252, 254, 255),


        borderRadius: const BorderRadius.all(Radius.circular(3)),
        border: Border.all(color: Color.fromARGB(16, 8, 8, 8)),
      ),

      
         child:   TextField(
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Facebook'
            
        ),
      ),
            ),
          ),




          
        Positioned(
            bottom: container_height / 1.50,
            left: container_witdth / 3,
            child: Container(
              height: container_height /50 ,
              width: container_witdth /7,
                   decoration: BoxDecoration(
        
        color: Color.fromARGB(255, 252, 254, 255),


        borderRadius: const BorderRadius.all(Radius.circular(3)),
        border: Border.all(color: Color.fromARGB(16, 8, 8, 8)),
      ),

      
         child:   TextField(
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Instagram'
            
        ),
      ), 
            ),
          ),


                     Positioned(
            bottom: container_height / 1.56,
            left: container_witdth / 7,
            child: Container(
              height: container_height /50 ,
              width: container_witdth /7,
                   decoration: BoxDecoration(
        
        color: Color.fromARGB(255, 252, 254, 255),


        borderRadius: const BorderRadius.all(Radius.circular(3)),
        border: Border.all(color: Color.fromARGB(16, 8, 8, 8)),
      ),

      
         child:   TextField(
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Twitter'
            
        ),
      ),
            ),
          ),




          
        Positioned(
            bottom: container_height / 1.56,
            left: container_witdth / 3,
            child: Container(
              height: container_height /50 ,
              width: container_witdth /7,
                   decoration: BoxDecoration(
        
        color: Color.fromARGB(255, 252, 254, 255),


        borderRadius: const BorderRadius.all(Radius.circular(3)),
        border: Border.all(color: Color.fromARGB(16, 8, 8, 8)),
      ),

      
         child:   TextField(
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Pinterest'
            
        ),
      ), )),



          Positioned(
            bottom: container_height / 1.62,
            left: container_witdth / 7,
            child: Container(
              height: container_height /50 ,
              width: container_witdth /7,
                   decoration: BoxDecoration(
        
        color: Color.fromARGB(255, 252, 254, 255),


        borderRadius: const BorderRadius.all(Radius.circular(3)),
        border: Border.all(color: Color.fromARGB(16, 8, 8, 8)),
      ),

      
         child:   TextField(
           
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Youtube'
            
            
            
        ),
      ), 
            ),
          ),

                   Positioned(
            bottom: container_height / 1.7,
            left: container_witdth /1.8,
            child: Container(
           height: container_height /50 ,
              width: container_witdth /9,
                   decoration: BoxDecoration(
        
        color: Color.fromARGB(255, 252, 254, 255),


        borderRadius: const BorderRadius.all(Radius.circular(3)),
        border: Border.all(color: Color.fromARGB(16, 8, 8, 8)),
      ),

      
         child:   ElevatedButton.icon(
                          onPressed: () {
                           // Navigator.of(context).pushNamed(Routes.addCategories, arguments: categoryChoiceIndex);
                          },
                          icon: Icon(Icons.save, size: 18),
                          label: Text("Kaydet"),
                          style: ElevatedButton.styleFrom(primary: Color(0xFFF38F1D), )),
                        ),
            ),
          



        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    //SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  
   
    return Scaffold(
       key: context.read<MenuController>().scaffoldKeyAddCategory,
      drawer: const SideMenu(),
      
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        actionsIconTheme: IconThemeData(size: 30.0, color: Colors.black, opacity: 10.0),
        bottom: PreferredSize(
            child: Container(
              color: Color.fromARGB(255, 10, 0, 0),
              height: 1.0,
            ),
            preferredSize: Size.fromHeight(2.0)),
        //////////////////
        backgroundColor: Color.fromARGB(255, 253, 253, 253),

        //actions: <Widget>[],
        actions: <Widget>[
        
       
             
            SizedBox(width:MediaQuery.of(context).copyWith().size.width / 20,),
             Container(
                height: MediaQuery.of(context).copyWith().size.width / 10,
                width: MediaQuery.of(context).copyWith().size.width / 1.1,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1),
                  //border: Border.all(color: Colors.red)
                ),
                child: Row(children: [


                   new GestureDetector(
              onTap: () {
             
              
               Navigator.push(context, MaterialPageRoute(builder: (context) =>MainScreen()));
              },
                          child:    Container(
                 height: MediaQuery.of(context).copyWith().size.width / 12,
                width: MediaQuery.of(context).copyWith().size.width / 10,
      
   
      decoration: BoxDecoration(
        
        color: Color.fromARGB(255, 255, 255, 255),
        //borderRadius: const BorderRadius.all(Radius.circular(10)),
        //border: Border.all(color: Color.fromARGB(26, 255, 255, 255)),
      ),
      child:       Image.asset(
            "assets/images/antalyacomtr_logo.png",
            
          ),
    ),),
                  
                  
                  
                  
                  
                  
      Text(
     "Kategori Ekle",
     textScaleFactor: SizeConfig.blockSizeHorizontal * 0.08,
     style: TextStyle(color: Color.fromARGB(255, 32, 31, 31)),
   ),
     SizedBox(width:MediaQuery.of(context).copyWith().size.width / 1.6,),

                            Container(
      height: MediaQuery.of(context).copyWith().size.width / 12,
      width: MediaQuery.of(context).copyWith().size.width /35,
      
   
      decoration: BoxDecoration(
        
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Color.fromARGB(26, 255, 255, 255)),
      ),
      child: Row(
        children: [

          const Icon(Icons.notification_add),
        ],
      ),
    ),
                        
      Container(
          height: MediaQuery.of(context).copyWith().size.width / 15,
          width: MediaQuery.of(context).copyWith().size.width / 20,
       
   
      decoration: BoxDecoration(
        
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Color.fromARGB(26, 12, 185, 78)),
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/images/profile_pic.png",
            height: 30,
          ),
          /*if (!Responsive.isMobile(context))
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
              child: Text("Username"),
            ),*/
          const Icon(Icons.keyboard_arrow_down),
        ],
      ),
    ),
    
    
    
    
     ],)
              
              ), 


               
        ],
        
      ),
      body: Column(children: [
        Flexible(
            child: FractionallySizedBox(
                heightFactor: 1,
                widthFactor: 1,
                child: Center(
                   
                     
                        child: ListView(
                         //scrollDirection: Axis.horizontal,
                          children: [
                         _home()
                        
                           
                          ],
                        )))),
      ]),
    );
  }
}









