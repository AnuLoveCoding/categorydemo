import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SubCategory extends StatefulWidget {


  @override
  State<SubCategory> createState() => _SubCategoryState();
}

class _SubCategoryState extends State<SubCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Hello Singh'),),
        body: FutureBuilder<List<dynamic>>(
          future: subCategory(),
          builder: (context,abc){
            if(abc.hasData){
              return ListView.builder(
                  itemCount: abc.data?.length,
                  itemBuilder: (context,i){
                    return Column(
                      children: [
                        ListTile(title: Text(abc.data?[i]['subname']),),
                        Image.network("http://www.digitechy.in.net/upload/"+abc.data?[i]['subimg'])
                      ],
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
    var response = await http.get(Uri.parse("http://www.digitechy.in.net/Webservice1.asmx/SubCatApi?id=2"));
    if(response.statusCode ==  200){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data show successfully')));
      return jsonDecode(response.body);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: CircularProgressIndicator()));
      throw Exception("Failed Data Image");
    }
  }
}
