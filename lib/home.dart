import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';


class MyApp extends StatefulWidget {
   MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
   List _loaddisease = [];

   bool isLoading = false;

   late int disease_id;

   Future<void> getData(String text) async {
     String token="eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjgyODQ3MTg2LCJqdGkiOiJhMTJjMmI1OGNiYzA0ZGMyODFkMGE1OGEwMzk4NDU0YiIsInVzZXJfaWQiOiJiNDM2NTNlOS1iNGExLTRjYzEtODRlOS02YTUzN2U1NGRmOWEifQ.pC-y2Sly9KpredLEzJ1y4B2h_aVYB6qzmWMoOrzRHUY";
     final String apiUrl="https://service-zedzat.tequevia.com/api/v1/zedzat/product-category/?category_type=${text}";
     final response = await http.get(
       Uri.parse(apiUrl),
       headers: {'Authorization': 'Bearer $token'},
     );
     if (response.statusCode == 200) {
       // Request successful
       var items = json.decode(response.body);
       // print('specialdata${items}');
       setState(() {
         _loaddisease = items;

       });
       print(response.body);
     } else {
       // Request failed
       print('Request failed with status: ${response.statusCode}.');
     }
   }

   bool _showGridView = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.logo_dev,color: Colors.black,size: 35,),SizedBox(width: 8,),
            Text('ZEDZAT',style: TextStyle(
                fontSize: 30,color: Colors.black
            ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Icon(Icons.location_on_outlined),
              Text('Govindapuram,kozhikode,kerala,india'),
            ],
          ),
          SizedBox(height: 10,),
          ListView(
            shrinkWrap: true,
            children: [
              CarouselSlider(
                items: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/img1.jpg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/img2.jpg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/img3.jpg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),

                ],
                options: CarouselOptions(
                  height: 150,

                  enlargeCenterPage: true,
                  aspectRatio: 16 / 9,
                  autoPlay: true,
                  autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                  enableInfiniteScroll: true,
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  viewportFraction: 0.8,
                ),
              ),
            ],
          ),
        SingleChildScrollView(
    physics: ScrollPhysics(),
    child: Column(
    children: [
    Row(
    children: [
    Expanded(child: ElevatedButton(onPressed: (){
    getData("product");
    _showGridView = true;
    }, child: Text("Product"))),
    Expanded(child: ElevatedButton(onPressed: (){
    getData("service");
    _showGridView = true;
    }, child: Text("Service")))
    ],
    ),
    if (_showGridView)
    GridView.builder(
    shrinkWrap: true,
    physics: NeverScrollableScrollPhysics(),
    padding: const EdgeInsets.all(10),
    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent:200,
    childAspectRatio: 2 / 3,
    crossAxisSpacing: 20,
    mainAxisSpacing: 20),
    itemCount: _loaddisease.length,
    itemBuilder: (BuildContext ctx, index) {

    return GestureDetector(
    onTap:(){
    String image= _loaddisease[index]['category_image'];
    print("dataimage${image}");

    },
    child: Column(
    children: [
    CircleAvatar(
    backgroundColor: Colors.white,
    backgroundImage: NetworkImage(_loaddisease[index]['category_image']),
    radius: 40.0,
    ),
    Align(
    alignment: Alignment.center,
    child: Text(
    _loaddisease[index]['category_name'] ,
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
    fontFamily: 'LuxuriousRoman',
    fontSize: 18,
    color: Color(0xFF8F371B),
    ),
    ),
    ),
    ],
    ),
    );
    })
    ],
    ),
    ),

    ]
      ),
    );
  }
}

