import 'package:cimenfurniture/models/customers_model.dart';
import 'package:cimenfurniture/screens/add_work_view.dart';
import 'package:cimenfurniture/viewmodels/customers_page_model.dart';
import 'package:cimenfurniture/viewmodels/detailed_customer_view_model.dart';
import 'package:cimenfurniture/screens/detailed_work_view.dart';
import 'package:cimenfurniture/services/time_convert.dart';
import 'package:cimenfurniture/viewmodels/detailed_work_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/works_model.dart';

enum FormStatus { detailedCustomer, works }

class DetailedCustomerView extends StatefulWidget {
  final Customers customer;

  const DetailedCustomerView({super.key, required this.customer});

  @override
  State<DetailedCustomerView> createState() => _DetailedCustomerViewState();
}

class _DetailedCustomerViewState extends State<DetailedCustomerView> {
  FormStatus _formStatus = FormStatus.works;

  var selectedDate;
  var estimatedDate;
  TextEditingController nameCtr = TextEditingController();
  TextEditingController surnameCtr = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameCtr.dispose();
    surnameCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    nameCtr.text = widget.customer.name;
    surnameCtr.text = widget.customer.surname;

    return FutureBuilder<Widget>(
      future: detailedCustomerView(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            floatingActionButton: _formStatus == FormStatus.works
                ? FloatingActionButton(
                    foregroundColor: Colors.white,
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
                      .deleteCustomer(widget.customer)
                      .whenComplete(() =>
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.black54,
                            content: const Text('Başarıyla Silindi!'),
                            action: SnackBarAction(
                              label: 'Kapat',
                              onPressed: () {},
                            ),
                            width: width,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          )));
                  if (!mounted) return;
                  Navigator.pop(context);
                },
              ),
            ]),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(children: [
                SizedBox(
                  height: width * 0.038,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: height * 0.057,
                      width: width * 0.472,
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
                    ),
                    SizedBox(
                      height: height * 0.057,
                      width: width * 0.472,
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
                  ],
                ),
                SizedBox(
                  height: height * 0.017,
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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
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
                      prefixIcon: Icon(
                        Icons.account_circle_sharp,
                        size: width * 0.102,
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
                SizedBox(height: height * 0.0057),
                const Divider(color: Colors.black87),
                SizedBox(height: height * 0.0057),
                TextFormField(
                    controller: surnameCtr,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide:
                                const BorderSide(color: Colors.amberAccent)),
                        prefixIcon: Icon(Icons.supervised_user_circle,
                            size: width * 0.102),
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
                SizedBox(
                  height: height * 0.0510,
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
                  child: Text(
                    "Kaydet",
                    style: TextStyle(fontSize: width * 0.056),
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  Widget worksView() {
    List<Works> worksList = widget.customer.works;

    bool isAllDoneForFalse = false;

    return StreamBuilder(
      stream: context
          .read<DetailedCustomerViewModel>()
          .getNewCustomer(widget.customer.id),
      builder: (context, snapshotOfStream) => ListView.separated(
          reverse: true,
          padding: const EdgeInsets.all(10),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            int cost = worksList[index].price;
            bool isDone = worksList[index].isDone;
            print("$cost -- $isDone");

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
                    trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                      Text("${worksList[index].price} TL"),
                      Transform.scale(
                        scale: 1.2,
                        child: Checkbox(
                            shape: CircleBorder(),
                            value: worksList[index].isDone,
                            onChanged: (bool? value) async {
                              Works newWork = Works(
                                  id: worksList[index].id,
                                  price: worksList[index].price,
                                  dateOfTakingTheWork:
                                      worksList[index].dateOfTakingTheWork,
                                  estimatedDeliveryDate:
                                      worksList[index].estimatedDeliveryDate,
                                  deposit: worksList[index].deposit,
                                  address: worksList[index].address,
                                  notes: worksList[index].notes,
                                  remainingMoneyToPay:
                                      worksList[index].remainingMoneyToPay,
                                  isDone: value!,
                                  workName: worksList[index].workName);

                              await context
                                  .read<DetailedWorkViewModel>()
                                  .updateNewWork(newWork, widget.customer,
                                      worksList[index]);

                              bool isEveryElementTrue = worksList
                                  .every((element) => element.isDone == true);
                              print(worksList
                                  .every((element) => element.isDone == true));
                              if (isEveryElementTrue == true) {
                                print("isEveryElementTrue == true");
                                if (!mounted) return;
                                await context
                                    .read<CustomersPageModel>()
                                    .updateCustomer(
                                        widget.customer.id,
                                        widget.customer.name,
                                        widget.customer.surname,
                                        true,
                                        widget.customer.works);
                              } else {
                                print("isEveryElementTrue == false");
                                if (!mounted) return;
                                await context
                                    .read<CustomersPageModel>()
                                    .updateCustomer(
                                        widget.customer.id,
                                        widget.customer.name,
                                        widget.customer.surname,
                                        false,
                                        widget.customer.works);
                              }
                            }),
                      )
                    ]),
                    title: Text(worksList[index].workName),
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
