import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/models/task_data.dart';
import 'package:todoey_flutter/models/notifications.dart';

class AddTaskScreen extends StatelessWidget {


  int createUniqueId() {
    return DateTime.now().microsecondsSinceEpoch.remainder(100000);
  }

  @override
  Widget build(BuildContext context) {
    String text = "zadanie";
    late int taskId;
    return Container(
      color: Color(0xff757575),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            topLeft: Radius.circular(20.0),
          ),
        ),
        child: Container(
          padding:
              EdgeInsets.only(top: 30.0, left: 70.0, right: 70.0, bottom: 20.0),
          child: Column(
            children: [
              Text(
                "Dodaj zadanie",
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 25.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextField(
                onChanged: (value) {
                  text = value;
                },
                onSubmitted: (value){value = text;},
                onEditingComplete: (){},
                autofocus: true,
                textAlign: TextAlign.center,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText: "Wpisz zadanie do wykonania",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      width: 5,
                      color: Colors.lightBlueAccent,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20.0),
                child: GestureDetector(
                  onTap: () {
                    print(text);
                    taskId = createUniqueId();
                    Provider.of<TaskData>(context, listen: false).addTask(text,taskId);
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                          title: Text("Przypomnienie"),
                          content: Text(
                              "Czy chcesz ustawić przypomnienie dla tego zadania?"),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                NotificationWeekAndTime? pickedSchedule =
                                    await pickSchedule(context);
                                if (pickedSchedule != null) {
                                  Navigator.pop(context);
                                  createNotification(pickedSchedule, text, taskId);
                                }
                              },
                              child: Text(
                                "Tak",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Nie",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ]),
                    );
                  },
                  child: Container(
                    width: 300.0,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.lightBlueAccent,
                    ),
                    child: Center(
                      child: Text(
                        "Dodaj",
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}



