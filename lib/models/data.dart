
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';


List globalSalawatListEng = ['Allahumma Salli wa sallim ala saidina Muhammed'];
List globalDhikrListEng = ['La Ilaha Illallah','Astagfirullah','SubhanAllah','Alhamdullilah','AllahuAkbar','La hawla wala quwwata ila billah'];
List globalSalawatListArabic = ['اللهم صل وسلم على سيدنا محمد'];
List globalDhikrListArabic = ['لا إله إلا الله','أستغفر الله','سبحان الله','الحمد لله','الله أكبر','لا حول ولا قوة إلا بالله'];

Map personalDhikrMap = {'0':0,'1':0,'2':0,'3':0,'4':0,'5':0};
Map personalSalawatMap = {'0':0};
Map globalDhikrMap , globalSalawatMap;
List globalDhikrCountList = [0,0,0,0,0,0] , globalSalawatCountList = [0];
Map<String,int> updatedMap;

final db = Firestore.instance;

bool tempEngLang = true;
bool userLoggedIn = false;

saveData (String key,int value) async
{
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt(key,value);
}

Future loadAllDhikr() async
{
  final prefs = await SharedPreferences.getInstance();
  for(int i = 0 ; i < personalDhikrMap.length ; i++) {
    if(prefs.getInt(i.toString())==null) prefs.setInt(i.toString(), 0);
    personalDhikrMap[i.toString()] = prefs.getInt(i.toString());
  }
  return true;
}

Future loadUser() async
{
  final prefs = await SharedPreferences.getInstance();
  userLoggedIn = prefs.getBool('loggedIn');
  if(userLoggedIn==null) { prefs.setBool('loggedIn',false); userLoggedIn = false;}
  print(userLoggedIn);
  return userLoggedIn;
}

Future loadAllSalawat() async
{
  final prefs = await SharedPreferences.getInstance();
  if(prefs.getInt('6') == null) prefs.setInt('6', 0);
  personalSalawatMap['0'] = prefs.getInt('6');
  return true;
}

Future loadLang() async
{
  final prefs = await SharedPreferences.getInstance();
  tempEngLang = prefs.getBool('engLang');
  if(tempEngLang == null) { prefs.setBool('engLang', true); tempEngLang = true; }
  return true;
}

void setCounter(String index,{bool dhikr = true,@required int value})
{
  if(value == null) value = 0;
  else if (value >= 1000) value = 999;
  dhikr ? personalDhikrMap[index] = value : personalSalawatMap[index] = value;
  dhikr ? saveData(index, value) : saveData('6', value);
}

void resetPersonalCounters() async
{
  final prefs = await SharedPreferences.getInstance();
  personalDhikrMap = {'0':0,'1':0,'2':0,'3':0,'4':0,'5':0};
  personalSalawatMap = {'0':0};
  for(int i = 0 ; i <= 6 ; i++) prefs.setInt(i.toString(), 0);
}

Future<void> uploadCounters() async {

  await db
      .collection('AllTimeCounters')
      .document('jhAITv2TTCRisDLkqqLX')
      .collection('Dhikr')
      .document('DCubUMtIyB6UReqFmGNf')
      .updateData({
    '0':FieldValue.increment(personalDhikrMap['0']),
    '1':FieldValue.increment(personalDhikrMap['1']),
    '2':FieldValue.increment(personalDhikrMap['2']),
    '3':FieldValue.increment(personalDhikrMap['3']),
    '4':FieldValue.increment(personalDhikrMap['4']),
    '5':FieldValue.increment(personalDhikrMap['5']),
  });

  await db
      .collection('AllTimeCounters')
      .document('jhAITv2TTCRisDLkqqLX')
      .collection('Salawat')
      .document('Pn0yq46N1FjG6XGUQtFa').updateData({
    '0':FieldValue.increment(personalSalawatMap['0'])
  });

  resetPersonalCounters();

}
Future<bool> refreshDhikrGlobalCounters() async
{
  DocumentSnapshot dhikrSnapshot = await db
      .collection('AllTimeCounters')
      .document('jhAITv2TTCRisDLkqqLX')
      .collection('Dhikr')
      .document('DCubUMtIyB6UReqFmGNf')
      .get();

  DocumentSnapshot salawatSnapshot = await db
      .collection('AllTimeCounters')
      .document('jhAITv2TTCRisDLkqqLX')
      .collection('Salawat')
      .document('Pn0yq46N1FjG6XGUQtFa')
      .get();


  globalDhikrMap = dhikrSnapshot.data;
  globalSalawatMap = salawatSnapshot.data;

  globalDhikrCountList = [];
  globalSalawatCountList = [];

  for(String i in globalDhikrMap.keys) {
    globalDhikrCountList.add(globalDhikrMap[i]);
  }

  for(String i in globalSalawatMap.keys) {
    globalSalawatCountList.add(globalSalawatMap[i]);
  }

  return true;

}

void changeLang(bool engLang) async
{
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('engLang',engLang);
  tempEngLang = engLang;
}

List getSalawatList() { return tempEngLang ? globalSalawatListEng : globalSalawatListArabic; }
List getDhikrList() { return tempEngLang ? globalDhikrListEng : globalDhikrListArabic; }

