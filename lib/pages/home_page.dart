import 'package:rsMail/helpers/database_helper.dart';
import 'package:rsMail/models/mail_account.dart' as mail_accounts;
import 'package:rsMail/widget/listcard.dart';
import 'package:enough_mail/enough_mail.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = 'rajeshmenon'; //fill manually
  String password = 'Godzilla\$1818'; //fill manually
  String displayName = '';
  List<MimeMessage> _messages = [];
  final dbHelper = DatabaseHelper.instance;
  List<mail_accounts.MailAccount> mailAccounts = [];

  /// High level mail API example
  Future<void> mailExample() async {
    final _email = '$userName@rennovationsoftware.com';
    print('discovering settings for  $_email...');
    final config = await Discover.discover(_email);
    if (config == null) {
      // note that you can also directly create an account when
      // you cannot auto-discover the settings:
      // Compare the [MailAccount.fromManualSettings]
      // and [MailAccount.fromManualSettingsWithAuth]
      // methods for details.
      print('Unable to auto-discover settings for $_email');
      return;
    }

    print('connecting to ${config.displayName}.');
    final account = MailAccount.fromDiscoveredSettings(
        'my account', _email, password, config);
    // setState(() {
    //   displayName = account.userName!;
    // });
    final mailClient = MailClient(account, isLogEnabled: true);
    try {
      await mailClient.connect();
      // print('connected');
      final mailboxes =
          await mailClient.listMailboxesAsTree(createIntermediate: false);
      // print(mailboxes);
      await mailClient.selectInbox();
      final messages = await mailClient.fetchMessages(count: 20);
      setState(() {
        _messages = messages;
      });
      // messages.forEach(printMessage);
      mailClient.eventBus.on<MailLoadEvent>().listen((event) {
        print('New message at ${DateTime.now()}:');
        // printMessage(event.message);
      });
      await mailClient.startPolling();
    } on MailException catch (e) {
      print('High level API failed with $e');
    }
  }

  // void printMessage(MimeMessage message) {
  //   print('from: ${message.from} with subject "${message.decodeSubject()}"');
  //   if (!message.isTextPlainMessage()) {
  //     print(' content-type: ${message.mediaType}');
  //   } else {
  //     final plainText = message.decodeTextPlainPart();
  //     if (plainText != null) {
  //       final lines = plainText.split('\r\n');
  //       for (final line in lines) {
  //         if (line.startsWith('>')) {
  //           // break when quoted text starts
  //           break;
  //         }
  //         print(line);
  //       }
  //     }
  //   }
  // }

  loadMailAccounts() async {
    await dbHelper.getAccountsAll('').then((value) {
      setState(() {
        mailAccounts = value;
      });
    });
  }

  @override
  void initState() {
    mailExample();
    super.initState();
    loadMailAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Card(
        elevation: 4,
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          child: ListView.builder(
              itemBuilder: (context, index) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
                  child: ListCard(
                    title: _messages[index].fromEmail.toString(),
                    subtitle: _messages[index].decodeSubject().toString(),
                    onTap: () {
                      emailDialog(_messages[index]);
                    },
                  ),
                );
              },
              itemCount: _messages.length),
        ),
      ),
    );
  }

  emailDialog(MimeMessage _message) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            margin: const EdgeInsets.all(0.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.close),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.reply_rounded),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.forward_rounded),
                        ),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40.0, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _message.decodeSubject().toString(),
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w600),
                        ),
                        Text(
                          _message.fromEmail.toString(),
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w300),
                        ),
                        const Divider(),
                        Text(_message.decodeTextPlainPart().toString())
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
