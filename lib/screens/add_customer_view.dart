import 'package:cimenfurniture/viewmodels/add_customer_view_model.dart';
<<<<<<< HEAD
=======
import 'package:cimenfurniture/services/time_convert.dart';
>>>>>>> a5d1808f01d6383a47a3cfb3aca2795f8e311165
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCustomerView extends StatefulWidget {
  const AddCustomerView({super.key});

  @override
  State<AddCustomerView> createState() => _AddCustomerViewState();
}

class _AddCustomerViewState extends State<AddCustomerView> {
  var selectedDate;
  var estimatedDate;
  TextEditingController nameCtr = TextEditingController();
  TextEditingController surnameCtr = TextEditingController();
  TextEditingController priceCtr = TextEditingController();
  TextEditingController dateOfTakingTheWorkCtr = TextEditingController();
  TextEditingController estimatedDeliveryDateCtr = TextEditingController();
  TextEditingController depositCtr = TextEditingController();
  TextEditingController addressCtr = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameCtr.dispose();
    surnameCtr.dispose();
    priceCtr.dispose();
    dateOfTakingTheWorkCtr.dispose();
    estimatedDeliveryDateCtr.dispose();
    depositCtr.dispose();
    addressCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    double mediaQueryHeight = MediaQuery.of(context).size.height;

=======
>>>>>>> a5d1808f01d6383a47a3cfb3aca2795f8e311165
    return ChangeNotifierProvider<AddCustomerViewModel>(
      create: (context) => AddCustomerViewModel(),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Yeni Müşteri Ekle"),
        ),
        body: Form(
            key: _formKey,
            child: ListView(
              physics: const BouncingScrollPhysics(),
<<<<<<< HEAD
              padding: EdgeInsets.all(mediaQueryWidth * 0.036),
=======
              padding: const EdgeInsets.all(15),
>>>>>>> a5d1808f01d6383a47a3cfb3aca2795f8e311165
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
<<<<<<< HEAD
                          prefixIcon: Icon(
                            Icons.account_circle_sharp,
                            size: mediaQueryWidth * 0.1,
=======
                          prefixIcon: const Icon(
                            Icons.account_circle_sharp,
                            size: 40,
>>>>>>> a5d1808f01d6383a47a3cfb3aca2795f8e311165
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
<<<<<<< HEAD
                    SizedBox(height: mediaQueryHeight * 0.007),
                    const Divider(color: Colors.black87),
                    SizedBox(height: mediaQueryHeight * 0.007),
=======
                    const SizedBox(height: 5),
                    const Divider(color: Colors.black87),
                    const SizedBox(height: 5),
>>>>>>> a5d1808f01d6383a47a3cfb3aca2795f8e311165
                    TextFormField(
                        controller: surnameCtr,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                borderSide: const BorderSide(
                                    color: Colors.amberAccent)),
<<<<<<< HEAD
                            prefixIcon: Icon(Icons.supervised_user_circle,
                                size: mediaQueryWidth * 0.1),
=======
                            prefixIcon: const Icon(Icons.supervised_user_circle,
                                size: 40),
>>>>>>> a5d1808f01d6383a47a3cfb3aca2795f8e311165
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
<<<<<<< HEAD
                    SizedBox(height: mediaQueryHeight * 0.029),
=======
                    const SizedBox(height: 20),
>>>>>>> a5d1808f01d6383a47a3cfb3aca2795f8e311165
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AddCustomerViewModel>().addNewCustomer(
                                nameCtr.text,
                                surnameCtr.text,
                              );

                          Navigator.pop(context);
                        }
                      },
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ))),
<<<<<<< HEAD
                      child: Text(
                        "Kaydet",
                        style: TextStyle(fontSize: mediaQueryWidth * 0.053),
=======
                      child: const Text(
                        "Kaydet",
                        style: TextStyle(fontSize: 22),
>>>>>>> a5d1808f01d6383a47a3cfb3aca2795f8e311165
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
