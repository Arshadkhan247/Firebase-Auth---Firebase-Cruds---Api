import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CrudOperation extends StatefulWidget {
  const CrudOperation({super.key});

  @override
  State<CrudOperation> createState() => _CrudOperationState();
}

class _CrudOperationState extends State<CrudOperation> {
  final fNameController = TextEditingController();
  final lNameController = TextEditingController();
  final ageController = TextEditingController();

  final _firebaseStore = FirebaseFirestore.instance;

  create() async {
    await _firebaseStore.collection("User").doc(fNameController.text).set({
      "First_Name": fNameController.text,
      "Last_Name": lNameController.text,
      "Age": ageController.text
    });
  }

  update() async {
    await _firebaseStore.collection("User").doc(fNameController.text).update({
      "First_Name": fNameController.text,
      "Last_Name": lNameController.text,
      "Age": ageController.text
    });
  }

  delete() async {
    await _firebaseStore.collection("User").doc(fNameController.text).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Crud Operation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            TextFormField(
              controller: fNameController,
              decoration: const InputDecoration(hintText: 'First Name '),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: lNameController,
              decoration: const InputDecoration(hintText: 'Last Name '),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              controller: ageController,
              decoration: const InputDecoration(hintText: 'Age  '),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                  onPressed: () {
                    create();
                    fNameController.clear();
                    lNameController.clear();
                    ageController.clear();
                  },
                  child: const Text('Create'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                  onPressed: () {
                    update();
                    fNameController.clear();
                    lNameController.clear();
                    ageController.clear();
                  },
                  child: const Text('Update'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                  onPressed: () {
                    delete();
                    fNameController.clear();
                    lNameController.clear();
                    ageController.clear();
                  },
                  child: const Text('Delete'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
