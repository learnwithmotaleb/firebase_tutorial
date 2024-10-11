import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../widgets/round_button.dart';
import '../../../widgets/toash_message.dart';
import '../../post_screen.dart';

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
                  }
                  else if (title.toLowerCase().contains(
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