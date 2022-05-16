import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ThirdPage.dart';

class SecondPage extends StatefulWidget {
  final String number;
  final String typeValue;
  SecondPage({required this.number, required this.typeValue});

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  List<TextEditingController> _controllers = [];
  List<TextEditingController> _Datecontrollers = [];
  DateTime selectedDate = DateTime.now();
  var textValue;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var typeValue, number;
    return Form(
      key: _formKey,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.purple,
            title: Text('Second Page'),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .7,
                  child: ListView.builder(
                      itemCount: int.tryParse(widget.number),
                      itemBuilder: (ctx, index) {
                        _controllers.add(new TextEditingController());
                        _Datecontrollers.add(new TextEditingController());
                        return Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.07,
                                width: MediaQuery.of(context).size.width * .9,
                                child: Material(
                                  elevation: 2,
                                  borderRadius: BorderRadius.circular(10),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8),
                                    child: Center(
                                      child: widget.typeValue == 'Date'
                                          ? TextFormField(
                                              readOnly: true,
                                              decoration:
                                                  InputDecoration.collapsed(
                                                      hintText: 'Select Date',
                                                      hintStyle: TextStyle(
                                                          fontSize: 14)),
                                              validator: (value) =>
                                                  value!.isEmpty
                                                      ? 'Enter Number please'
                                                      : null,
                                              controller:
                                                  _Datecontrollers[index],
                                              onTap: () {
                                                _selectDate(context,
                                                    _Datecontrollers[index]);
                                                textValue =
                                                    _Datecontrollers[index]
                                                        .toString()
                                                        .substring(0, 10);
                                              })
                                          : GestureDetector(
                                              child: TextFormField(
                                                validator: (value) =>
                                                    value!.isEmpty
                                                        ? 'Enter Number please'
                                                        : null,
                                                controller: _controllers[index],
                                                keyboardType: widget
                                                            .typeValue ==
                                                        'String'
                                                    ? TextInputType.text
                                                    : widget.typeValue ==
                                                            'Number'
                                                        ? TextInputType.number
                                                        : TextInputType.text,
                                                decoration:
                                                    InputDecoration.collapsed(
                                                        hintText:
                                                            'Enter Your Field',
                                                        hintStyle: TextStyle(
                                                            fontSize: 14)),
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  textValue =
                                                      _controllers[index]
                                                          .text
                                                          .toString();
                                                });
                                              },
                                            ),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: ElevatedButton(
                      onPressed: () {
                        final FormState? form = _formKey.currentState;
                        if (form!.validate()) {
                          List values = [];

                          for (int i = 0; i < int.parse(widget.number); i++)
                            widget.typeValue == 'Date'
                                ? values.add(_Datecontrollers[i].text)
                                : values.add(_controllers[i].text);
                          values.sort();
                          if (widget.typeValue == 'Number') {
                            values.sort((a, b) {
                              //sorting in ascending order
                              return int.parse(a).compareTo(int.parse(b));
                            });
                          }
                          if (widget.typeValue == 'Date') {
                            values.sort((a, b) {
                              //sorting in ascending order
                              return DateTime.parse(a)
                                  .compareTo(DateTime.parse(b));
                            });
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ThirdPage(
                                    number: widget.number, typeValue: values)),
                          );

                        } else {

                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.purple,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: EdgeInsets.only(right: 15),
                        elevation: 15.0,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'Save',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Future _selectDate(BuildContext context, controller) async {
    var selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate)
      setState(() {
        controller.value =
            TextEditingValue(text: (picked).toString().substring(0, 10));
      });
  }
}
