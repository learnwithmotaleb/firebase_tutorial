import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_tutorial/AsifTaj/Screen/post_screen.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../ui/auth/login_screen.dart';
import '../widgets/round_button.dart';
import '../widgets/toash_message.dart';
import 'firestore/post_screen.dart';

class HomeScreenF extends StatefulWidget {
  const HomeScreenF({super.key});

  @override
  State<HomeScreenF> createState() => _HomeScreenFState();
}

class _HomeScreenFState extends State<HomeScreenF> {
  int _selectedIndex = 0;

  // List of widget pages
  final List<Widget> _pages = [
    HomeScreen(),
    JobScreen(),
    TrainingScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LWM"),
        centerTitle: false,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Job',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Training',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(
                        'assets/icons/logo.png'), // Replace with your image asset
                  ),
                  SizedBox(height: 10),
                  Text(
                    'LWM',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                // Add your App Rate functionality
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('App Rate'),
              onTap: () {
                // Add your App Rate functionality
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip),
              title: Text('Privacy Policy'),
              onTap: () {
                // Add your Privacy Policy functionality
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                FirebaseAuth auth = FirebaseAuth.instance;
                auth.signOut().then((value) {
                  Utilis.showSuccessToast("Logout Successful!");
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreenF()),
                      (route) => false);
                }).onError((error, messer) {
                  Utilis.showSuccessToast("Some Error. Please Check!");
                });

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

// Placeholder pages for each tab
class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ref = FirebaseDatabase.instance.ref("User");

  TextEditingController searchController = TextEditingController();

  TextEditingController updateTitle = TextEditingController();
  TextEditingController updateDescription = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchController,
              keyboardType: TextInputType.text,
              onChanged: (String value) {
                setState(() {});
              },
              decoration: InputDecoration(
                labelText: 'Searching',
                prefixIcon: Icon(Iconsax.search_normal),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                defaultChild: Center(
                  child: Text("Loading"),
                ),
                itemBuilder: (context, snapshot, animation, index) {
                  final title = snapshot.child("title").value.toString();

                  if (searchController.text.isEmpty) {

                    return ListTile(
                        onLongPress: () {},
                        title: Text(snapshot.child("title").value.toString()),
                        subtitle: Text(
                            snapshot.child("description").value.toString()),
                        leading: CircleAvatar(child: Icon(Iconsax.user)),
                        trailing: PopupMenuButton(
                            icon: Icon(Iconsax.more),
                            itemBuilder: (context) => [
                                  PopupMenuItem(
                                      value: 1,
                                      child: ListTile(
                                        onTap: () async {
                                          updateTitle.text = snapshot
                                              .child("title")
                                              .value
                                              .toString();
                                          var id = snapshot
                                              .child("id")
                                              .value
                                              .toString();
                                          updateDescription.text = snapshot
                                              .child("description")
                                              .value
                                              .toString();

                                          Navigator.pop(context);
                                          await showModalBottomSheet(
                                            context: context,
                                            isScrollControlled:
                                                true, // Allows the bottom sheet to take specified height
                                            builder: (context) {
                                              return Container(
                                                height:
                                                    400, // Set the desired height
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20),
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              updateTitle,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText: 'Title',
                                                            prefixIcon: Icon(
                                                                Iconsax.text),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        TextFormField(
                                                          controller:
                                                              updateDescription,
                                                          keyboardType:
                                                              TextInputType
                                                                  .text,
                                                          maxLength: 200,
                                                          maxLines: 5,
                                                          decoration:
                                                              InputDecoration(
                                                            labelText:
                                                                'Description',
                                                            hintText:
                                                                "What is in your maind?",
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        RoundButton(
                                                            title: "Update",
                                                            onTap: () {
                                                              ref
                                                                  .child(id)
                                                                  .update({
                                                                "title":
                                                                    updateTitle
                                                                        .text,
                                                                "description":
                                                                    updateDescription
                                                                        .text,
                                                              }).then((value) {
                                                                Utilis.showSuccessToast(
                                                                    "Update Success");
                                                                Navigator.pop(
                                                                    context);
                                                              }).onError((error,
                                                                      e) {
                                                                Utilis.showFailedToast(
                                                                    error
                                                                        .toString());
                                                                Navigator.pop(
                                                                    context);
                                                              });
                                                            })
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        leading: Icon(Icons.edit),
                                        title: Text("Eidt"),
                                      )),
                                  PopupMenuItem(
                                      value: 2,
                                      child: ListTile(
                                        onTap: () {
                                          var id = snapshot
                                              .child("id")
                                              .value
                                              .toString();
                                          ref.child(id).remove().then((value) {
                                            Utilis.showSuccessToast(
                                                "Delete Success!");
                                            Navigator.pop(context);
                                          }).onError((error, e) {
                                            Utilis.showFailedToast(
                                                error.toString());
                                            Navigator.pop(context);
                                          });
                                        },
                                        leading: Icon(Icons.delete),
                                        title: Text("Delete"),
                                      )),
                                ]));

                  } else if (title.toLowerCase().contains(
                      searchController.text.toLowerCase().toString())) {

                    return ListTile(
                        onLongPress: () {},
                        title: Text(snapshot.child("title").value.toString()),
                        subtitle: Text(
                            snapshot.child("description").value.toString()),
                        leading: CircleAvatar(child: Icon(Iconsax.user)),
                        trailing: PopupMenuButton(
                            icon: Icon(Iconsax.more),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                  value: 1,
                                  child: ListTile(
                                    onTap: () async {
                                      updateTitle.text = snapshot
                                          .child("title")
                                          .value
                                          .toString();
                                      var id = snapshot
                                          .child("id")
                                          .value
                                          .toString();
                                      updateDescription.text = snapshot
                                          .child("description")
                                          .value
                                          .toString();

                                      Navigator.pop(context);
                                      await showModalBottomSheet(
                                        context: context,
                                        isScrollControlled:
                                        true, // Allows the bottom sheet to take specified height
                                        builder: (context) {
                                          return Container(
                                            height:
                                            400, // Set the desired height
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                              BorderRadius.only(
                                                topLeft:
                                                Radius.circular(20),
                                                topRight:
                                                Radius.circular(20),
                                              ),
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                const EdgeInsets.all(
                                                    15),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    TextFormField(
                                                      controller:
                                                      updateTitle,
                                                      keyboardType:
                                                      TextInputType
                                                          .text,
                                                      decoration:
                                                      InputDecoration(
                                                        labelText: 'Title',
                                                        prefixIcon: Icon(
                                                            Iconsax.text),
                                                        border:
                                                        OutlineInputBorder(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              20),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    TextFormField(
                                                      controller:
                                                      updateDescription,
                                                      keyboardType:
                                                      TextInputType
                                                          .text,
                                                      maxLength: 200,
                                                      maxLines: 5,
                                                      decoration:
                                                      InputDecoration(
                                                        labelText:
                                                        'Description',
                                                        hintText:
                                                        "What is in your maind?",
                                                        border:
                                                        OutlineInputBorder(
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              10),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    RoundButton(
                                                        title: "Update",
                                                        onTap: () {
                                                          ref
                                                              .child(id)
                                                              .update({
                                                            "title":
                                                            updateTitle
                                                                .text,
                                                            "description":
                                                            updateDescription
                                                                .text,
                                                          }).then((value) {
                                                            Utilis.showSuccessToast(
                                                                "Update Success");
                                                            Navigator.pop(
                                                                context);
                                                          }).onError((error,
                                                              e) {
                                                            Utilis.showFailedToast(
                                                                error
                                                                    .toString());
                                                            Navigator.pop(
                                                                context);
                                                          });
                                                        })
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    leading: Icon(Icons.edit),
                                    title: Text("Eidt"),
                                  )),
                              PopupMenuItem(
                                  value: 2,
                                  child: ListTile(
                                    onTap: () {
                                      var id = snapshot
                                          .child("id")
                                          .value
                                          .toString();
                                      ref.child(id).remove().then((value) {
                                        Utilis.showSuccessToast(
                                            "Delete Success!");
                                        Navigator.pop(context);
                                      }).onError((error, e) {
                                        Utilis.showFailedToast(
                                            error.toString());
                                        Navigator.pop(context);
                                      });
                                    },
                                    leading: Icon(Icons.delete),
                                    title: Text("Delete"),
                                  )),
                            ]));

                  } else {
                    return Container();
                  }
                }),
          ),
          // Expanded(
          //     child: StreamBuilder(
          //       stream: ref.onValue,
          //         builder: (BuildContext context, AsyncSnapshot<DatabaseEvent> snapshot){
          //           ///Handle connection states
          //           if (snapshot.connectionState == ConnectionState.waiting) {
          //             return Center(child: CircularProgressIndicator()); // Show loading indicator while waiting for data
          //           } else if (snapshot.hasError) {
          //             return Text('Error: ${snapshot.error}'); // Display error message if there's an error
          //           } else if (snapshot.connectionState == ConnectionState.done) {
          //             return Text("Stream closed! Last value: ${snapshot.data}");
          //           } else if (!snapshot.hasData) {
          //             return Text("No data available");
          //           } else {
          //
          //             Map<dynamic,dynamic> map = snapshot.data!.snapshot.value as dynamic;
          //
          //             List<dynamic> list = [];
          //             list.clear();
          //             list = map.values.toList();
          //
          //             return ListView.builder(
          //                 itemCount: snapshot.data!.snapshot.children.length,
          //                 itemBuilder: (context, index){
          //                   return ListTile(
          //                     title: Text(list[index]['title']),
          //                     subtitle: Text(list[index]['description']),
          //                     leading: CircleAvatar(
          //                       backgroundColor: Colors.grey,
          //                       child: Center(
          //                         child: Icon(Iconsax.user),
          //                       ),
          //                     ),
          //                   );
          //                 }
          //             );
          //           }
          //
          //
          //         }
          //     )
          //
          // )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PostScreenF()));
        },
        child: Icon(Iconsax.add),
      ),

    );
  }
}

class JobScreen extends StatefulWidget {
  @override
  State<JobScreen> createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> FireStoreScreen()));

        },
        child: Icon(Iconsax.add),
      ),

    );
  }
}

class TrainingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Training Page'));
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Profile Page'));
  }
}
