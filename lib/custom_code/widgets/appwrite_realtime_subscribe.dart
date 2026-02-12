// import '../utils/utils.dart';
import 'package:hyperbook/appwrite_interface.dart';
import 'package:appwrite/appwrite.dart' as appwrite;
import 'package:appwrite/appwrite.dart';

import '../../localDB.dart';

Future<void> chapterSubscribe(Function setStateCallback) async {
  return;
 /* final realtime = appwrite.Realtime(client!);
  final String chapterItemPrefix =
      'databases.${databaseRef.path}.collections.${chaptersRef.path}.documents.';
  chapterSubscriptionStringList.clear();
  for (ChaptersRecord c
      in localDB.getWorkingChapterList() *//*#currentCachedChapterList*//*) {
    chapterSubscriptionStringList.add(chapterItemPrefix + c.reference!.path!);
  }
  //>//>//>print('(SSC1)${chapterSubscriptionStringList}');
  chapterChapterSubscription =
      await realtime.subscribe(chapterSubscriptionStringList);
  print(
      '(SSC2)${chapterChapterSubscription!.channels}^^^^${chapterChapterSubscription!.toString()}');
  /////////////////////////////////////////////
  chapterChapterSubscription!.stream.listen((data) async {
    print(
        '(SSC3)${data.events.first}****${data.payload.length}????${data.payload.entries}');
    String firstEvent = data.events.first;
    //>//>//>print('(SSC4)${firstEvent}');
    List<String> firstEventList = firstEvent.split('.');
    if (firstEventList[4] != 'documents') {
      //>//>//>print('(ERROR 1)${firstEvent[4]}');
      return;
    }
    String chapterPath = firstEventList[5];
    for (String x in data.payload.keys) {
      //>//>//>print('(SSC5)${x}:${data.payload[x]}');
    }
    String payloadOp = firstEventList.last;
    //# setCurrentCachedChapterIndex(chapter: DocumentReference(path: chapterPath));
    localDB.setWorkingChapter(DocumentReference(path: chapterPath));
    switch (payloadOp) {
      case 'delete':
        for (int i = 0; i < localDB.getWorkingChapterList().length; i++) {
          //>//>//>print('(SSC7)${localDB.getWorkingChapterList()[i].reference!.path}');
          if (localDB.getWorkingChapterList()[i].reference!.path ==
              data.payload['\$id']) {
            //>//>//>print('(SSC8)${data.payload['title']}');
            localDB.getWorkingChapterList().removeAt(i);
          }
        }
        break;
      case 'update':
        //>//>//>print('(SSC17A)${localDB.getWorkingChapterIndex()}}');
        print(
            '(SSC17AA)${localDB.getWorkingChapterList().length}****${localDB.getWorkingChapterIndex()}>>>>${data.payload}');
        localDB.getWorkingChapterList()[localDB.getWorkingChapterIndex()!] =
            fromDatabaseChapterMap(docMap: data.payload);
        break;
      case 'create':
        //>//>print('(SSC50)${data.payload}');
        ChaptersRecord chapter = fromDatabaseChapterMap(docMap: data.payload);
        localDB.getWorkingChapterList().add(chapter);
        print(
            '(SSC51)${localDB.getWorkingChapterList()}++++${localDB.getWorkingChapterList().last.title}');
        break;
      default:
        //>//>print('(SSC199)${payloadOp}');
    }
    //>//>print('(SSC60)${isDrawingMap}');
    // if (!isDrawingMap) {
    setStateCallback();
    // }
  });*/
}

Future<void> chapterUnsubscribe() async {
  //>//>print('(SSUS2)${chapterChapterSubscription}');
  if (chapterChapterSubscription != null) {
    await chapterChapterSubscription!.close();
    //>//>print('(SSUS2A)${chapterChapterSubscription!.channels}');
  }
}

void readReferenceSubscribe(Function setStateCallback/*, String caller*/) {
  return;
  final realtime = appwrite.Realtime(client!);
  final String readReferenceItemPrefix =
      'databases.${databaseRef.path}.collections.${readReferencesRef.path}.documents.';
  readReferenceSubscriptionStringList.clear();
  for (ReadReferencesRecord c in localDB.getWorkingReadReferenceList()) {
    readReferenceSubscriptionStringList
        .add(readReferenceItemPrefix + c.reference!.path!);
  }
  //>//>print('(SSR1)${readReferenceSubscriptionStringList}');
  // chapterReadReferenceSubscription =
  //    realtime.subscribe(readReferenceSubscriptionStringList);
  // print(
  //     '(SSR2)${chapterReadReferenceSubscription!.channels}^^^^${chapterReadReferenceSubscription!.toString()}');
  /////////////////////////////////////////////
 /* chapterReadReferenceSubscription!.stream.listen((data) async {
    print(
        '(SSR3R)${data.events.first}****${data.payload.length}????${data.payload.entries}');
    String firstEvent = data.events.first;
    //>//>print('(SSR4)${firstEvent}');
    List<String> firstEventList = firstEvent.split('.');
    if (firstEventList[4] != 'documents') {
      //>//>print('(ERROR 1)${firstEvent[4]}');
      return;
    }
    String readReferencePath = firstEventList[5];
    for (String x in data.payload.keys) {
      //>//>print('(SSR5)${x}:${data.payload[x]}');
    }
    String payloadOp = firstEventList.last;

    localDB.setWorkingReadReference(DocumentReference(path: readReferencePath)); //?
    switch (payloadOp) {
      case 'delete':
        for (int i = 0; i < localDB.getWorkingReadReferenceList().length; i++) {
          print(
              '(SSR7)${localDB.getWorkingReadReferenceList()[i].reference!.path}');
          if (localDB.getWorkingReadReferenceList()[i].reference!.path ==
              data.payload['\$id']) {
            //>//>print('(SSR8)${data.payload['title']}');
            localDB.getWorkingReadReferenceList().removeAt(i);
          }
        }
        break;
      case 'update':
        // //>//>print('(SSR17A)${currentCachedReadReferenceIndex}++++${caller}&&&&${data.payload}');
        //>//>print('(SSR17AA)${localDB.getWorkingReadReferenceList().length}');
        localDB.getWorkingReadReferenceList()[localDB.getReadReferenceIndex(
                DocumentReference(path: readReferencePath))!] =
            fromDatabaseReadReferenceMap(docMap: data.payload);
        break;
      case 'create':
        //>//>print('(SSR50)${data.payload}');
        ReadReferencesRecord readReference =
            fromDatabaseReadReferenceMap(docMap: data.payload);
        localDB.getWorkingReadReferenceList().add(readReference);
        print(
            '(SSR51)${localDB.getWorkingReadReferenceList()}++++${localDB.getWorkingReadReferenceList().last.reference!.path}');
        break;
      default:
        //>//>print('(SSR199)${payloadOp}');
    }
    // if (!isDrawingMap) {
    setStateCallback();
    // }
  });
*/}

Future<void> readReferenceUnsubscribe() async {
  //>//>print('(SSUS1)${chapterReadReferenceSubscription}');
  if (chapterReadReferenceSubscription != null) {
    await chapterReadReferenceSubscription!.close();
    //>//>print('(SSUS1A)${chapterReadReferenceSubscription}');
  }
}

void hyperbookDisplaySubscribe(Function setStateCallBack) {
  return;
  final realtime = appwrite.Realtime(client!);

  List<String> subscriptionStringList = [
    'databases.${databaseRef.path}.collections.${hyperbooksRef.path}.documents'
  ];
  // for(CachedHyperbook c in cachedHyperbookList){
  //   subscriptionStringList.add('databases.${databaseRef.path}.collections.${hyperbooksRef.path}.documents.' + c.hyperbook!.reference!.path!);
  // }
  //>//>print('(SSS1)${subscriptionStringList}');
  hyperbookDisplaySubscription = realtime.subscribe(subscriptionStringList);
  print(
      '(SSS2)${hyperbooksRef.path}++++${hyperbookDisplaySubscription!.channels}^^^^${hyperbookDisplaySubscription!.toString()}');
  /////////////////////////////////////////////
  hyperbookDisplaySubscription!.stream.listen((data) async {
    print(
        '(SSS3)${data.events.length}****${data.payload.length}????${data.payload.entries}');
    // for (String x in data.events) {
    //   //>//>print('(NS4)${x}');
    // }
    String firstEvent = data.events.first;
    //>//>print('(SSS4)${firstEvent}');
    for (String x in data.payload.keys) {
      //>//>print('(SSS5)${x}:${data.payload[x]}');
    }
    List<String> firstEventList = firstEvent.split('.');
    String payloadOp = firstEventList.last;
    switch (payloadOp) {
      case 'delete':
        for (int i = 0; i < localDB.hyperbooklocalDBList.length; i++) {
          print(
              '(SSS7)${localDB.hyperbooklocalDBList[i].hyperbook!.reference!.path}');
          if (localDB.hyperbooklocalDBList[i].hyperbook!.reference!.path ==
              data.payload['\$id']) {
            //>//>print('(SSS8)${data.payload['title']}');
            localDB.hyperbooklocalDBList.removeAt(i);
          }
        }
        break;
      case 'update':
        for (var c in localDB.hyperbooklocalDBList) {
          //>//>print('(SSS7A)${c.hyperbook!.reference!.path}');
          if (c.hyperbook!.reference!.path == data.payload['\$id']) {
            //>//>print('(SSS18)${data.payload['title']}');
            c.hyperbook = fromDatabaseHyperbookMap(docMap: data.payload);
          }
        }
        break;
      case 'create':
        //>//>print('(SSS50)${data.payload}');
        HyperbooksRecord hyperbook =
            fromDatabaseHyperbookMap(docMap: data.payload);
        HyperbookLocalDB cachedH = HyperbookLocalDB(
          hyperbook: hyperbook, /* null,*/ /*# [], []*/
        );
        // localDB.hyperbooklocalDBList.add(cachedH);
        print(
            '(SSS51)${localDB.hyperbooklocalDBList}++++${localDB.hyperbooklocalDBList.last.hyperbook!.title}');
        break;
      default:
        //>//>print('(SS199A)${payloadOp}');
    }
    if ((setStateCallBack != null) && (payloadOp != 'delete')) {
      setStateCallBack!();
    }
  });
}

Future<void> hyperbookDisplayUnsubscribe() async {
  //>//>print('(SSX1)${hyperbookDisplaySubscription}');
  if (hyperbookDisplaySubscription != null) {
    await hyperbookDisplaySubscription!.close();
  }
}

void hyperbookEditSubscribe(Function setStateCallBack) {
  return;
  final realtime = appwrite.Realtime(client!);

  //>//>print('(SSNCW1)${localDB.workingHyperbookIndex}');
  //#CachedHyperbook c = cachedHyperbookList[currentCachedHyperbookIndex!];
  List<String> subscriptionStringList = [];
  /*  [
    'databases.${databaseRef.path}.collections.${hyperbooksRef.path}.documents.' +
        c.hyperbook!.reference!.path!
  ];*/
  for (int i = 0; i < localDB.hyperbooklocalDBList.length; i++) {
    for (ConnectedUsersRecord cu
        in localDB.hyperbooklocalDBList[i].connectedUserList) {
      //>//>print('(CH1)${i}+++${localDB.hyperbooklocalDBList.length}****${localDB.hyperbooklocalDBList[i].connectedUserList.length}££££${cu}');
      //>//>print('(CH2)${ cu.reference}');
      //>//>print('(CH3)${ cu.reference!.path}');
      subscriptionStringList.add(
          'databases.${databaseRef.path}.collections.${connectedUsersRef.path}.documents.' +
              cu.reference!.path!);
    }

    //>//>print('(SSSE1)${subscriptionStringList}');
    hyperbookEditSubscription = realtime.subscribe(subscriptionStringList);
    //print(
    //   '(NSE2)${hyperbooksRef.path}++++${hyperbookSubscription!.channels}^^^^${hyperbookSubscription!.toString()}');
/////////////////////////////////////////////
    hyperbookEditSubscription!.stream.listen((data) async {
      print(
          '(SSSE3)${data.events.length}****${data.payload.length}????${data.payload.entries}');
      // for (String x in data.events) {
      //   //>//>print('(NS4)${x}');
      // }
      String firstEvent = data.events.first;
      //>//>print('(SSSE4)${firstEvent}');
      for (String x in data.payload.keys) {
        //>//>print('(SSS5)${x}:${data.payload[x]}');
      }
      List<String> firstEventList = firstEvent.split('.');
      String payloadOp = firstEventList.last;
      switch (payloadOp) {
        case 'delete':
          for (int i = 0; i < localDB.hyperbooklocalDBList.length; i++) {
            print(
                '(SSSE7)${localDB.hyperbooklocalDBList[i].hyperbook!.reference!.path}');
            if (localDB.hyperbooklocalDBList[i].connectedUserList != null) {
              for (int j = 0;
                  j < localDB.hyperbooklocalDBList[i].connectedUserList.length;
                  j++) {
                if (localDB.hyperbooklocalDBList[i].connectedUserList[j]
                        .reference!.path ==
                    data.payload['\$id']) {
                  //>//>print('(SSSE8)${data.payload['displayName']}');
                  localDB.hyperbooklocalDBList[i].connectedUserList.removeAt(j);
                  break;
                }
              }
            }
          }
          break;
        case 'update':
          for (int i = 0; i < localDB.hyperbooklocalDBList.length; i++) {
            print(
                '(SSSE7A)${localDB.hyperbooklocalDBList[i].hyperbook!.reference!.path}');
            if (localDB.hyperbooklocalDBList[i].connectedUserList != null) {
              for (int j = 0;
                  j < localDB.hyperbooklocalDBList[i].connectedUserList.length;
                  j++) {
                if (localDB.hyperbooklocalDBList[i].connectedUserList[j]
                        .reference!.path ==
                    data.payload['\$id']) {
                  //>//>print('(SSSE8A)${data.payload['displayName']}');
                  localDB.hyperbooklocalDBList[i].connectedUserList[j] =
                      fromDatabaseConnectedUserMap(docMap: data.payload);
                  break;
                }
              }
            }
          }
          break;

        case 'create':
          //>//>print('(SSSE50)${data.payload}');
          for (int i = 0; i < localDB.hyperbooklocalDBList.length; i++) {
            if (data.payload['parent'] ==
                localDB.hyperbooklocalDBList[i].hyperbook!.reference!.path) {
              ConnectedUsersRecord newConnectedUser =
                  fromDatabaseConnectedUserMap(docMap: data.payload);
              localDB.hyperbooklocalDBList[i].connectedUserList
                  .add(newConnectedUser);
              break;
            }
          }
          break;
        default:
          //>//>print('(SS19C)${payloadOp}');
      }
      //>//>print('(SSSE21)${setStateCallBack}');
      if (setStateCallBack != null) {
        setStateCallBack!();
      }
    });
  }
}

Future<void> hyperbookEditUnsubscribe() async {
  //>//>print('(SSX2)${hyperbookDisplaySubscription}');
  if (hyperbookEditSubscription != null) {
    await hyperbookEditSubscription!.close();
  }
}
