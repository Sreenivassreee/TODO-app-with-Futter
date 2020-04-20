import 'package:flutter/material.dart';

class LogoutOverlay extends StatefulWidget {
  var note;

  LogoutOverlay(this.note);

  @override
  State<StatefulWidget> createState() => LogoutOverlayState();
}

class LogoutOverlayState extends State<LogoutOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    print(widget.note.date);
    print("Status in CA ${widget.note.status}");

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 450),
    );
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            margin: EdgeInsets.all(20.0),
            padding: EdgeInsets.all(15.0),
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width,
            decoration: ShapeDecoration(
              color: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 2.0,
                    ),
                    child: Text(
                      "Title",
                      style: TextStyle(color: Colors.red, fontSize: 30.0),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      widget.note.title,
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 2.0,
                    ),
                    child: Text(
                      "Discription",
                      style: TextStyle(color: Colors.red, fontSize: 30.0),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      widget.note.description != null
                          ? widget.note.description
                          : "",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 2.0,
                    ),
                    child: Text(
                      "Due date",
                      style: TextStyle(color: Colors.red, fontSize: 30.0),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      widget.note.date != null ? widget.note.date : "",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 2.0,
                    ),
                    child: Text(
                      "Created date",
                      style: TextStyle(color: Colors.red, fontSize: 30.0),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Need To Add",
//                      widget.note.date != null ? widget.note.date : "",
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                      ),
                      child: ButtonTheme(
                        height: 35.0,
                        minWidth: 110.0,
                        child: RaisedButton(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          splashColor: Colors.white.withAlpha(40),
                          child: Text(
                            'Cancel',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 13.0),
                          ),
                          onPressed: () {
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
