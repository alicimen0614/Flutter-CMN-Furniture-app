import 'package:cimenfurniture/models/customers_model.dart';
import 'package:cimenfurniture/services/time_convert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/works_model.dart';
import '../viewmodels/add_work_view_model.dart';

class AddWorkView extends StatefulWidget {
  final Customers customer;
  const AddWorkView({super.key, required this.customer});

  @override
  State<AddWorkView> createState() => _AddWorkViewState();
}

class _AddWorkViewState extends State<AddWorkView> {
  var selectedDate;
  var estimatedDate;
  late Timestamp selectedDateAsTimestamp;
  late Timestamp estimatedDateAsTimestamp;
  TextEditingController priceCtr = TextEditingController();
  TextEditingController dateOfTakingTheWorkCtr = TextEditingController();
  TextEditingController estimatedDeliveryDateCtr = TextEditingController();
  TextEditingController depositCtr = TextEditingController();
  TextEditingController addressCtr = TextEditingController();
  TextEditingController notesCtr = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    priceCtr.dispose();
    dateOfTakingTheWorkCtr.dispose();
    estimatedDeliveryDateCtr.dispose();
    depositCtr.dispose();
    addressCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double mediaQueryWidth = MediaQuery.of(context).size.width;
    double mediaQueryHeight = MediaQuery.of(context).size.height;
    List<Works> workList = widget.customer.works;
    return ChangeNotifierProvider<AddWorkViewModel>(
      create: (context) => AddWorkViewModel(),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Yeni İş Ekle"),
        ),
        body: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(mediaQueryWidth * 0.036),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                        controller: addressCtr,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                borderSide: const BorderSide(
                                    color: Colors.amberAccent)),
                            prefixIcon: Icon(Icons.home_sharp,
                                size: mediaQueryWidth * 0.1),
                            hintText: "Adres",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Adres Boş Olamaz';
                          } else {
                            return null;
                          }
                        }),
                    SizedBox(height: mediaQueryHeight * 0.003),
                    const Divider(color: Colors.black87),
                    SizedBox(height: mediaQueryHeight * 0.003),
                    TextFormField(
                        controller: priceCtr,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                borderSide: const BorderSide(
                                    color: Colors.amberAccent)),
                            prefixIcon: Icon(Icons.monetization_on,
                                size: mediaQueryWidth * 0.1),
                            hintText: "Fiyat",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Fiyat Boş Olamaz';
                          } else {
                            return null;
                          }
                        }),
                    SizedBox(height: mediaQueryHeight * 0.003),
                    const Divider(color: Colors.black87),
                    SizedBox(height: mediaQueryHeight * 0.003),
                    TextFormField(
                        enableInteractiveSelection:
                            false, //dismiss the selection tool when you click to the textformfield
                        cursorWidth: 0,
                        showCursor: false,
                        onTap: () async {
                          FocusScope.of(context).requestFocus(
                              FocusNode()); //dismiss the keyboard when you click to the textformfield
                          selectedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2022),
                              lastDate: DateTime(2024));

                          dateOfTakingTheWorkCtr.text =
                              TimeConvert.dateTimeToString(selectedDate);

                          selectedDateAsTimestamp =
                              TimeConvert.datetimeToTimestamp(selectedDate);
                        },
                        controller: dateOfTakingTheWorkCtr,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                borderSide: const BorderSide(
                                    color: Colors.amberAccent)),
                            prefixIcon: Icon(Icons.date_range_sharp,
                                size: mediaQueryWidth * 0.1),
                            hintText: "İşi Alış Tarihi",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'İşi Alış Tarihi Boş Olamaz';
                          } else {
                            return null;
                          }
                        }),
                    SizedBox(height: mediaQueryHeight * 0.003),
                    const Divider(color: Colors.black87),
                    SizedBox(height: mediaQueryHeight * 0.003),
                    TextFormField(
                        enableInteractiveSelection:
                            false, //dismiss the selection tool when you click to the textformfield
                        showCursor: false,
                        onTap: () async {
                          FocusScope.of(context).requestFocus(
                              FocusNode()); //dismiss the keyboard when you click to the textformfield
                          estimatedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2022),
                              lastDate: DateTime(2024));

                          estimatedDeliveryDateCtr.text =
                              TimeConvert.dateTimeToString(estimatedDate);
                          estimatedDateAsTimestamp =
                              TimeConvert.datetimeToTimestamp(estimatedDate);
                        },
                        controller: estimatedDeliveryDateCtr,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                borderSide: const BorderSide(
                                    color: Colors.amberAccent)),
                            prefixIcon: Icon(Icons.access_time_filled_sharp,
                                size: mediaQueryWidth * 0.1),
                            hintText: "Tahmini Teslim Tarihi",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tahmini Teslim Tarihi Boş Olamaz';
                          } else {
                            return null;
                          }
                        }),
                    SizedBox(height: mediaQueryHeight * 0.003),
                    const Divider(color: Colors.black87),
                    SizedBox(height: mediaQueryHeight * 0.003),
                    TextFormField(
                        controller: depositCtr,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0),
                                borderSide: const BorderSide(
                                    color: Colors.amberAccent)),
                            prefixIcon: Icon(Icons.price_check_sharp,
                                size: mediaQueryWidth * 0.1),
                            hintText: "Kapora",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50.0))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Kapora Boş Olamaz';
                          } else {
                            return null;
                          }
                        }),
                    SizedBox(height: mediaQueryHeight * 0.003),
                    const Divider(color: Colors.black87),
                    SizedBox(height: mediaQueryHeight * 0.003),
                    TextFormField(
                        maxLines: 4,
                        controller: notesCtr,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.all(mediaQueryWidth * 0.024),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                    color: Colors.amberAccent)),
                            prefixIcon: Icon(Icons.speaker_notes,
                                size: mediaQueryWidth * 0.1),
                            hintText: "Notlar",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Adres Boş Olamaz';
                          } else {
                            return null;
                          }
                        }),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Works newWork = Works(
                              id: TimeConvert.dateTimeToString(DateTime.now()),
                              price: int.parse(priceCtr.text),
                              dateOfTakingTheWork: selectedDateAsTimestamp,
                              estimatedDeliveryDate: estimatedDateAsTimestamp,
                              deposit: int.parse(depositCtr.text),
                              address: addressCtr.text,
                              notes: notesCtr.text);

                          workList.add(newWork);

                          context.read<AddWorkViewModel>().addNewWork(
                              customer: widget.customer, workList: workList);

                          Navigator.pop(context);
                        }
                      },
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40.0),
                      ))),
                      child: Text(
                        "Kaydet",
                        style: TextStyle(fontSize: mediaQueryWidth * 0.053),
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
