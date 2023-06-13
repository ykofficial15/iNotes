import 'package:flutter/material.dart';
import 'home.dart';

class NoteDetails extends StatelessWidget {
  final Note note;
  NoteDetails({required this.note});
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
            mainAxisAlignment: MainAxisAlignment.start,
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
                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: Text(
                    'iNotes',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 23, 91),
                      fontWeight: FontWeight.bold,
                      fontSize: 23,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(91, 33, 149, 243),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'TITLE: ${note.title}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Divider(
                        thickness: 1,
                        color: Colors.white,
                        endIndent: 8,
                        indent: 8),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'CONTENT: ${note.content}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
