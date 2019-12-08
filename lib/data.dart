import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'main.dart';
import 'dart:collection';

List dhikr_text = ['SubhanAllah','Alhamdullilah','AllahuAkbar','La Ilaha Illallah'];
List dhikr_text_arabic = [];

List sortedKeys;
List sortedCount = [0,0,0,0];
List sortedDhikrList = ['?','?','?','?'];

Map personalMap = {'0':0,'1':0,'2':0,'3':0};
Map globalMap;
Map<String,int> updatedMap;

final db = Firestore.instance;

void inc_counter(String index)
{
  personalMap[index]++;
}

void read_update_global_counters() async
{
  DocumentSnapshot snapshot = await db
      .collection('AllTimeCounters')
      .document('jhAITv2TTCRisDLkqqLX')
      .get();

  globalMap = snapshot.data;
  updatedMap = {};
  sortedDhikrList = [];
  sortedCount = [];

  for(String i in globalMap.keys)
  {
    updatedMap[i] = globalMap[i] + personalMap[i];
    personalMap[i] = 0;
  }
  sortedKeys = updatedMap.keys.toList(growable:false)
    ..sort((k1, k2) => updatedMap[k2].compareTo(updatedMap[k1]));

  for(String i in sortedKeys)
    {
      sortedCount.add(updatedMap[i]);
      sortedDhikrList.add(dhikr_text[int.parse(i)]);
    }

   db
      .collection('AllTimeCounters')
      .document('jhAITv2TTCRisDLkqqLX')
      .updateData(updatedMap);

}