import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:computer_products_app/shared/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GetDataFromFireStore extends StatefulWidget {
  final String documentId;

  const GetDataFromFireStore({required this.documentId, super.key});

  @override
  State<GetDataFromFireStore> createState() => _GetDataFromFireStoreState();
}

class _GetDataFromFireStoreState extends State<GetDataFromFireStore> {
  final dialogUsernameController = TextEditingController();
  final credential = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  showsDialog(data, dynamic key) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
          child: Container(
            padding: const EdgeInsets.all(22),
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                    controller: dialogUsernameController,
                    maxLength: 20,
                    decoration: InputDecoration(hintText: "${data[key]}")),
                const SizedBox(
                  height: 22,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          users
                              .doc(credential!.uid)
                              .update({key: dialogUsernameController.text});
                          setState(() {
                            Navigator.pop(context);
                          });
                        },
                        child: const Text(
                          "Edit",
                          style: TextStyle(fontSize: 18, color: bTNgreen),
                        )),
                    TextButton(
                        onPressed: () {
                          // addnewtask();
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(fontSize: 18, color: bink),
                        )),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.documentId).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          return const Text(
            "Document does not exist",
            style: TextStyle(fontSize: 18, color: bink),
          );
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "User name: ${data['username']}",
                        style: const TextStyle(color: bTNBlue, fontSize: 18),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          showsDialog(data, 'username');
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: bTNgreen,
                        )),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            users
                                .doc(credential!.uid)
                                .update({'username': FieldValue.delete()});
                          });
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: bink,
                        ))
                  ],
                ),
                // const SizedBox(
                //   height: 5,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Email: ${data['email']}",
                        style: const TextStyle(color: bTNBlue, fontSize: 18),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          showsDialog(data, 'email');
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: bTNgreen,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.delete,
                          color: bink,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Password: ${data['pass']}",
                        style: const TextStyle(color: bTNBlue, fontSize: 18),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          showsDialog(data, 'pass');
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: bTNgreen,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.delete,
                          color: bink,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Age: ${data['age']} years old.",
                        style: const TextStyle(color: bTNBlue, fontSize: 18),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          showsDialog(data, 'age');
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: bTNgreen,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.delete,
                          color: bink,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        "Title: ${data['title']}",
                        style: const TextStyle(color: bTNBlue, fontSize: 18),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          showsDialog(data, 'title');
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: bTNgreen,
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.delete,
                          color: bink,
                        ))
                  ],
                ),

                TextButton(
                    onPressed: () {
                      setState(() {
                        users.doc(credential!.uid).delete();
                      });
                    },
                    child: const Text(
                      "Delete data",
                      style: TextStyle(
                          fontSize: 18,
                          color: bink,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          );
        }

        return const Text("loading");
      },
    );
  }
}
