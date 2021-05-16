import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:tenicos_nextline/Technician/Assignment/model_assignment.dart';
import 'package:tenicos_nextline/Tickets/model/modal_message.dart';
import 'package:tenicos_nextline/Tickets/model/model_ticket.dart';
import '../repository_tickets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;

class BlocTickets implements Bloc {
  final RepositoryTickets repository = RepositoryTickets();
  DatabaseReference _chatsRef;
  FirebaseDatabase database;
  FirebaseStorage storage;
  Map<int, ChatModel> chats;

  final StreamController<dynamic> _streamController =
      StreamController<dynamic>.broadcast();

  Sink<dynamic> get ticketEvents => _streamController.sink;

  Future<List<Ticket>> getDataTickets() async {
    return await repository.getDataTicketsAPI();
  }

  Future<ChatModel> getChat(int ticketId) async {
    await DotEnv.load();
    DatabaseReference chatRef = _chatsRef.child(ticketId.toString() + ' - ' + DotEnv.env['ENV']);
    DataSnapshot chatData = await chatRef.orderByChild('order').once();

    chats[ticketId] = ChatModel(chatRef, chatData);
    return chats[ticketId];
  }


  Future<List<Ticket>> getAssignedTickets() async {
    return await repository.getAssignedTicketsAPI();
  }

  Future<Ticket> getDetailsAssignedTickets(id) async {
    return await repository.getDetailsAssignedTicketsAPI(id);
  }

  Future finishAssignment(Assignment assignment) async {
    return await repository.finishAssignmentAPI(assignment);
  }

  BlocTickets() {
    database = FirebaseDatabase();
    storage = FirebaseStorage();
    _chatsRef = database.reference().child('chatsCollections');
    database.setPersistenceEnabled(true);
    chats = new Map<int, ChatModel>();
    database.setPersistenceCacheSizeBytes(10000000);
  }

  @override
  void dispose() {
    _streamController.close();
    chats.forEach((key, value) {
      value.dispose();
    });
  }
}

class ChatModel {
  StreamController<ModelMessage> controller;
  StreamController<ModelMessage> sink;
  StreamSubscription<Event> onChildAdded;
  Map<String, ModelMessage> messages;

  ChatModel(DatabaseReference chatRef, DataSnapshot chatData) {
    Map<String, ModelMessage> chatDataMap = Map.from(chatData.value)
        .map((key, value) => MapEntry(key, ModelMessage.fromSnapshot(value)));

    messages = chatDataMap;
    controller = StreamController<ModelMessage>.broadcast();
    onChildAdded = chatRef.onChildAdded.listen((Event event) {
      ModelMessage newMessage = ModelMessage.fromSnapshot(event.snapshot.value);
      controller.add(newMessage);
      messages.addEntries([new MapEntry(event.snapshot.key, newMessage)]);
    });
  }

  void dispose() {
    onChildAdded.cancel();
    sink.close();
  }
}
