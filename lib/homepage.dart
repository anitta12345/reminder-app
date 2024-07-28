
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:firebase_core/firebase_core.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final CollectionReference reminder = FirebaseFirestore.instance.collection('reminder');
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 7, 77, 9),
          title: Text('Reminder App',style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "Nexaregular"),),

        ),
        floatingActionButton: FloatingActionButton(onPressed: (){
          Navigator.pushNamed(context, 'b');
        },
        backgroundColor: Color.fromARGB(255, 7, 77, 9),
        child: Icon(Icons.add,
        color: Colors.white,
        size: 45,
        ),),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: StreamBuilder(stream: reminder.orderBy('time').snapshots(), 
        builder: (context,AsyncSnapshot snapshot){
          if(snapshot.hasData){
            return ListView.builder(itemBuilder: (context, index) {
              final DocumentSnapshot alarmsnap = snapshot.data.docs[index];
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 80,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: CircleAvatar(
                          radius: 30,
                          child: Image.asset('assets/alarm.png',width: 20,height: 20,),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(alarmsnap['day'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          Text(alarmsnap['time'].toString()),
                        ],
                      ),
                     Text(alarmsnap['activity'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    ],
                    
                  ),
                ),
              );
            } ,
            itemCount: snapshot.data.docs.length,);

          }
          return Container();
        }),
      ),
    );
  }
}