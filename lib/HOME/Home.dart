import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int key = 0; // Used to generate unique keys for each entry
  bool isAdd = true;
  TextEditingController textPlanController =
      TextEditingController(); // TextField controller for input

  List<String> allPlans = []; // List to store all fetched plans

  @override
  void initState() {
    super.initState();
    retrieveKeyFromShared(); // Retrieve the stored key
    retrieveAllDataFromShared(); // Retrieve all saved plans
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          addData();
        },
        child: Icon(Icons.add_sharp),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          // Wrap ListView.builder with Expanded to make it scrollable
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // create one row.
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            width: 350,
                            child: Card(
                              elevation: 7,
                              shadowColor: Colors.grey,
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  allPlans[index],
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ), // Display all plans
                              ),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: () {
                                // to perform the delete opetation

                                DeleteData(index);
                              },
                              child: SizedBox(
                                height: 30,
                                width: 23,
                                child: Image.asset(
                                  "assets/images/delete.png",
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            InkWell(
                                onTap: () {
                                  // to perform the edit operation.. modify..
                                },
                                child: SizedBox(
                                  height: 30,
                                  width: 23,
                                  child: Image.asset(
                                    "assets/images/edit.png",
                                    color: Colors.black,
                                  ),
                                )),
                          ],
                        )
                      ],
                    )
                  ],
                );
              },
              itemCount: allPlans.length,
            ),
          ),
        ],
      ),
    );
  }

  // showDialog Box..
  void addData() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              elevation: 7,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              title: Text("Add Your Plan"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: textPlanController,
                    decoration: InputDecoration(
                      labelText: "Enter Your Plan",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {
                            isAdd = true;
                          });
                        },
                        child: Text("Cancel"),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                12), // Set your desired radius here
                          ),
                          backgroundColor: isAdd ? Colors.orange : Colors.white,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          String plan = textPlanController.text;
                          // Check the text is empty or not
                          if (plan.isEmpty) {
                            Fluttertoast.showToast(
                                msg: "Enter Your Plan",
                                toastLength: Toast.LENGTH_LONG,
                                backgroundColor: Colors.red);
                          } else {
                            saveDataIntoShared(plan);
                          }
                          setState(() {
                            isAdd = false;
                          });
                        },
                        child: Text("Add"),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                12), // Set your desired radius here
                          ),
                          backgroundColor:
                              !isAdd ? Colors.orange : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Method to save data and increment key for each new entry
  Future<void> saveDataIntoShared(String plan) async {
    // create the reference..
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        key.toString(), plan); // Save plan with the current key
    key++; // Increment the key for next data entry
    await prefs.setInt('key', key); // Save the updated key

    Fluttertoast.showToast(
      msg: "Data Saved",
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: Colors.green,
    ).then((value) {
      Navigator.pop(context);
      textPlanController.clear(); // Clear the TextField after adding data
      retrieveAllDataFromShared(); // Refresh the list of plans
    });
  }

  // Method to retrieve all data from SharedPreferences
  Future<void> retrieveAllDataFromShared() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> plans = [];

    // Iterate through all keys and retrieve corresponding plans
    for (int i = 0; i < prefs.getKeys().length; i++) {
      String? plan = prefs.getString(i.toString());
      if (plan != null) {
        plans.add(plan);
      }
    }

    setState(() {
      allPlans = plans;
    });
  }

  // Method to retrieve the stored key value from SharedPreferences
  Future<void> retrieveKeyFromShared() async {
    final prefs = await SharedPreferences.getInstance();
    int storedKey = prefs.getInt('key') ?? 0; // Default to 0 if no key is found
    setState(() {
      key = storedKey;
    });
  }

  DeleteData(int index) async {
    final prefs = await SharedPreferences.getInstance();

    // Remove the corresponding plan from SharedPreferences
    String keyToDelete = index.toString(); // Assuming the index corresponds to the key

    // Remove the data from SharedPreferences using the key
    await prefs.remove(keyToDelete);

    // Update the in-memory list to reflect the deletion
    setState(() {
      allPlans.removeAt(index); // Remove the plan from the in-memory list
    });

    Fluttertoast.showToast(
      msg: "Your Plan Deleted",
      toastLength: Toast.LENGTH_LONG,
    );

    // Optionally update the 'key' stored in SharedPreferences if required
    int storedKey = prefs.getInt('key') ?? 0;
    storedKey--; // Decrease the key if needed after deletion
    await prefs.setInt('key', storedKey); // Update the key
  }

}
