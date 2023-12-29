import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'about.dart';
import 'notedetails.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Note> savedNotes = [];

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
    return SingleChildScrollView(
         keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
           physics: ScrollPhysics(),
      child: Container(
         color: Color.fromARGB(255, 0, 23, 91),
        child: Column(
          children: [
             Container(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            height: 70,
                   decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
              ),
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
                            builder: (context) => About(),
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
         
              Container(
             height: MediaQuery.sizeOf(context).height,
             width: MediaQuery.sizeOf(context).width,
             padding: EdgeInsets.fromLTRB(0, 0, 0, 160),
             margin: EdgeInsets.all(5),
             child: GridView.builder(
                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                     crossAxisCount: 2,
                     crossAxisSpacing: 10,
                     mainAxisSpacing: 10,
                   ),
                   itemCount: savedNotes.length,
                   itemBuilder: (context, index) {
                     return Container(
                       
                       decoration: BoxDecoration(
                           color:Colors.white,
                           borderRadius: BorderRadius.all(Radius.circular(8)),
                         ),
                       child: InkWell(
                         onTap: () {
                           Navigator.push(
                             context,
                             MaterialPageRoute(
                               builder: (context) => NoteDetails(note: savedNotes[index]),
                             ),
                           );
                         },
                         child: Column(
                           children: [
                             Container(
                               margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                           Text(
                                             'Note ${index + 1}',
                                             style: TextStyle(
                                               fontWeight: FontWeight.bold,
                                             ),
                                           ),
                                           PopupMenuButton<String>(
                                             tooltip: 'Changes',
                                             onSelected: (value) {
                                               if (value == 'edit') {
                                                 editNoteButtonPressed(index);
                                               } else if (value == 'delete') {
                                                 deleteNoteButtonPressed(index);
                                               }
                                             },
                                             itemBuilder: (BuildContext context) => [
                                               PopupMenuItem<String>(
                                                 value: 'edit',
                                                 child: Text('Edit'),
                                               ),
                                               PopupMenuItem<String>(
                                                 value: 'delete',
                                                 child: Text('Delete'),
                                               ),
                                             ],
                                           ),
                                 ],
                               ),
                             ),
                            
                             Container(
                               margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                               child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Divider(thickness: 1),
                                   
                                   Text(
                                     savedNotes[index].title,
                                     overflow: TextOverflow.ellipsis,
                                     maxLines: 1,
                                     style: TextStyle(
                                               fontSize: 16,
                                               color: Color.fromARGB(255, 0, 23, 91),
                                     ),
                                   ),
                                   SizedBox(height: 8),
                                   Text(
                                     savedNotes[index].content,
                                     maxLines: 5,
                                     overflow: TextOverflow.fade,
                                     style: TextStyle(fontSize: 12),
                                     textAlign: TextAlign.center,
                                   ),
                                 ],
                               ),
                             ),
             
                           ],
                         ),
                       ),
                     );
                   },
                 ),
              ),
        
            
             
          ],
        ),
      ),
    );
  }

  void editNoteButtonPressed(int index) {
    String title = savedNotes[index].title;
    String content = savedNotes[index].content;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController titleController =
            TextEditingController(text: title);
        TextEditingController contentController =
            TextEditingController(text: content);

        return AlertDialog(
          title: Text('Edit Note',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 23, 91),
              )),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                cursorColor: Color.fromARGB(255, 0, 23, 91),
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Today\'s title',
                  hintText: 'Title',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 0, 23, 91),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 0, 23, 91)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 0, 23, 91),
                    ),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                cursorColor: Color.fromARGB(255, 0, 23, 91),
                controller: contentController,
                maxLines: 8,
                decoration: InputDecoration(
                  labelText: 'Describe Your Thoughts',
                  hintText: 'Thoughts',
                  labelStyle: TextStyle(
                    color: Color.fromARGB(255, 0, 23, 91),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 0, 23, 91)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(
                Color.fromARGB(255, 0, 23, 91),
              )),
              onPressed: () {
                String updatedTitle = titleController.text;
                String updatedContent = contentController.text;

                updateNoteInStorage(index, updatedTitle, updatedContent);
                Navigator.pop(context);
              },
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  void updateNoteInStorage(
      int index, String updatedTitle, String updatedContent) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? noteTitles = prefs.getStringList('noteTitles');
    List<String>? noteContents = prefs.getStringList('noteContents');

    if (noteTitles != null && noteContents != null) {
      noteTitles[index] = updatedTitle;
      noteContents[index] = updatedContent;

      await prefs.setStringList('noteTitles', noteTitles);
      await prefs.setStringList('noteContents', noteContents);

      setState(() {
        savedNotes[index] = Note(
          title: updatedTitle,
          content: updatedContent,
        );
      });
    }
  }

  void deleteNoteButtonPressed(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? noteTitles = prefs.getStringList('noteTitles');
    List<String>? noteContents = prefs.getStringList('noteContents');

    if (noteTitles != null && noteContents != null) {
      noteTitles.removeAt(index);
      noteContents.removeAt(index);

      await prefs.setStringList('noteTitles', noteTitles);
      await prefs.setStringList('noteContents', noteContents);

      setState(() {
        savedNotes.removeAt(index);
      });
    }
  }
}

class Note {
  final String title;
  final String content;

  Note({required this.title, required this.content});
}
