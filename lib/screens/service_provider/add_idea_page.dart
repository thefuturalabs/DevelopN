import 'package:develop_n/Constants/constants.dart';
import 'package:develop_n/services/services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddIdeaPage extends StatefulWidget {
  AddIdeaPage({super.key});

  @override
  State<AddIdeaPage> createState() => _AddIdeaPageState();
}

class _AddIdeaPageState extends State<AddIdeaPage> {
  TextEditingController titleController = TextEditingController();

  TextEditingController priceController = TextEditingController();

  TextEditingController ideaController = TextEditingController();

  String? category;

  final fkey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Services.fetchAndSetIdeaCategories().then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: fkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'add your idea details below',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'textfield cannot be empty';
                      }
                    },
                    controller: titleController,
                    decoration: const InputDecoration(
                      label: Text('title'),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'textfield cannot be empty';
                      }
                    },
                    controller: ideaController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      label: Text('details'),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 150,
                    child: TextFormField(
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'textfield cannot be empty';
                        }
                      },
                      keyboardType: TextInputType.number,
                      controller: priceController,
                      decoration: const InputDecoration(
                        label: Text('price'),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: InputDecorator(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), label: Text('category')),
                    child: Autocomplete(onSelected: (v) {
                      category = v;
                    }, optionsBuilder: (value) {
                      if (value.text == '') {
                        return Iterable<String>.empty();
                      } else {
                        category=value.text;
                        return Constants.ideaCategories.where((element) =>
                            element
                                .toUpperCase()
                                .contains(value.text.toUpperCase()));
                      }
                    }),
                  ),
                ),
                // DropdownButtonFormField(
                //     items: Constants.ideaCategories
                //         .map((e) => DropdownMenuItem(child: Text(e)))
                //         .toList(),
                //     onChanged: (value) {
                //       setState(() {
                //         category = value;
                //       });
                //     }),
                // Expanded(child: SizedBox()),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: ElevatedButton(
                      onPressed: () {
                        if (fkey.currentState!.validate()) {
                          if (category != null) {
                            addIdea(context);
                          } else {
                            Fluttertoast.showToast(msg: 'select category');
                          }
                        }
                      },
                      child: const Text('Submit Idea'),
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

  addIdea(BuildContext cotnext) async {
    String? uid = await Services.getUserId();
    Map data = await Services.postData({
      'provider_id': uid ?? '2',
      'title': titleController.text,
      'idea': ideaController.text,
      'price': priceController.text,
      'category':category,
    }, 'add_idea.php');
    if (data['result'] == 'done') {
      Fluttertoast.showToast(msg: 'Idea added successfully');
      Navigator.pop(cotnext);
    }
  }
}
