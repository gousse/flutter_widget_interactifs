import 'package:flutter/material.dart';

class InteractivePage extends StatefulWidget {
  const InteractivePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return InteractivePageState();
  }
}

class InteractivePageState extends State<InteractivePage> {
  Color backgroundColor = Colors.white;
  Color textColor = Colors.black;
  bool textButtonPressed = false;
  String prenom = "";
  late TextEditingController controller;
  bool switchValue = true;
  double sliderValue = 50;
  bool check = false;
  Map<String, bool> course = {"carotte": false, "oignon": true};
  int groupValue = 1;
  DateTime initialDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    // pendant l'init
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
    // pendant la suppression (remove from tree)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(title: Text(updateAppBarText())),
      body: Center(
        child: Column(
          children: [
            TextButton(
                onPressed: updateAppBar,
                child: Row(
                  children: [const Icon(Icons.work), buttonText()],
                )),
            ElevatedButton(
              onPressed: () {
                showDatePicker(
                        context: context,
                        initialDate: initialDate,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2090))
                    .then((value) => {
                          if (value != null)
                            {
                              setState(() {
                                initialDate = value;
                              })
                            }
                        });
              },
              onLongPress: () {
                print("long appuie");
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  elevation: 10,
                  textStyle: const TextStyle(fontSize: 15)),
              child: Text(initialDate.toString()),
            ),
            IconButton(
                onPressed: () {
                  print("icon button");
                },
                icon: const Icon(Icons.favorite)),
            TextField(
              obscureText: false,
              decoration: InputDecoration(
                  hintText: "taper votre prenom",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25))),
              keyboardType: TextInputType.emailAddress,
              onSubmitted: (newString) {
                setState(() {
                  prenom = newString;
                });
              },
            ),
            Text(prenom),
            TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: "nom"),
              onChanged: (value) {
                setState(() {});
              },
            ),
            Text(controller.text),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text((switchValue) ? "chat" : "chien"),
                Switch(
                    activeColor: Colors.green,
                    inactiveTrackColor: Colors.red,
                    value: switchValue,
                    onChanged: (b) {
                      setState(() {
                        switchValue = b;
                      });
                    }),
              ],
            ),
            Slider(
                min: 0,
                max: 100,
                value: sliderValue,
                thumbColor: Colors.purple,
                inactiveColor: Colors.brown,
                activeColor: Colors.yellow,
                onChanged: (v) {
                  setState(() {
                    sliderValue = v;
                  });
                }),
            Text("Valeur: ${sliderValue.toInt()}"),
            Checkbox(
                value: check,
                onChanged: (b) {
                  setState(() {
                    check = b ?? false;
                  });
                }),
            checkList(),
            radios()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: updateColors, child: const Icon(Icons.build)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  updateColors() {
    setState(() {
      backgroundColor =
          (backgroundColor == Colors.white) ? Colors.black : Colors.white;
      textColor = (textColor == Colors.black) ? Colors.white : Colors.black;
    });
  }

  updateAppBar() {
    setState(() {
      textButtonPressed = !textButtonPressed;
    });
  }

  String updateAppBarText() {
    return (textButtonPressed ? "clicked" : "interactive");
  }

  Text buttonText() {
    return const Text(
      "TextButton",
      style: TextStyle(color: Colors.amber, backgroundColor: Colors.grey),
    );
  }

  Column checkList() {
    List<Widget> items = [];
    course.forEach(
      (key, value) {
        Widget row = Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Checkbox(
                value: value,
                onChanged: ((newva) {
                  setState(() {
                    course[key] = newva ?? false;
                  });
                })),
            Text(key)
          ],
        );
        items.add(row);
      },
    );
    return Column(
      children: items,
    );
  }

  Row radios() {
    List<Widget> radios = [];
    for (var i = 0; i < 5; i++) {
      Radio r = Radio(
          value: i,
          groupValue: groupValue,
          activeColor: Colors.greenAccent,
          onChanged: ((nv) {
            setState(() {
              print(nv);
              groupValue = nv as int;
            });
          }));
      radios.add(r);
    }
    return Row(children: radios);
  }
}
