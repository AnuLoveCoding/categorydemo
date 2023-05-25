import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'ProductPage.dart';

class SubCategory extends StatefulWidget {
  int id;
  SubCategory({required this.id});

  @override
  State<SubCategory> createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hello Singh'),
          centerTitle: true,
        ),
        body: FutureBuilder<List<dynamic>>(
          future: subCategory(),
          builder: (context,abc){
            if(abc.hasData){
              return ListView.builder(
                  itemCount: abc.data?.length,
                  itemBuilder: (context,i){
                    return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return ProductPage(id: abc.data?[i]['id']);
                          }));
                        },
                        child:Column(
                            children: [
                              ListTile(title: Text(abc.data?[i]["Subname"]),),
                              Image.network("http://api.namanraj.link/upload/"+abc.data?[i]['Subimg'])
                            ],
                        )
                    );
                  }
              );

            }
            else if(abc.hasError){
              return Center(
                child: Text('${abc.error}'),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        )
    );
  }

  Future<List<dynamic>>subCategory() async {
    final rsspcone =await http.get(Uri.parse("http://api.namanraj.link/WebService1.asmx/SubCatApi?id="+widget.id.toString()));
    if(rsspcone.statusCode==200){
      return json.decode(rsspcone.body);
    }
    else{
      throw Exception('failed to load data');
    }
  }
}
