// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:convert';

import 'package:beatiful_ui/src/features/tutor/presentation/tutor_home_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../common/app_sizes.dart';
import '../models/chat.dart';
import '../models/custom_chat_request.dart';
import '../models/custom_chat_response.dart';

class AICHATBOT extends StatefulWidget {
  const AICHATBOT({super.key});

  @override
  State<AICHATBOT> createState() => _AICHATBOTState();
}

const int textLimit = 2000;

class Template {
  final String id;
  final String title;
  final String message;

  Template(this.id, this.title, this.message);
}

abstract class ChatRepository {
  Future<CustomChatResponse?> send({
    required BuildContext context,
    required CustomChatRequest chat,
  });
}

class ChatWidget extends StatelessWidget {
  final bool isMe;
  final String text;

  const ChatWidget({
    Key? key,
    required this.isMe,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(
        color: Colors.black,
        fontSize: 16,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: SizedBox(
              child: text.isNotEmpty
                  ? Text(text.replaceFirst('\n\n', ''))
                  : Text('waiting'.tr),
            ),
          ),
          if (text.isNotEmpty) ...{
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: const Icon(Icons.copy),
                  onTap: () {
                    // FlutterClipboard
                    // FlutterClipboard.copy(text).then((value) => {
                    //       Get.snackbar(
                    //         'copied'.tr,
                    //         'success'.tr,
                    //         snackPosition: SnackPosition.BOTTOM,
                    //         colorText: Colors.green,
                    //         margin: const EdgeInsets.all(10),
                    //         borderRadius: 10,
                    //         duration: const Duration(seconds: 2),
                    //       )
                    //     });
                  },
                ),
                // gapH4,
                // GestureDetector(
                //   child: const Icon(Icons.reply),
                //   onTap: () {},
                // )
              ],
            )
          }
        ],
      ),
    );
  }
}

final dio = Dio(BaseOptions(
  baseUrl: 'https://bardgpt.azurewebsites.net/',
  contentType: 'application/json',
));

class RemoteException implements Exception {
  DioError dioError;

  RemoteException({required this.dioError});
}

// Represent exceptions from Cache.
class LocalException implements Exception {
  String error;

  LocalException(this.error);
}

class RouteException implements Exception {
  final String message;
  RouteException(this.message);
}

class ChatRepositoryImpl implements ChatRepository {
  @override
  Future<CustomChatResponse?> send(
      {required BuildContext context, required CustomChatRequest chat}) async {
    try {
      final response = await dio.post('/continue-chat', data: chat);
      Map<String, dynamic> mp = jsonDecode(response.toString());
      return CustomChatResponse.fromJson(mp);
    } on RemoteException {}
    return null;
  }
}

class _AICHATBOTState extends State<AICHATBOT> {
  String messagePrompt = '';
  List<Chat> chatList = [];
  ChatRepository chatRepository = ChatRepositoryImpl();
  bool isPlayingSound = false;
  bool _isListening = false;
  final ScrollController _scrollController = ScrollController();
  String? _currentLocaleId;
  String conversationId = '${DateTime.now().millisecondsSinceEpoch}';
  String parentMessageId = '';
  int soundPlayingIndex = -1;
  final Map<int, bool> soundPlayingMap = {};
  TextEditingController messageController = TextEditingController();
  bool hasOpenTemplate = false;
  int chatLimit = 100;

  @override
  void initState() {
    super.initState();
    initPrefs();
    _createRewardedAd();

    soundPlayingMap[soundPlayingIndex] = false;
  }

  @override
  void dispose() {
    _scrollController.dispose();
    messageController.dispose();

    super.dispose();
  }

  void initPrefs() {
    setState(() {});
  }

  void _createRewardedAd() {}

  void _showRewardAd() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(getAvatar(null)),
            ),
            const SizedBox(width: 10),
            Text('Tutor chat bot'.tr),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // _topChat(),
            Expanded(child: _bodyChat()),
            _formChat(),
          ],
        ),
      ),
    );
  }

  Widget _bodyChat() {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        width: double.infinity,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: chatList.length,
          itemBuilder: (context, index) => _itemChat(
            chat: chatList[index].chat,
            message: chatList[index].msg,
            id: chatList[index].id,
            index: index,
          ),
          controller: _scrollController,
        ),
      ),
    );
  }

  // need to refactor this code. Cuz it's fucking mess
  _itemChat(
      {required int chat,
      required String message,
      String? id,
      required int index}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: chat == 0
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (message.length > 10) ...{const Spacer()},
                Flexible(
                  flex: 3,
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                        color: chat == 0
                            ? const Color(0xFF5F80F8)
                            : const Color(0xFFEBF5FF),
                        borderRadius: chat == 0
                            ? const BorderRadius.all(Radius.circular(20))
                            : const BorderRadius.all(Radius.circular(20))),
                    child: SelectableText(message,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        )),
                  ),
                ),
              ],
            )
          : Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        radius: 15,
                        backgroundImage: NetworkImage(getAvatar(null)),
                      ),
                      Flexible(
                        child: Container(
                          margin: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          decoration: const BoxDecoration(
                              color: Color(0xFFEBF5FF),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: ChatWidget(isMe: false, text: message)),
                        ),
                      ),
                    ],
                  ),
                ),
                if (message.isNotEmpty && !_isListening) ...{
                  GestureDetector(
                    onTap: () async {
                      // caused this is asynchronous to play sound, sometimes it doesn't play sound
                    },
                    child: CircleAvatar(
                      radius: 20,
                      child: soundPlayingMap[index] == false
                          ? const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                            )
                          : const Icon(
                              Icons.pause,
                              color: Colors.white,
                            ),
                    ),
                  )
                } else ...{
                  const SizedBox()
                },
              ],
            ),
    );
  }

  Widget _formChat() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsetsDirectional.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              gapW12,
              Expanded(
                child: TextField(
                  buildCounter: (BuildContext context,
                          {required int currentLength,
                          required bool isFocused,
                          required int? maxLength}) =>
                      null,
                  // display scroll on keyboard on the right
                  autocorrect: true,
                  autofocus: true,
                  maxLength: textLimit,
                  // focus on the textfield
                  onChanged: (value) {
                    setState(
                      () {
                        if (value.length == textLimit) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: const Duration(milliseconds: 500),
                              content: Text(
                                'longMessage'.tr,
                                style: const TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                    );
                  },
                  // croll if the textfield is overflow
                  maxLines: 4,
                  minLines: 1,
                  controller: messageController,
                  decoration: InputDecoration(
                    hintText: !_isListening ? 'Aa'.tr : '',
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 2,
                      ),
                    ),
                    prefixIcon: _isListening && messageController.text.isEmpty
                        ? Container(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.1),
                            child: const SizedBox(),
                          )
                        : null,
                    filled: true,
                    fillColor: Colors.blueGrey.shade50,
                    contentPadding: const EdgeInsets.all(15),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey.shade50),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey.shade50),
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
              //  messageController.text.isNotEmpty

              // const Expanded(child: FlowMenu()),
              // adding animation to the send button

              if (chatLimit <= 0) ...{
                Center(
                  child: IconButton(
                    onPressed: () {
                      _showRewardAd();
                    },
                    icon: const Icon(
                      Icons.whatshot_outlined,
                      color: Colors.blue,
                      size: 35,
                    ),
                  ),
                )
              },

              if (chatLimit > 0 &&
                  (messageController.text.isNotEmpty || _isListening))
                InkWell(
                  child: Column(
                    children: [
                      if (messageController.text.isNotEmpty ||
                          _isListening) ...{
                        InkWell(
                          onTap: () {
                            messageController.clear();
                            setState(() {
                              _isListening = false;
                            });
                          },
                          child: Container(
                            width: 50,
                            height: 50,
                            margin: const EdgeInsets.only(bottom: 25),
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                            ),
                            child: const Icon(
                              Icons.clear,
                              color: Colors.black,
                              weight: 5,
                            ),
                          ),
                        )
                      },
                      InkWell(
                        onTap: (() async {
                          // Logger().e('chatLimit $chatLimit');
                          if (chatLimit <= 1) {
                            Get.snackbar(
                                'chat_limit_title'.tr, 'chat_limit_content'.tr,
                                snackPosition: SnackPosition.BOTTOM,
                                duration: 5.seconds);
                          }
                          if (chatLimit <= 0) {
                            return;
                          }
                          messagePrompt = messageController.text.toString();
                          _isListening = false;
                          if (messagePrompt.isEmpty) {
                            return;
                          }
                          chatList.add(Chat(
                              msg: messagePrompt,
                              chat: 0,
                              // timestemp for file
                              id: '${DateTime.now().millisecondsSinceEpoch}'));

                          chatList.add(Chat(
                              msg: '',
                              chat: 1,
                              id: '${DateTime.now().millisecondsSinceEpoch}'));

                          int n = chatList.length;

                          soundPlayingMap[n - 1] = false;
                          soundPlayingMap[n - 2] = false;

                          setState(() {
                            messageController.clear();
                            _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeOut,
                            );
                          });

                          // set to chatList item at index n-1
                          try {
                            final reponse = await chatRepository.send(
                                context: context,
                                chat: CustomChatRequest(
                                    message: messagePrompt,
                                    conversationId: conversationId,
                                    parentMessageId: parentMessageId));

                            conversationId = reponse?.conversationId ?? "";
                            parentMessageId = reponse?.parentMessageId ?? "";

                            final result = Chat(
                                msg: reponse?.text ?? 'service_err'.tr,
                                chat: 1,
                                id: parentMessageId);
                            chatList[n - 1] = result;
                          } catch (e) {
                            chatList[n - 1] = Chat(
                                msg: 'service_err'.tr,
                                chat: 1,
                                id: parentMessageId);
                          }
                          if (mounted) {
                            setState(() {
                              messageController.clear();
                              _scrollController.animateTo(
                                _scrollController.position.maxScrollExtent,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeOut,
                              );
                            });
                          }

                          chatLimit -= 1;
                          if (mounted) {
                            setState(() {});
                          }
                        }),
                        child: Container(
                          width: 50,
                          height: 50,
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          margin: const EdgeInsets.only(left: 5, right: 5),
                          child: const Icon(
                            Icons.send_rounded,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ],
          ),
          if (hasOpenTemplate) ...{
            Container(
              height: 100,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'template'.tr,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // icon +
                      GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Icons.add,
                          size: 30,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          }
        ],
      ),
    );
  }
}
