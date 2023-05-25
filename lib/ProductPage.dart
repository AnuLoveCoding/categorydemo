import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class ProductPage extends StatefulWidget {
  int id;
  ProductPage({required this.id});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text("Product Page"),
    ),
     body: FutureBuilder<List<dynamic>>(
          future: product(),
          builder: (context,abc){
            if(abc.hasData){
              return ListView.builder(
                  itemCount: abc.data?.length,
                  itemBuilder: (context,i){
                    return InkWell( onTap: (){

                    },
                      child: Column(
                            children: [
                              ListTile(title: Text(abc.data?[i]["Subname"]),),
                              Image.network("http://api.namanraj.link/upload/"+abc.data?[i]['Subimg'])
                            ],
                      ),
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

  Future<List<dynamic>>product() async {
    final rsspcone =await http.get(Uri.parse(""+widget.id.toString()));
    if(rsspcone.statusCode==200){
      return json.decode(rsspcone.body);
    }
    else{
      throw Exception('failed to load data');
    }
  }
}
