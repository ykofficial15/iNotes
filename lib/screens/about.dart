import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
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
                child: Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
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
                        onPressed: () {},
                        icon: Icon(
                          Icons.person,
                          size: 30,
                          color: Color.fromARGB(255, 0, 23, 91),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30),
              Container(
             
                child: CircleAvatar(
                  radius: 80, // Set the desired radius of the avatar
                  backgroundImage:
                      AssetImage('assets/yogesh.jpg'), // Use the asset path
                ),
              ),
                  SizedBox(height: 10),
              Container(
                child:Text('YOGESH KUMAWAT',style:TextStyle(color:Colors.blue,fontSize:25,fontWeight: FontWeight.bold),),
              ),
              Container(
                child:Text('[ Android Developer ]',style:TextStyle(color:Colors.white,fontSize:15,fontWeight: FontWeight.bold),),
              ),
                        SizedBox(height: 20),
                Container(
                    padding: EdgeInsets.all(15),
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(91, 33, 149, 243),
                ),
                child:Text('ABOUT ME:  I\'m a skilled Android developer with a focus on Flutter. With a passion for creating elegant and performant mobile applications.\nAlso i\'m well-versed in integrating various APIs and services, such as Firebase, RESTful APIs, and third-party libraries, to enhance app functionality and user experience. I had experience in building custom UI components, animations, and transitions to create visually appealing and interactive apps. ',style:TextStyle(color:Colors.white,fontSize:15,),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
