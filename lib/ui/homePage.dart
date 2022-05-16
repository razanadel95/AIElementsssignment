import 'package:aielements/ui/SecondPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var dropdownValue ,number,typeValue;
  final TextEditingController numberOfFields= TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text('Home Page'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .15,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Enter the Number of Field You Want and \nSelect the Data Type ',
                  style: TextStyle(fontSize: 17),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                SizedBox(
                     height: MediaQuery.of(context).size.height*0.07,
                     width: MediaQuery.of(context).size.width * .4,
                     child: Material(
                       elevation: 2,
                       borderRadius: BorderRadius.circular(10),
                       child: Padding(
                         padding: const EdgeInsets.only(left: 8.0,right: 8),
                         child: Center(
                           child: TextFormField(
                             validator: (value) =>
                             value!.isEmpty ? 'Enter Number please' : null,
                             controller: numberOfFields,
                             keyboardType: TextInputType.number,
                             decoration: InputDecoration.collapsed(
                             hintText: 'Number of Fields',
                             hintStyle: TextStyle(fontSize: 14)),
                           ),
                         ),
                       ),
                     ),
                   ),
                 SizedBox(
                       width: MediaQuery.of(context).size.width * .4,
                       child: Material(
                         elevation: 2,
                         borderRadius: BorderRadius.circular(15),
                         child: Padding(
                           padding: EdgeInsets.only(left: 10),
                           child: DropdownButtonFormField<String>(
                             value: dropdownValue,
                             validator: (value) => value == null
                                 ? 'Please Select Data Type' : null,
                             icon: const Icon(Icons.arrow_downward),
                             style: TextStyle(
                                 color: Colors.grey.shade700
                             ),
                             elevation: 2,
                             //underline: Container(),
                             decoration: InputDecoration(
                               border: InputBorder.none,
                               focusedBorder: InputBorder.none,
                               enabledBorder: InputBorder.none,
                               errorBorder: InputBorder.none,
                               disabledBorder: InputBorder.none,

                             ),
                             hint: Text('Select Data Type'),
                             onChanged: (String? newValue) {
                               setState(() {
                                 dropdownValue = newValue!;
                               });
                             },
                             items: <String>[
                               'String',
                               'Number',
                               'Date',
                             ].map<DropdownMenuItem<String>>((String value) {
                               return DropdownMenuItem<String>(
                                 value: value,
                                 child: Text(value),
                               );
                             }).toList(),
                           ),
                         ),
                       )),
               ],
              ),
              SizedBox(height: 30,),
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                child: ElevatedButton(
                  onPressed: () {
                    final FormState? form = _formKey.currentState;
                    if (form!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  SecondPage(
                            number:numberOfFields.text.toString(),
                            typeValue:dropdownValue
                        )),
                      );
                      print('Form is valid');
                    } else {
                      print('Form is invalid');
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
                      'Next',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
