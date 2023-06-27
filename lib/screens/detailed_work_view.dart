import 'package:cimenfurniture/models/customers_model.dart';
import 'package:cimenfurniture/models/works_model.dart';
import 'package:cimenfurniture/viewmodels/detailed_work_view_model.dart';
import 'package:cimenfurniture/widgets/date_picker_widget.dart';
import 'package:cimenfurniture/widgets/text_editing_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  TextEditingController remainingMoneyToPayCtr = TextEditingController();
  TextEditingController workNameCtr = TextEditingController();

  @override
  void initState() {
    super.initState();
    priceCtr.text = widget.work.price.toString();

    depositCtr.text = widget.work.deposit.toString();
    addressCtr.text = widget.work.address;
    notesCtr.text = widget.work.notes;
    remainingMoneyToPayCtr.text = widget.work.remainingMoneyToPay.toString();
    workNameCtr.text = widget.work.workName;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    workNameCtr.dispose();
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

    DateTime dateOfTakingTheWorkAsDateTime =
        TimeConvert.datetimeFromTimestamp(widget.work.dateOfTakingTheWork);

    DateTime estimatedDeliveryDateAsDateTime =
        TimeConvert.datetimeFromTimestamp(widget.work.estimatedDeliveryDate);

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
                  width: mediaQueryWidth,
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
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
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
                    } else if (value == "") {
                      remainingMoneyToPayCtr.text = depositCtr.text;
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
                        selectedDate = await datePickerWidget(
                            context,
                            'İşi aldığınız tarihi seçin',
                            dateOfTakingTheWorkAsDateTime);
                        if (selectedDate != null) {
                          dateOfTakingTheWorkCtr.text =
                              TimeConvert.dateTimeToString(selectedDate);
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
                        estimatedDate = await datePickerWidget(
                            context,
                            'Tahmini teslim tarihini seçin',
                            estimatedDeliveryDateAsDateTime);
                        if (estimatedDate != null) {
                          estimatedDeliveryDateCtr.text =
                              TimeConvert.dateTimeToString(estimatedDate);
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
                      (p0) {}, (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tahmini Teslim Tarihi Boş Olamaz';
                    } else {
                      return null;
                    }
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
                            notes: notesCtr.text,
                            remainingMoneyToPay:
                                int.parse(remainingMoneyToPayCtr.text),
                            workName: workNameCtr.text);
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
                    child: Text(
                      "Kaydet",
                      style: TextStyle(fontSize: mediaQueryWidth * 0.053),
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
