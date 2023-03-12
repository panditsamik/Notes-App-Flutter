import 'package:flutter/material.dart';
import 'task.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> list = [];
  String text = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.lightBlueAccent,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightBlueAccent,
          child: Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet<void>(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              isScrollControlled: true,
              context: context,
              builder: (BuildContext context) {
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                      color: Colors.white,
                    ),
                    height: 200.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Add Notes',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 25.0,
                              color: Colors.lightBlueAccent),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 40.0, top: 8.0, right: 40.0, bottom: 13.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Enter your notes',
                            ),
                            onChanged: (newText) {
                              text = newText;
                            },
                            autofocus: true,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              list.add(Task(text: text));
                              Navigator.pop(context);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(12), // <-- Radius
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 100.0,
                                top: 10,
                                right: 100.0,
                                bottom: 10.0),
                            child: Text(
                              'ADD',
                              style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                  child: Container(
                    padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          child: Image(
                            image: AssetImage('images/notepad.png'),
                            height: 55.0,
                            width: 55.0,
                          ),
                          backgroundColor: Colors.white,
                          radius: 40.0,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          'Notes',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 50.0,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic),
                        ),
                        SizedBox(
                          height: 1.0,
                        ),
                        Text(
                          '${list.length} Notes',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.normal,
                              fontStyle: FontStyle.normal),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 10.0, right: 20.0, bottom: 0.0),
                    child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onLongPress: () {
                            showCupertinoModalPopup<void>(
                              context: context,
                              builder: (BuildContext context) =>
                                  CupertinoAlertDialog(
                                title: const Text('Alert'),
                                content: const Text(
                                    'Want to delete the selected note?'),
                                actions: <CupertinoDialogAction>[
                                  CupertinoDialogAction(
                                    isDefaultAction: true,
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('No'),
                                  ),
                                  CupertinoDialogAction(
                                    isDestructiveAction: true,
                                    onPressed: () {
                                      setState(() {
                                        list.removeWhere(
                                            (element) => element.check == true);
                                        Navigator.pop(context);
                                      });
                                    },
                                    child: const Text('Yes'),
                                  ),
                                ],
                              ),
                            );
                          },
                          title: Text(
                            list[index].text,
                            style: list[index].check
                                ? TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.lineThrough)
                                : TextStyle(
                                    fontSize: 16.0,
                                    decoration: TextDecoration.none),
                          ),
                          trailing: Checkbox(
                            value: list[index].check,
                            onChanged: (newValue) {
                              setState(() {
                                list[index].check = newValue!;
                              });
                            },
                          ),
                        );
                      },
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
