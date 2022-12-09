import 'dart:async';

import 'package:cimenfurniture/models/customers_model.dart';
import 'package:cimenfurniture/screens/add_customer_view.dart';
import 'package:cimenfurniture/viewmodels/customers_page_model.dart';
import 'package:cimenfurniture/screens/detailed_customer_view.dart';
import 'package:cimenfurniture/services/time_convert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomersPage extends StatefulWidget {
  const CustomersPage({Key? key}) : super(key: key);

  @override
  State<CustomersPage> createState() => _CustomersPageState();
}

class _CustomersPageState extends State<CustomersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("Müşteriler"),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder<List<Customers>>(
            stream: context.read<CustomersPageModel>().getCustomerList(),
            builder: (context, asyncSnapshot) {
              if (asyncSnapshot.hasError) {
                return Padding(
                  padding: EdgeInsets.all(50),
                  child: Center(
                    child: Text(asyncSnapshot.error.toString()),
                  ),
                );
              } else {
                print("else girdi");
                print(asyncSnapshot.connectionState);
                if (!asyncSnapshot.hasData) {
                  return const CircularProgressIndicator();
                } else {
                  print(asyncSnapshot.connectionState);
                  List<Customers> customerList = asyncSnapshot.data!;

                  return BuildListView(customerList: customerList);
                }
              }
            },
          )
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddCustomerView(),
              ));
        },
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class BuildListView extends StatefulWidget {
  const BuildListView({
    Key? key,
    required this.customerList,
  }) : super(key: key);

  final List<Customers> customerList;

  @override
  State<BuildListView> createState() => _BuildListViewState();
}

class _BuildListViewState extends State<BuildListView> {
  bool isFiltering = false;
  late List<Customers> filteredList;

  @override
  Widget build(BuildContext context) {
    print("build listview çalıştı");
    var fullList = widget.customerList;
    return Flexible(
      child: Column(children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Arama: Müşteri Adı',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0))),
            onChanged: (query) {
              if (query.isNotEmpty) {
                isFiltering = true;
                setState(() {
                  filteredList = fullList
                      .where((customer) => customer.name
                          .toLowerCase()
                          .contains(query.toLowerCase()))
                      .toList();
                });
              } else {
                setState(() {
                  isFiltering = false;
                });
              }
            },
          ),
        ),
        Flexible(
            child: ListView.separated(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(10),
                separatorBuilder: (context, index) => const Divider(
                      color: Colors.black87,
                      endIndent: 15,
                      indent: 15,
                    ),
                itemCount: isFiltering ? filteredList.length : fullList.length,
                itemBuilder: ((context, index) {
                  var list = isFiltering ? filteredList : fullList;

                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: InkWell(
                        borderRadius: BorderRadius.circular(30),
                        highlightColor: Colors.grey,
                        splashColor: Colors.amberAccent,
                        child: ListTile(
                          title: Text(
                              "${list[index].name} ${list[index].surname}"),
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailedCustomerView(
                                    customer: list[index])),
                          ),
                        )),
                  );
                }))),
      ]),
    );
  }
}
