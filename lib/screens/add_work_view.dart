import 'package:cimenfurniture/models/customers_model.dart';
import 'package:cimenfurniture/services/time_convert.dart';
import 'package:cimenfurniture/widgets/date_picker_widget.dart';
import 'package:cimenfurniture/widgets/text_editing_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  TextEditingController remainingMoneyToPayCtr = TextEditingController();
  TextEditingController workNameCtr = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    priceCtr.dispose();
    dateOfTakingTheWorkCtr.dispose();
    estimatedDeliveryDateCtr.dispose();
    depositCtr.dispose();
    addressCtr.dispose();
    workNameCtr.dispose();
    remainingMoneyToPayCtr.dispose();
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
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.all(mediaQueryWidth * 0.036),
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    customizeTextFormField(
                        ([]),
                        mediaQueryWidth,
                        workNameCtr,
                        Icons.work,
                        "İş Adı",
                        1,
                        true,
                        () {},
                        true,
                        (p0) {}, (value) {
                      if (value == null || value.isEmpty) {
                        return 'İş Adı Boş Olamaz';
                      } else {
                        return null;
                      }
                    }, true),
                    SizedBox(height: mediaQueryHeight * 0.003),
                    const Divider(color: Colors.black87),
                    SizedBox(height: mediaQueryHeight * 0.003),
                    customizeTextFormField(
                        ([]),
                        mediaQueryWidth,
                        addressCtr,
                        Icons.home_sharp,
                        "Adres",
                        1,
                        true,
                        () {},
                        true,
                        (p0) {}, (value) {
                      if (value == null || value.isEmpty) {
                        return 'Adres Boş Olamaz';
                      } else {
                        return null;
                      }
                    }, true),
                    SizedBox(height: mediaQueryHeight * 0.003),
                    const Divider(color: Colors.black87),
                    SizedBox(height: mediaQueryHeight * 0.003),
                    customizeTextFormField(
                        ([FilteringTextInputFormatter.digitsOnly]),
                        mediaQueryWidth,
                        priceCtr,
                        Icons.monetization_on,
                        "Fiyat",
                        1,
                        true,
                        () {},
                        true, (value) {
                      String a = priceCtr.text;
                      String b = depositCtr.text;
                      print("$a--$b");
                      if (priceCtr.text != "" && depositCtr.text != "") {
                        print("ilk if girdi");
                        remainingMoneyToPayCtr.text =
                            (int.parse(value) - int.parse(depositCtr.text))
                                .toString();
                      } else if (depositCtr.text == "") {
                        print("2. if girdi");
                        remainingMoneyToPayCtr.text = value;
                      }
                    }, (value) {
                      if (value == null || value.isEmpty) {
                        return 'Fiyat Boş Olamaz';
                      } else {
                        return null;
                      }
                    }, true),
                    SizedBox(height: mediaQueryHeight * 0.003),
                    const Divider(color: Colors.black87),
                    SizedBox(height: mediaQueryHeight * 0.003),
                    customizeTextFormField(
                        ([]),
                        mediaQueryWidth,
                        dateOfTakingTheWorkCtr,
                        Icons.date_range_sharp,
                        "İşi Alış Tarihi",
                        1,
                        false,
                        () async {
                          FocusScope.of(context).requestFocus(
                              FocusNode()); //dismiss the keyboard when you click to the textformfield
                          selectedDate = await datePickerWidget(context,
                              'İşi aldığınız tarihi seçin', DateTime.now());
                          if (selectedDate != null) {
                            dateOfTakingTheWorkCtr.text =
                                TimeConvert.dateTimeToString(selectedDate);
                            selectedDateAsTimestamp =
                                TimeConvert.datetimeToTimestamp(selectedDate);
                          }
                        },
                        false,
                        (p0) {},
                        (value) {
                          if (value == null || value.isEmpty) {
                            return 'İşi Alış Tarihi Boş Olamaz';
                          } else {
                            return null;
                          }
                        },
                        true),
                    SizedBox(height: mediaQueryHeight * 0.003),
                    const Divider(color: Colors.black87),
                    SizedBox(height: mediaQueryHeight * 0.003),
                    customizeTextFormField(
                        ([]),
                        mediaQueryWidth,
                        estimatedDeliveryDateCtr,
                        Icons.access_time_filled_sharp,
                        "Tahmini Teslim Tarihi",
                        1,
                        false,
                        (() async {
                          FocusScope.of(context).requestFocus(
                              FocusNode()); //dismiss the keyboard when you click to the textformfield
                          estimatedDate = await datePickerWidget(context,
                              'Tahmini teslim tarihini seçin', DateTime.now());
                          if (estimatedDate != null) {
                            estimatedDeliveryDateCtr.text =
                                TimeConvert.dateTimeToString(estimatedDate);
                            estimatedDateAsTimestamp =
                                TimeConvert.datetimeToTimestamp(estimatedDate);
                          }
                        }),
                        false,
                        (p0) {},
                        (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tahmini Teslim Tarihi Boş Olamaz';
                          } else {
                            return null;
                          }
                        },
                        true),
                    SizedBox(height: mediaQueryHeight * 0.003),
                    const Divider(color: Colors.black87),
                    SizedBox(height: mediaQueryHeight * 0.003),
                    customizeTextFormField(
                        ([FilteringTextInputFormatter.digitsOnly]),
                        mediaQueryWidth,
                        depositCtr,
                        Icons.price_check_sharp,
                        "Kapora",
                        1,
                        true,
                        () {},
                        true, (value) {
                      String a = priceCtr.text;
                      String b = depositCtr.text;
                      print("$a--$b");
                      if (priceCtr.text != "" && depositCtr.text != "") {
                        print("ilk if girdi");
                        remainingMoneyToPayCtr.text =
                            (int.parse(priceCtr.text) - int.parse(value))
                                .toString();
                      } else if (depositCtr.text == "") {
                        print("2 if girdi");
                        remainingMoneyToPayCtr.text = priceCtr.text;
                      }
                    }, (p0) {
                      return null;
                    }, true),
                    SizedBox(height: mediaQueryHeight * 0.003),
                    const Divider(color: Colors.black87),
                    SizedBox(height: mediaQueryHeight * 0.003),
                    customizeTextFormField(
                        ([]),
                        mediaQueryWidth,
                        remainingMoneyToPayCtr,
                        Icons.attach_money,
                        "Kalan Ödenecek Para",
                        1,
                        true,
                        () {},
                        true,
                        (p0) {}, (p0) {
                      return null;
                    }, false),
                    SizedBox(height: mediaQueryHeight * 0.003),
                    const Divider(color: Colors.black87),
                    SizedBox(height: mediaQueryHeight * 0.003),
                    customizeTextFormField(
                        ([]),
                        mediaQueryWidth,
                        notesCtr,
                        Icons.speaker_notes,
                        "Notlar",
                        4,
                        true,
                        () {},
                        true,
                        (p0) {}, (p0) {
                      return null;
                    }, true),
                    SizedBox(height: mediaQueryHeight * 0.006),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Works newWork = Works(
                              id: TimeConvert.dateTimeToString(DateTime.now()),
                              price: int.parse(priceCtr.text),
                              dateOfTakingTheWork: selectedDateAsTimestamp,
                              estimatedDeliveryDate: estimatedDateAsTimestamp,
                              deposit: depositCtr.text == ""
                                  ? 0
                                  : int.parse(depositCtr.text),
                              address: addressCtr.text,
                              notes: notesCtr.text,
                              remainingMoneyToPay: depositCtr.text == ""
                                  ? int.parse(priceCtr.text)
                                  : int.parse(priceCtr.text) -
                                      int.parse(depositCtr.text),
                              workName: workNameCtr.text);

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
