import 'dart:convert';
import 'package:demo_1_e/Products.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'Categories.dart';

class dashboard extends StatefulWidget {
  const dashboard({Key? key}) : super(key: key);

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  List<CatData> catlist = [];
  List<Data> productlist = [];

  bool status = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getCategories();
  }

  getCategories() async {
    var url = Uri.parse('https://api.storerestapi.com/categories');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    Map<String, dynamic> map = jsonDecode(response.body);

    Categories categories = Categories.fromJson(map);

    catlist = categories.data!;

    getProducts();
  }

  getProducts() async {
    var url = Uri.parse('https://api.storerestapi.com/products');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    Map<String, dynamic> map = jsonDecode(response.body);

    Products products = Products.fromJson(map);

    productlist = products.data!;

    status = true;

    setState(() {});
  }

  List<Widget> tabWidget() {
    List<Widget> l = [];

    for (int i = 0; i < catlist.length; i++) {
      l.add(Tab(
        child: Text("${catlist[i].name}"),
      ));
    }

    return l;
  }

  List<Widget> productTabView() {
    List<Widget> l = [];

    for (int i = 0; i < catlist.length; i++) {
      List<Data> catproductlist = [];

      for (int j = 0; j < productlist.length; j++) {
        if (productlist[j].category!.sId == catlist[i].sId) {
          catproductlist.add(productlist[j]);
        }
      }

      l.add(ListView.builder(
        itemCount: catproductlist.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text("${catproductlist[index].category!.name}"),
              subtitle: Text(
                "${catproductlist[index].slug}",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Text("${catproductlist[index].price}"),
            ),
            elevation: 8,
            color: Color(0xff16b2b8),
            margin: EdgeInsets.all(8),
          );
        },
      ));
    }

    return l;
  }

  @override
  Widget build(BuildContext context) {
    return status
        ? DefaultTabController(
            length: catlist.length,
            child: Scaffold(
              backgroundColor: Color(0xffc9f7ff),
              appBar: AppBar(
                backgroundColor: Color(0xff4973aa),
                title: Text(
                  "MANYA TECHNOSYS",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                bottom: TabBar(
                    indicatorColor: Colors.orange,
                    // labelColor: Colors.black45,
                    indicatorWeight: 3,
                    onTap: (value) {},
                    isScrollable: true,
                    tabs: tabWidget()),
              ),
              body: TabBarView(
                children: productTabView(),
              ),
            ))
        : Scaffold(
            body: Container(child: Center(child: CupertinoActivityIndicator(radius: 20,)),color: Color(0xffc9f7ff)),
          );
  }
}
