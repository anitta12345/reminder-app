
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
//import 'package:firebase_core/firebase_core.dart';

class SetReminder extends StatefulWidget {
  const SetReminder({super.key});

  @override
  State<SetReminder> createState() => _SetReminderState();
}

class _SetReminderState extends State<SetReminder> {
  final days=['Sunday','Monday','Tuesday','wednesday','thursday','Friday','Saturday'];
  String? selectedday;
  final activity=['Wakeup','Go to gym','Breakfast','Meetings','Lunch','Quick Nap','Go to Library','Dinner','go to sleep'];
  String? selectedactivity;
  TimeOfDay? _timeOfDay;
String? _time;
final player=AudioPlayer();
   
  final CollectionReference reminder = FirebaseFirestore.instance.collection('reminder');
  void _showtime(){
    showTimePicker(
      context: context, 
      initialTime: TimeOfDay.now()).then((onValue){
        setState(() {
          _timeOfDay=onValue;
          _time=_timeOfDay!.format(context).toString();
        });
      });    
  }
  
  void adReminder(){
    final data ={'day': selectedday,'time': _time,'activity': selectedactivity};
    reminder.add(data);

   }
   void audio()async{
    String audiopath='orasaadhamadrasgigtamilandacomringtone-41525.mp3';
    await player.play(AssetSource(audiopath));
   }
   audiopause()async{
     //String audiopath='orasaadhamadrasgigtamilandacomringtone-41525.mp3';
    await player.pause();
   }
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 7, 77, 9),
          title: Text('Reminder App',style: TextStyle(color: Colors.white,fontSize: 20,fontFamily: "Nexaregular"),),

        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
               DropdownButtonFormField(
                      decoration: InputDecoration(
                        label: Text('Select Day')
                      ),
                      items: days.map((e)=>DropdownMenuItem(child: Text(e),value: e,)).toList(),
                     onChanged: (val){
                      selectedday=val;
                     }
                     ),
                     SizedBox(height: 16,),
                     Row(
                       children: [MaterialButton(onPressed: (){
                        _showtime();
                       },
                       child: Text('Time',style: TextStyle(color: Colors.white,fontSize: 15,fontFamily: "Nexaregular"),),
                       color: Color.fromARGB(255, 7, 77, 9),
                       ),
                       SizedBox(width: 100,),
                       Text('$_time',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 25,fontFamily: "Nexaregular"),),
                       ]
                     ),
                     SizedBox(height: 16,),
                    DropdownButtonFormField(
                      decoration: InputDecoration(
                        label: Text('Select Activity')
                      ),
                      items: activity.map((e)=>DropdownMenuItem(child: Text(e),value: e,)).toList(),
                     onChanged: (val){
                      selectedactivity=val;
                     }
                     ),
                     SizedBox(height: 16,), 
                     Row(
                      children: [
                        Text('Sound',style:TextStyle(fontSize: 18)),
                         IconButton(
                           color: Color.fromARGB(255, 7, 77, 9),
                          onPressed: (){
                      audio();
                     }, icon:Icon(Icons.music_note) ),
                     IconButton(
                      color: Color.fromARGB(255, 7, 77, 9),
                      onPressed: (){
                      audiopause();
                     }, icon:Icon(Icons.music_off)),
                      ],
                     ),
                     ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(Color.fromARGB(255, 7, 77, 9)),
                    ),
                    onPressed: (){
                      adReminder();
                    Navigator.pop(context);
                      
                    }, child: Text('Set Reminder', 
                   style: TextStyle(color: Colors.white,fontSize: 20),))
            ],
          ),
        ),
    ));
  }
}