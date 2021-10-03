import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbm_voting/common/shared.dart';
import 'package:mbm_voting/screens/closed_polls.dart';
import 'package:mbm_voting/screens/create_poll.dart';
import 'package:mbm_voting/screens/my_votes.dart';
import 'package:velocity_x/velocity_x.dart';

class AdminDrawer extends StatefulWidget {
  const AdminDrawer({Key? key}) : super(key: key);

  @override
  State<AdminDrawer> createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {
  String rollNumber = "";

  @override
  void initState() {
    MySharedPreferences.instance.getStringValue("rollNumber").then((value) => {
          setState(() {
            rollNumber = value;
          })
        });
    super.initState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            DrawerHeader(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.7),
                              spreadRadius: 1,
                              blurRadius: 100,
                            ),
                          ],
                          borderRadius: const BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: const CircleAvatar(
                          backgroundColor: Colors.greenAccent,
                          radius: 25.0,
                        ),
                      ).pOnly(right: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Welcome',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                          Text(
                            "Admin",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontFamily: 'OpenSans',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ).pOnly(right: 20),
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: 0,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blueGrey,
                  width: 1,
                ),
              ),
            ).pOnly(bottom: 30),
            Expanded(
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView(
                  shrinkWrap: true,
                  children: const [
                    DrawerTile(
                      heading: 'Create a Poll',
                      subtitle: 'Create a shiny new Poll',
                      icon: CupertinoIcons.game_controller,
                      navigateTo: CreatePoll(),
                    ),
                    DrawerTile(
                      heading: 'Get All Results',
                      subtitle: 'Get All Results',
                      icon: CupertinoIcons.bolt,
                      navigateTo: ClosedPolls(),
                    ),
                    DrawerTile(
                      heading: 'Closed Polls',
                      subtitle: 'Check out results of closed Polls',
                      icon: CupertinoIcons.bolt,
                      navigateTo: ClosedPolls(),
                    ),
                    DrawerTile(
                      heading: 'Logout',
                      subtitle: '',
                      icon: CupertinoIcons.gear,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DrawerTile extends StatelessWidget {
  final String heading;
  final String subtitle;
  final IconData icon;
  final Widget? navigateTo;

  const DrawerTile({
    Key? key,
    required this.heading,
    required this.subtitle,
    required this.icon,
    this.navigateTo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading: Icon(
      //   icon,
      //   color: Colors.grey[400],
      // ),
      title: Container(
        margin: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              heading,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                fontFamily: 'OpenSans',
                color: Colors.black,
              ),
            ).pOnly(bottom: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'OpenSans',
                color: Colors.black.withOpacity(0.4),
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        navigateTo == null
            ? {}
            : Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => navigateTo!,
                ),
              );
      },
    );
  }
}
