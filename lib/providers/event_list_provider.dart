import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventplanningapp/firebase_utils.dart';
import 'package:eventplanningapp/models/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EventListProvider extends ChangeNotifier {
  EventListProvider() {
    getAllEvents();
    getFavoriteEvents();
  }

  List<Event> eventList = [];
  List<Event> eventListFavorite = [];
  int selectedIndex = 0;

  List<String> getEventsNameList(BuildContext context) {
    return [
      AppLocalizations.of(context)!.all,
      AppLocalizations.of(context)!.sport,
      AppLocalizations.of(context)!.birthday,
      AppLocalizations.of(context)!.meeting,
      AppLocalizations.of(context)!.gaming,
      AppLocalizations.of(context)!.workShop,
      AppLocalizations.of(context)!.bookClub,
      AppLocalizations.of(context)!.exhibition,
      AppLocalizations.of(context)!.holiday,
      AppLocalizations.of(context)!.eating,
    ];
  }

  void getAllEvents() async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventCollection()
            .orderBy('dateTime', descending: false)
            .get();
    eventList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();
    notifyListeners();
  }

  void getFavoriteEvents() async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventCollection()
            .orderBy('dateTime', descending: false)
            .where('isFavorite', isEqualTo: true)
            .get();
    eventListFavorite = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    notifyListeners();
  }

  void getFilterEvents(BuildContext context) async {
    QuerySnapshot<Event> querySnapshot =
        await FirebaseUtils.getEventCollection()
            .orderBy('dateTime', descending: false)
            .where('eventName',
                isEqualTo: getEventsNameList(context)[selectedIndex])
            .get();
    eventList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    notifyListeners();
  }

  void updateFavorite(Event event) async {
    FirebaseUtils.updateEventCollectiont(
        event, event.isFavorite ? false : true);
    getAllEvents();
    getFavoriteEvents();
    notifyListeners();
  }

  void changeSelectedIndex(int newSelectedIndex, BuildContext context) {
    selectedIndex = newSelectedIndex;
    if (selectedIndex == 0) {
      getAllEvents();
    } else {
      getFilterEvents(context);
    }
  }
}
