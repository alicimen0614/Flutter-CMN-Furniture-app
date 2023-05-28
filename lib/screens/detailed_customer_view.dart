import 'package:cimenfurniture/models/customers_model.dart';
import 'package:cimenfurniture/screens/add_work_view.dart';
import 'package:cimenfurniture/viewmodels/customers_page_model.dart';
import 'package:cimenfurniture/viewmodels/detailed_customer_view_model.dart';
import 'package:cimenfurniture/screens/detailed_work_view.dart';
import 'package:cimenfurniture/services/time_convert.dart';
<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/works_model.dart';
=======
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cimenfurniture/services/database.dart';

import '../models/works_model.dart';
import '../services/auth.dart';
>>>>>>> a5d1808f01d6383a47a3cfb3aca2795f8e311165

enum FormStatus { detailedCustomer, works }

class DetailedCustomerView extends StatefulWidget {
  final Customers customer;

  const DetailedCustomerView({super.key, required this.customer});

  @override
  State<DetailedCustomerView> createState() => _DetailedCustomerViewState();
}

class _DetailedCustomerViewState extends State<DetailedCustomerView> {
  FormStatus _formStatus = FormStatus.detailedCustomer;

  var selectedDate;
  var estimatedDate;
  TextEditingController nameCtr = TextEditingController();
  TextEditingController surnameCtr = TextEditingController();
<<<<<<< HEAD
=======
  TextEditingController priceCtr = TextEditingController();
  TextEditingController dateOfTakingTheWorkCtr = TextEditingController();
  TextEditingController estimatedDeliveryDateCtr = TextEditingController();
  TextEditingController depositCtr = TextEditingController();
  TextEditingController addressCtr = TextEditingController();
>>>>>>> a5d1808f01d6383a47a3cfb3aca2795f8e311165

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameCtr.dispose();
    surnameCtr.dispose();
<<<<<<< HEAD
=======
    priceCtr.dispose();
    dateOfTakingTheWorkCtr.dispose();
    estimatedDeliveryDateCtr.dispose();
    depositCtr.dispose();
    addressCtr.dispose();
>>>>>>> a5d1808f01d6383a47a3cfb3aca2795f8e311165
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    nameCtr.text = widget.customer.name;
    surnameCtr.text = widget.customer.surname;

    return FutureBuilder<Widget>(
      future: detailedCustomerView(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            floatingActionButton: _formStatus == FormStatus.works
                ? FloatingActionButton(
                    //THIS IS OCCURRING SLOW??
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AddWorkView(customer: widget.customer),
                          ));
                    },
                    backgroundColor: Colors.amber,

                    foregroundColor: Colors.white,
                    child: const Icon(Icons.add),
                  )
                : null,
            backgroundColor: Colors.grey.shade100,
            appBar: AppBar(actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.delete),
                tooltip: 'Müşteriyi sil',
                onPressed: () async {
                  await Provider.of<CustomersPageModel>(context, listen: false)
                      .deleteCustomer(widget.customer);
                  if (!mounted) return;
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.black54,
                    content: const Text('Başarıyla Silindi!'),
                    action: SnackBarAction(
                      label: 'Kapat',
                      onPressed: () {},
                    ),
                    width: 350.0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                    ),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ));
                },
              ),
            ]),
            body: SingleChildScrollView(
<<<<<<< HEAD
              physics: const BouncingScrollPhysics(),
=======
              physics: BouncingScrollPhysics(),
>>>>>>> a5d1808f01d6383a47a3cfb3aca2795f8e311165
              child: Column(children: [
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 185,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.person),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              _formStatus == FormStatus.detailedCustomer
                                  ? const Color(0xFFFF3F00).withAlpha(200)
                                  : const Color(0xFFFF3F00),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                        ),
                        onPressed: () {
                          setState(() {
                            _formStatus = FormStatus.detailedCustomer;
                          });
                        },
                        label: const Text('Müşteri Detayı'),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 185,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.work_history),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _formStatus == FormStatus.works
                              ? const Color(0xFFFF3F00).withAlpha(200)
                              : const Color(0xFFFF3F00),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25)),
                        ),
                        onPressed: () {
                          setState(() {
                            _formStatus = FormStatus.works;
                          });
                        },
                        label: const Text('İşler'),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                _formStatus == FormStatus.detailedCustomer
                    ? snapshot.data!
                    : worksView()
              ]),
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Future<Widget> detailedCustomerView(BuildContext context) async {
    return Form(
        key: _formKey,
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.all(15),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: nameCtr,
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          borderSide:
                              const BorderSide(color: Colors.amberAccent)),
                      prefixIcon: const Icon(
                        Icons.account_circle_sharp,
                        size: 40,
                      ),
                      hintText: "Müşteri Adı",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0))),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Müşteri Adı Boş Olamaz';
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 5),
                const Divider(color: Colors.black87),
                const SizedBox(height: 5),
                TextFormField(
                    controller: surnameCtr,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide:
                                const BorderSide(color: Colors.amberAccent)),
                        prefixIcon:
                            const Icon(Icons.supervised_user_circle, size: 40),
                        hintText: "Müşteri Soyadı",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Müşteri Soyadı Boş Olamaz';
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context
                          .read<DetailedCustomerViewModel>()
                          .updateNewCustomer(
                              nameCtr.text, surnameCtr.text, widget.customer);

                      Navigator.pop(context);
                    }
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ))),
                  child: const Text(
                    "Kaydet",
                    style: TextStyle(fontSize: 22),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  Widget worksView() {
    List<Works> worksList = widget.customer.works;

    return StreamBuilder(
      stream: context
          .read<DetailedCustomerViewModel>()
          .getNewCustomer(widget.customer.id),
      builder: (context, snapshotOfStream) => ListView.separated(
          reverse: true,
<<<<<<< HEAD
          padding: const EdgeInsets.all(10),
=======
          padding: EdgeInsets.all(10),
>>>>>>> a5d1808f01d6383a47a3cfb3aca2795f8e311165
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var delvDateAsDateTime = TimeConvert.datetimeFromTimestamp(
                worksList[index].estimatedDeliveryDate);
            var delvDateAsString =
                TimeConvert.dateTimeToString(delvDateAsDateTime);
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: InkWell(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailedWorkView(
                                work: worksList[index],
                                customer: widget.customer,
                              ))),
                  borderRadius: BorderRadius.circular(30),
                  highlightColor: Colors.grey,
                  splashColor: Colors.amberAccent,
                  child: ListTile(
                    trailing: Text("${worksList[index].price} TL"),
                    title: Text("${worksList[index].id}"),
                    subtitle: Text("Tahmini Teslim Tarihi : $delvDateAsString"),
                  )),
            );
          },
          separatorBuilder: (context, index) =>
              const Divider(color: Colors.black87, endIndent: 15, indent: 15),
          itemCount: worksList.length),
    );
  }
}
