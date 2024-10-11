import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../widgets/round_button.dart';
import '../../../widgets/toash_message.dart';
import '../post_screen.dart';

class JobScreen extends StatefulWidget {
  @override
  State<JobScreen> createState() => _JobScreenState();
}

class _JobScreenState extends State<JobScreen> {
  final fireStoreF = FirebaseFirestore.instance.collection("User").snapshots();
  final fireStore = FirebaseFirestore.instance.collection("User");

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
              child: StreamBuilder<QuerySnapshot>(
                  stream: fireStoreF,
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("Something went wrong!"),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final title = snapshot.data!.docs[index]['title']
                                .toString();

                            if (searchController.text.isEmpty) {
                              return ListTile(
                                  leading: CircleAvatar(
                                    child: Center(
                                      child: Icon(Iconsax.user),
                                    ),
                                  ),
                                  title: Text(snapshot
                                      .data!.docs[index]['title']
                                      .toString()),
                                  subtitle: Text(snapshot
                                      .data!.docs[index]['description']
                                      .toString()),
                                  trailing: PopupMenuButton(
                                      icon: Icon(Iconsax.more),
                                      itemBuilder: (context) => [
                                            PopupMenuItem(
                                                value: 1,
                                                child: ListTile(
                                                  onTap: () async {
                                                    updateTitle.text =
                                                        snapshot
                                                            .data!
                                                            .docs[index]
                                                                ['title']
                                                            .toString();
                                                    var id = snapshot.data!
                                                        .docs[index].id
                                                        .toString();
                                                    updateDescription.text =
                                                        snapshot
                                                            .data!
                                                            .docs[index][
                                                                'description']
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
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      20),
                                                              topRight: Radius
                                                                  .circular(
                                                                      20),
                                                            ),
                                                          ),
                                                          child: Center(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                      15),
                                                              child: Column(
                                                                children: [
                                                                  SizedBox(
                                                                    height:
                                                                        10,
                                                                  ),
                                                                  TextFormField(
                                                                    controller:
                                                                        updateTitle,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .text,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      labelText:
                                                                          'Title',
                                                                      prefixIcon:
                                                                          Icon(Iconsax.text),
                                                                      border:
                                                                          OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        10,
                                                                  ),
                                                                  TextFormField(
                                                                    controller:
                                                                        updateDescription,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .text,
                                                                    maxLength:
                                                                        200,
                                                                    maxLines:
                                                                        5,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      labelText:
                                                                          'Description',
                                                                      hintText:
                                                                          "What is in your maind?",
                                                                      border:
                                                                          OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        20,
                                                                  ),
                                                                  RoundButton(
                                                                      title:
                                                                          "Update",
                                                                      onTap:
                                                                          () {
                                                                        fireStore.doc(id).update({
                                                                          "title":
                                                                              updateTitle.text.toString(),
                                                                          "description":
                                                                              updateDescription.text.toString(),
                                                                        }).then(
                                                                            (value) {
                                                                          Utilis.showSuccessToast("Update Success");
                                                                          Navigator.pop(context);
                                                                        }).onError((error,
                                                                            e) {
                                                                          Utilis.showFailedToast(error.toString());
                                                                          Navigator.pop(context);
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
                                                    var id = snapshot.data!
                                                        .docs[index].id
                                                        .toString();

                                                    fireStore
                                                        .doc(id)
                                                        .delete()
                                                        .then((value) {
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
                                searchController.text
                                    .toLowerCase()
                                    .toString())) {
                              return ListTile(
                                  leading: CircleAvatar(
                                    child: Center(
                                      child: Icon(Iconsax.user),
                                    ),
                                  ),
                                  title: Text(snapshot
                                      .data!.docs[index]['title']
                                      .toString()),
                                  subtitle: Text(snapshot
                                      .data!.docs[index]['description']
                                      .toString()),
                                  trailing: PopupMenuButton(
                                      icon: Icon(Iconsax.more),
                                      itemBuilder: (context) => [
                                            PopupMenuItem(
                                                value: 1,
                                                child: ListTile(
                                                  onTap: () async {
                                                    updateTitle.text =
                                                        snapshot
                                                            .data!
                                                            .docs[index]
                                                                ['title']
                                                            .toString();
                                                    var id = snapshot.data!
                                                        .docs[index].id
                                                        .toString();
                                                    updateDescription.text =
                                                        snapshot
                                                            .data!
                                                            .docs[index][
                                                                'description']
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
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      20),
                                                              topRight: Radius
                                                                  .circular(
                                                                      20),
                                                            ),
                                                          ),
                                                          child: Center(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(
                                                                      15),
                                                              child: Column(
                                                                children: [
                                                                  SizedBox(
                                                                    height:
                                                                        10,
                                                                  ),
                                                                  TextFormField(
                                                                    controller:
                                                                        updateTitle,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .text,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      labelText:
                                                                          'Title',
                                                                      prefixIcon:
                                                                          Icon(Iconsax.text),
                                                                      border:
                                                                          OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(20),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        10,
                                                                  ),
                                                                  TextFormField(
                                                                    controller:
                                                                        updateDescription,
                                                                    keyboardType:
                                                                        TextInputType
                                                                            .text,
                                                                    maxLength:
                                                                        200,
                                                                    maxLines:
                                                                        5,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      labelText:
                                                                          'Description',
                                                                      hintText:
                                                                          "What is in your maind?",
                                                                      border:
                                                                          OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height:
                                                                        20,
                                                                  ),
                                                                  RoundButton(
                                                                      title:
                                                                          "Update",
                                                                      onTap:
                                                                          () {
                                                                        fireStore.doc(id).update({
                                                                          "title":
                                                                              updateTitle.text,
                                                                          "description":
                                                                              updateDescription.text,
                                                                        }).then(
                                                                            (value) {
                                                                          Utilis.showSuccessToast("Update Success");
                                                                          Navigator.pop(context);
                                                                        }).onError((error,
                                                                            e) {
                                                                          Utilis.showFailedToast(error.toString());
                                                                          Navigator.pop(context);
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
                                                    var id = snapshot.data!
                                                        .docs[index].id
                                                        .toString();

                                                    fireStore
                                                        .doc(id)
                                                        .delete()
                                                        .then((value) {
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
                          });
                    }
                  }))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => FireStoreScreen()));
        },
        child: Icon(Iconsax.add),
      ),
    );
  }
}
