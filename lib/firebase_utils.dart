import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventplanningapp/models/event.dart';
import 'package:eventplanningapp/models/users_model.dart';

class FirebaseUtils {
  static CollectionReference<Event> getEventCollection(String uId) {
    return getUsersCollection()
        .doc(uId)
        .collection(Event.collectionName)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              Event.fromFireStore(snapshot.data()),
          toFirestore: (value, _) => value.toFirestore(),
        );
  }

  static CollectionReference<UsersModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(UsersModel.collectionName)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              UsersModel.fromFireStore(snapshot.data()),
          toFirestore: (value, _) => value.toFirestore(),
        );
  }

  static Future<void> addEventToFireStore(Event event, String uId) {
    var collection = getEventCollection(uId);
    var docRef = collection.doc();
    event.id = docRef.id;
    return docRef.set(event);
  }

  static Future<void> updateEventCollectiont(
      Event event, bool favstate, String uId) {
    var collection = getEventCollection(uId);
    var docRef = collection.doc(event.id);
    return docRef.update({'isFavorite': favstate});
  }

  static Future<void> editEventCollection(Event event, String uId) {
    return getEventCollection(uId).doc(event.id).update({
      'title': event.title,
      'discription': event.discription,
      'image': event.image,
      'eventName': event.eventName,
      'dateTime': event.dateTime.millisecondsSinceEpoch,
      'time': event.time,
      'selectedCatId': event.selectedCatId,
    });
  }

static  Future<void> deleteEvent(String eventId, String uId) {
    return getEventCollection(uId)
        .doc(eventId)
        .delete();
  }

  static Future<void> addUsersToFireStore(UsersModel usersmodel) {
    return getUsersCollection().doc(usersmodel.id).set(usersmodel);
  }

  static Future<UsersModel?> readUserFromFirestore(String userId) async {
    var quereSnapShot = await getUsersCollection().doc(userId).get();
    return quereSnapShot.data();
  }
}
