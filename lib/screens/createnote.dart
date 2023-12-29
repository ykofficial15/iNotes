import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'about.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({Key? key}) : super(key: key);

  @override
  _CreateNoteState createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  List<Note> savedNotes = [];

  Future<void> saveNoteButtonPressed() async {
    String title = titleController.text;
    String content = contentController.text;

    try {
      await saveNote(title, content);
      // Saving successful, perform any necessary actions
      // or show a success message to the user.
      print('Note saved successfully');
      titleController.clear();
      contentController.clear();
      loadSavedNotes(); // Refresh the saved notes list
    } catch (e) {
      // Saving failed, handle the error.
      print('Failed to save note: $e');
    }
  }

  Future<void> saveNote(String title, String content) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? noteTitles = prefs.getStringList('noteTitles');
    List<String>? noteContents = prefs.getStringList('noteContents');

    if (noteTitles != null && noteContents != null) {
      noteTitles.add(title);
      noteContents.add(content);
    } else {
      noteTitles = [title];
      noteContents = [content];
    }

    await prefs.setStringList('noteTitles', noteTitles);
    await prefs.setStringList('noteContents', noteContents);
  }

  @override
  void initState() {
    super.initState();
    loadSavedNotes();
  }

  Future<void> loadSavedNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? noteTitles = prefs.getStringList('noteTitles');
    List<String>? noteContents = prefs.getStringList('noteContents');

    if (noteTitles != null && noteContents != null) {
      setState(() {
        savedNotes = List.generate(
          noteTitles.length,
          (index) => Note(
            title: noteTitles[index],
            content: noteContents[index],
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 0, 23, 91),
          ),
          child: Column(
            children: [
               Container(
                   width: MediaQuery.of(context).size.width,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(18),
                    bottomRight: Radius.circular(18),
                  ),
                ),
                  padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'iNotes',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 23, 91),
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                          letterSpacing: 2,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                              Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                About(),
                          ),
                        );
                        },
                        icon: Icon(
                          Icons.info,
                          size: 30,
                          color: Color.fromARGB(255, 0, 23, 91),
                        ),
                      ),
                    ],
                  ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        TextFormField(
                          cursorColor: Colors.white,
                          controller: titleController,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Today\'s title',
                            hintText: 'Title',
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a title.';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          style: TextStyle(color: Colors.white),
                          maxLines: 10,
                          cursorColor: Colors.white,
                          controller: contentController,
                          decoration: InputDecoration(
                            labelText: 'What comes in your mind?',
                            hintText: 'Content',
                            labelStyle: TextStyle(
                              color: Colors.white,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.green),
                            ),
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a title.';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.white)),
                            child: Text('Save Note',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 23, 91),
                                )),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                saveNoteButtonPressed();
                              }
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Note {
  final String title;
  final String content;

  Note({required this.title, required this.content});
}
