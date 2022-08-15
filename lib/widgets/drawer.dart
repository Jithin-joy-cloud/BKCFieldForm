import 'package:bkc_field_form/controllers/user_controller.dart';
import 'package:bkc_field_form/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'alertDialogue.dart';

class DrawerWidget extends StatefulWidget {
  final double height;

  const DrawerWidget({Key? key, required this.height}) : super(key: key);

  @override
  DrawerWidgetState createState() => DrawerWidgetState();
}

class DrawerWidgetState extends StateMVC<DrawerWidget> {
  UserController _controller = UserController();

  DrawerWidgetState() : super(UserController()) {
    _controller = controller as UserController;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).primaryColorDark,
                      ]),
                ),
                height: widget.height * .25,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: EdgeInsets.all(widget.height * .015),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.account_circle_sharp,
                          size: widget.height * .1,
                          color: Theme.of(context).cardColor,
                        ),
                        SizedBox(
                          height: widget.height * .01,
                        ),
                        Text(
                          "Welcome " + currentUser.value.username,
                          style: TextStyle(
                              fontSize: widget.height * .02,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: widget.height * .01,
                        ),
                        Text(
                          currentUser.value.email,
                          style: TextStyle(
                            fontSize: widget.height * .018,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox( height: widget.height * .65,
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: Wrap(
                        runSpacing: 10,
                        children: [
                          ListTile(
                              onTap: () {
                                Navigator.pushNamed(context, '/home');
                              },
                              leading: Icon(
                                Icons.home,
                                color: Theme.of(context).primaryColor,
                              ),
                              title: Text(
                                "Home",
                                style: TextStyle(
                                    fontSize: widget.height * .02,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold),
                              )),
                          ListTile(
                              onTap: () {
                                Navigator.pushNamed(context, '/profile');
                              },
                              leading: Icon(
                                Icons.account_box_rounded,
                                color: Theme.of(context).primaryColor,
                              ),
                              title: Text(
                                "Profile",
                                style: TextStyle(
                                    fontSize: widget.height * .02,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold),
                              )),
                          ListTile(
                              onTap: () {
                                Navigator.pushNamed(context, '/localForm');
                              },
                              leading: Icon(
                                Icons.archive_sharp ,
                                color: Theme.of(context).primaryColor,
                              ),
                              title: Text(
                                "Offline Forms",
                                style: TextStyle(
                                    fontSize: widget.height * .02,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold),
                              )),
                          ListTile(
                            onTap: () {
                              Navigator.pushNamed(context, '/serverForm');
                            },
                            leading: Icon(
                              Icons.cloud_download_sharp,
                              color: Theme.of(context).primaryColor,
                            ),
                            title: Text(
                              "Uploaded Forms",
                              style: TextStyle(
                                  fontSize: widget.height * .02,
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          ListTile(
                              onTap: () {
                                Navigator.pushNamed(context, '/documents');
                              },
                              leading: Icon(
                                Icons.description,
                                color: Theme.of(context).primaryColor,
                              ),
                              title: Text(
                                "Documents",
                                style: TextStyle(
                                    fontSize: widget.height * .02,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold),
                              )),
                          /* ListTile(
                            onTap: () {
                              Alert.showDialogue(
                                context,
                                "Logout",
                                "Are you sure you want to logout?",
                              );
                            },
                            leading: Icon(
                              Icons.logout,
                              color: Theme.of(context).canvasColor,
                            ),
                            title: Text(
                              "Logout",
                              style: TextStyle(
                                  fontSize: widget.height * .02,
                                  fontWeight: FontWeight.bold),
                            ),
                          )*/
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text("Version : 0.8.0",
                          style: TextStyle(
                            fontSize: widget.height * .02,
                            color: Theme.of(context).primaryColor,
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
