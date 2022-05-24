class MailAccount {
  // acnt_id text primary key, acnt_name text, acnt_host text, acnt_port text,
  // acnt_user text, acnt_pass text, acnt_email text
  String accountId;
  String accountName;
  String accountHost;
  String accountPort;
  String accountUser;
  String accountPass;
  String accountEmail;

  MailAccount(this.accountId, this.accountName, this.accountHost,
      this.accountPort, this.accountUser, this.accountPass, this.accountEmail);

  MailAccount.fromJson(Map<String, dynamic> json)
      : accountId = json['acnt_id'],
        accountName = json['acnt_name'],
        accountHost = json['acnt_host'],
        accountPort = json['acnt_port'],
        accountUser = json['acnt_user'],
        accountPass = json['acnt_pass'],
        accountEmail = json['acnt_email'];
}
