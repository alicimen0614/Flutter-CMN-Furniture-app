import 'package:cimenfurniture/models/customers_model.dart';
import 'package:cimenfurniture/screens/add_customer_view.dart';
import 'package:cimenfurniture/screens/customers_page_model.dart';
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
    return ChangeNotifierProvider<CustomersPageModel>(
      create: (_) => CustomersPageModel(),
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amber,
          ),
          body: Center(
              child: Column(
            children: [
              StreamBuilder<List<Customers>>(
                stream: Provider.of<CustomersPageModel>(context, listen: false)
                    .getCustomerList(),
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.hasError) {
                    print(asyncSnapshot.error);
                    return const Center(
                      child: Text("Bir hata oluştu"),
                    );
                  } else {
                    print("else girdi");
                    if (!asyncSnapshot.hasData) {
                      return const CircularProgressIndicator();
                    } else {
                      print("diğer else girdi");
                      List<Customers> customerList = asyncSnapshot.data!;

                      return Flexible(
                          child: ListView.builder(
                              itemCount: customerList.length,
                              itemBuilder: ((context, index) {
                                return Dismissible(
                                  key: UniqueKey(),
                                  direction: DismissDirection.endToStart,
                                  background: Container(
                                    padding: EdgeInsets.all(20),
                                    decoration: BoxDecoration(
                                        color: Colors.redAccent,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    alignment: Alignment.centerRight,
                                    child: const Icon(Icons.delete),
                                  ),
                                  onDismissed: (direction) async =>
                                      await Provider.of<CustomersPageModel>(
                                              context,
                                              listen: false)
                                          .deleteCustomer(customerList[index]),
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(30),
                                        highlightColor: Colors.grey,
                                        splashColor: Colors.amberAccent,
                                        child: ListTile(
                                          title: Text(customerList[index].name),
                                          subtitle:
                                              Text(customerList[index].surname),
                                        ),
                                      )),
                                );
                              })));
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
      },
    );
  }
}
