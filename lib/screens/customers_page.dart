import 'package:cimenfurniture/models/customers_model.dart';
import 'package:cimenfurniture/screens/add_customer_view.dart';
import 'package:cimenfurniture/viewmodels/customers_page_model.dart';
import 'package:cimenfurniture/screens/detailed_customer_view.dart';
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
        title: const Text("Müşteriler"),
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
                  padding: const EdgeInsets.all(50),
                  child: Center(
                    child: Text(asyncSnapshot.error.toString()),
                  ),
                );
              } else {
                print("else girdi");

                if (!asyncSnapshot.hasData) {
                  return const CircularProgressIndicator();
                } else {
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
                builder: (context) => const AddCustomerView(),
              ));
        },
        backgroundColor: Colors.amber,
        child: const Icon(Icons.add),
        foregroundColor: Colors.white,
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
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    var fullList = widget.customerList;
    return Flexible(
      child: Column(children: [
        Padding(
          padding: EdgeInsets.all(mediaQueryWidth * 0.019),
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
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
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(mediaQueryWidth * 0.024),
          itemCount: isFiltering ? filteredList.length : fullList.length,
          itemBuilder: ((context, index) {
            var list = isFiltering ? filteredList : fullList;

            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: InkWell(
                  onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailedCustomerView(customer: list[index])),
                      ),
                  borderRadius: BorderRadius.circular(30),
                  highlightColor: Colors.grey,
                  splashColor: Colors.amberAccent,
                  child: ListTile(
                    title: Text("${list[index].name} ${list[index].surname}"),
                  )),
            );
          }),
          separatorBuilder: (context, index) => Divider(
            color: Colors.black87,
            endIndent: mediaQueryWidth * 0.036,
            indent: mediaQueryWidth * 0.036,
          ),
        )),
      ]),
    );
  }
}
