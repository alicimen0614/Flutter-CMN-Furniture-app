import 'package:cimenfurniture/models/customers_model.dart';
import 'package:cimenfurniture/models/works_model.dart';
import 'package:cimenfurniture/viewmodels/detailed_work_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../services/time_convert.dart';

class DetailedWorkView extends StatefulWidget {
  final Works work;
  final Customers customer;
  const DetailedWorkView(
      {super.key, required this.work, required this.customer});

  @override
  State<DetailedWorkView> createState() => _DetailedWorkViewState();
}

class _DetailedWorkViewState extends State<DetailedWorkView> {
  var selectedDate;
  var estimatedDate;
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
    notesCtr.text = widget.work.notes;
    DateTime dateOfTakingTheWorkAsDateTime =
        TimeConvert.datetimeFromTimestamp(widget.work.dateOfTakingTheWork);

    DateTime estimatedDeliveryDateAsDateTime =
        TimeConvert.datetimeFromTimestamp(widget.work.estimatedDeliveryDate);

    priceCtr.text = widget.work.price.toString();

    depositCtr.text = widget.work.deposit.toString();
    addressCtr.text = widget.work.address;
    if (estimatedDeliveryDateCtr.text.isEmpty) {
      estimatedDeliveryDateCtr.text =
          TimeConvert.dateTimeToString(estimatedDeliveryDateAsDateTime);
    }
    if (dateOfTakingTheWorkCtr.text.isEmpty) {
      dateOfTakingTheWorkCtr.text =
          TimeConvert.dateTimeToString(dateOfTakingTheWorkAsDateTime);
    }

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text("İş Detayı"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.delete),
              tooltip: 'Müşteriyi sil',
              onPressed: () async {
                context.read<DetailedWorkViewModel>().deleteWork(
                    customer: widget.customer, unupdatedWorks: widget.work);
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
      body: Form(
          key: _formKey,
          child: ListView(
            physics: BouncingScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(15),
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
                              borderSide:
                                  const BorderSide(color: Colors.amberAccent)),
                          prefixIcon: const Icon(Icons.home_sharp, size: 40),
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
                  const SizedBox(height: 5),
                  const Divider(color: Colors.black87),
                  const SizedBox(height: 5),
                  TextFormField(
                      controller: priceCtr,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide:
                                  const BorderSide(color: Colors.amberAccent)),
                          prefixIcon:
                              const Icon(Icons.monetization_on, size: 40),
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
                  const SizedBox(height: 3),
                  const Divider(color: Colors.black87),
                  const SizedBox(height: 3),
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
                            initialDate: dateOfTakingTheWorkAsDateTime,
                            firstDate: DateTime(2022),
                            lastDate: DateTime(2024));
                        if (selectedDate != null) {
                          dateOfTakingTheWorkCtr.text =
                              TimeConvert.dateTimeToString(selectedDate);
                        }
                      },
                      controller: dateOfTakingTheWorkCtr,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide:
                                  const BorderSide(color: Colors.amberAccent)),
                          prefixIcon:
                              const Icon(Icons.date_range_sharp, size: 40),
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
                  const SizedBox(height: 3),
                  const Divider(color: Colors.black87),
                  const SizedBox(height: 3),
                  TextFormField(
                      enableInteractiveSelection:
                          false, //dismiss the selection tool when you click to the textformfield
                      showCursor: false,
                      onTap: () async {
                        FocusScope.of(context).requestFocus(
                            FocusNode()); //dismiss the keyboard when you click to the textformfield
                        estimatedDate = await showDatePicker(
                            context: context,
                            initialDate: estimatedDeliveryDateAsDateTime,
                            firstDate: DateTime(2022),
                            lastDate: DateTime(2024));
                        if (estimatedDate != null) {
                          estimatedDeliveryDateCtr.text =
                              TimeConvert.dateTimeToString(estimatedDate);
                        }
                      },
                      controller: estimatedDeliveryDateCtr,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide:
                                  const BorderSide(color: Colors.amberAccent)),
                          prefixIcon: const Icon(Icons.access_time_filled_sharp,
                              size: 40),
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
                  const SizedBox(height: 3),
                  const Divider(color: Colors.black87),
                  const SizedBox(height: 3),
                  TextFormField(
                      controller: depositCtr,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide:
                                  const BorderSide(color: Colors.amberAccent)),
                          prefixIcon:
                              const Icon(Icons.price_check_sharp, size: 40),
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
                  const SizedBox(height: 5),
                  const Divider(color: Colors.black87),
                  const SizedBox(height: 5),
                  TextFormField(
                      maxLines: 4,
                      controller: notesCtr,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(10),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide:
                                  const BorderSide(color: Colors.amberAccent)),
                          prefixIcon: const Icon(Icons.speaker_notes, size: 40),
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
                  SizedBox(
                    height: 3,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        DateTime tempDateforTaking = DateFormat("dd-MM-yyyy")
                            .parse(dateOfTakingTheWorkCtr.text);
                        print(tempDateforTaking);
                        DateTime tempDateforDelivery = DateFormat("dd-MM-yyyy")
                            .parse(estimatedDeliveryDateCtr.text);
                        Works updatedWorks = Works(
                            id: widget.work.id,
                            price: int.parse(priceCtr.text),
                            dateOfTakingTheWork:
                                TimeConvert.datetimeToTimestamp(
                                    tempDateforTaking),
                            estimatedDeliveryDate:
                                TimeConvert.datetimeToTimestamp(
                                    tempDateforDelivery),
                            deposit: int.parse(depositCtr.text),
                            address: addressCtr.text,
                            notes: notesCtr.text);
                        print(updatedWorks.dateOfTakingTheWork);

                        context.read<DetailedWorkViewModel>().updateNewWork(
                            updatedWorks, widget.customer, widget.work);

                        Navigator.pop(context);
                      }
                    },
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
          )),
    );
  }
}
