import 'package:categorydemo/subCategory.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Category extends StatefulWidget {


  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hello Singh'),),
        body: FutureBuilder<List<dynamic>>(
          future: ApiMansoori(),
          builder: (context,abc){
            if(abc.hasData){
              return ListView.builder(
                  itemCount: abc.data?.length,
                  itemBuilder: (context,i){
                    return InkWell(
                        onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return SubCategory(id: abc.data?[i]['id']);
                      }));
                    },
                        child:Column(
                               children: [
                              ListTile(title: Text(abc.data?[i]['Cname']),),
                              Image.network("http://api.namanraj.link/upload/"+abc.data?[i]['Cimg'])
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

  /* void ApiMansoori() async{
    final response = await http.get(Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=6903c9a6ac5d223816242ef6cebdf038&language=en-US&page=1'));
    if (response.statusCode == 200){
      print(response.body);
    }
    else{
      throw Exception("failed to load post");
    }
  }*/

  Future<List<dynamic>>ApiMansoori() async {
    final rsspcone =await http.get(Uri.parse("http://api.namanraj.link/WebService1.asmx/CategoryApi"));
    if(rsspcone.statusCode==200){
      return json.decode(rsspcone.body);
    }
    else{
      throw Exception('failed to load data');
    }
  }
}
