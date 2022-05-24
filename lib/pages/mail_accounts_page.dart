import 'package:flutter/material.dart';
import 'package:rsMail/helpers/database_helper.dart';
import 'package:rsMail/models/mail_account.dart';
import 'package:uuid/uuid.dart';

class MailAccountsPage extends StatefulWidget {
  const MailAccountsPage({Key? key}) : super(key: key);

  @override
  State<MailAccountsPage> createState() => _MailAccountsPageState();
}

class _MailAccountsPageState extends State<MailAccountsPage> {
  List<MailAccount> mailAccounts = [];

  final dbHelper = DatabaseHelper.instance;

  bool isNew = true;
  String accountId = "";
  final TextEditingController nameController = TextEditingController();
  final TextEditingController hostController = TextEditingController();
  final TextEditingController portController = TextEditingController();
  final TextEditingController userController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  loadMailAccounts() async {
    await dbHelper.getAccountsAll('').then((value) {
      setState(() {
        mailAccounts = value;
      });
    });
  }

  void addAccount() {
    var newAccount = MailAccount(
        accountId,
        nameController.text,
        hostController.text,
        portController.text,
        userController.text,
        passController.text,
        emailController.text);
    if (isNew) {
      setState(() {
        mailAccounts.add(newAccount);
      });
      dbHelper.insertMailAccount(newAccount);
    } else {
      setState(() {
        int pos = mailAccounts
            .indexWhere((element) => element.accountId == accountId);
        mailAccounts[pos] = newAccount;
        dbHelper.updateMailAccount(newAccount);
      });
    }
    Navigator.pop(context);
  }

  @override
  void initState() {
    loadMailAccounts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mail Accounts'),
      ),
      body: ListView.builder(
          itemCount: mailAccounts.length,
          itemBuilder: (context, index) {
            MailAccount account = mailAccounts[index];
            return ListTile(
              title: Text('${account.accountName} (${account.accountEmail})'),
              subtitle: Text('${account.accountHost}:${account.accountPort}'),
              onTap: () {},
              onLongPress: () {
                setState(() {
                  isNew = false;
                  accountId = account.accountId;
                  nameController.text = account.accountName;
                  hostController.text = account.accountHost;
                  portController.text = account.accountPort;
                  userController.text = account.accountUser;
                  passController.text = account.accountPass;
                  emailController.text = account.accountEmail;
                });
                _showEdit();
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          var uuid = const Uuid();
          setState(() {
            isNew = true;
            accountId = uuid.v1();
            nameController.clear();
            hostController.clear();
            portController.clear();
            userController.clear();
            passController.clear();
            emailController.clear();
          });
          _showEdit();
        },
      ),
    );
  }

  void _showEdit() {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: 'Name',
                  ),
                ),
                TextField(
                  controller: hostController,
                  decoration: const InputDecoration(
                    hintText: 'Hostname',
                  ),
                ),
                TextField(
                  controller: portController,
                  decoration: const InputDecoration(
                    hintText: 'Port',
                  ),
                ),
                TextField(
                  controller: userController,
                  decoration: const InputDecoration(
                    hintText: 'Username',
                  ),
                ),
                TextField(
                  controller: passController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                  ),
                ),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: 'EMail',
                  ),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => addAccount(),
                      child: const Text('Save'),
                    ),
                    OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
