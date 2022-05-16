import 'package:aielements/ui/homePage.dart';
import 'package:flutter/material.dart';
class ThirdPage extends StatefulWidget {
  final String number;
  final List typeValue;
  ThirdPage({required this.number,required this.typeValue});

  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Third Page'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height*.8,
              child: ListView(children: <Widget>[

                DataTable(
                  columns: [
                    DataColumn(label: Text(
                        'ID',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                    )),
                    DataColumn(label: Text(
                        'Data',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                    )),

                  ],
                  rows: [
                    for(int i=0;i<int.parse(widget.number);i++)
                    DataRow(cells: [

                      DataCell(
                          Text(i.toString())),
                          DataCell(Text(widget.typeValue[i].toString())),
                    ]),

                  ],
                ),
              ]),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  HomePage()),
                  );

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
                    'Create new Form',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        )
    ),
    );
  }
}
