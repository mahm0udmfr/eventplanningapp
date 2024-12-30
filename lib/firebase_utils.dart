import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventplanningapp/models/event.dart';

class FirebaseUtils {
  static CollectionReference<Event> getEventCollection() {
    return FirebaseFirestore.instance
        .collection(Event.collectionName)
        .withConverter(
          fromFirestore: (snapshot, options) =>
              Event.fromFireStore(snapshot.data()),
          toFirestore: (value, _) => value.toFirestore(),
        );
  }

  static Future<void> addEventToFireStore(Event event) {
    var collection = getEventCollection();
    var docRef = collection.doc();
    event.id = docRef.id;
    return docRef.set(event);
  }

  static Future<void> updateEventCollectiont(
      Event event, bool favstate) {
    var collection = getEventCollection();
    var docRef = collection.doc(event.id);
    return docRef.update({'isFavorite': favstate});
  }
}
