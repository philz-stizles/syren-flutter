import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:syren/models/models.dart';
import 'package:syren/templates/email/signup_otp.dart';

class EmailService extends GetxService {
  late SmtpServer smtpServer;

  Future<EmailService> init() async {
    // Note that using a username and password for gmail only works if
    // you have two-factor authentication enabled and created an App password.
    // Search for "gmail app password 2fa. The alternative is to use oauth.
    // smtpServer =
    //   gmail(dotenv.get('GOOGLE_SMTP_USER'), dotenv.get('GOOGLE_SMTP_PASS'));
    smtpServer = SmtpServer(dotenv.get('SMTP_HOST'),
        username: dotenv.get('SMTP_USER'),
        password: dotenv.get('SMTP_PASS'),
        port: int.parse(dotenv.get('SMTP_PORT')));
    debugPrint('Init Email Service');
    return this;
  }

  Future sendMail(EmailModel mail, String? template) async {
    // Create message.
    final message = Message()
      ..from = const Address('philzstizles@gmail.com', 'Your name')
      ..recipients.add(mail.to)
      // ..ccRecipients.addAll(mail.ccRecipients)
      // ..bccRecipients.add(Address(mail.bccRecipient))
      ..subject =
          mail.subject // 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
      ..text = mail.message
      ..html = template;

    try {
      final sendReport = await send(message, smtpServer);
      debugPrint('Message sent: $sendReport');
    } on MailerException catch (e) {
      debugPrint('Message not sent.');
      for (var p in e.problems) {
        debugPrint('Problem: ${p.code}: ${p.msg}');
      }
    }

    // Create an smtp client that will persist the connection.
    var connection = PersistentConnection(smtpServer);

    // Send the message.
    await connection.send(message);

    // close the connection.
    await connection.close();
  }

//   // Let's send another message using a slightly different syntax:
//   //
//   // Addresses without a name part can be set directly.
//   // For instance `..recipients.add('destination@example.com')`
//   // If you want to display a name part you have to create an
//   // Address object: `new Address('destination@example.com', 'Display name part')`
//   // Creating and adding an Address object without a name part
//   // `new Address('destination@example.com')` is equivalent to
//   // adding the mail address as `String`.
//   final equivalentMessage = Message()
//     ..from = Address(username, 'Your name 😀')
//     ..recipients.add(Address('destination@example.com'))
//     ..ccRecipients.addAll([Address('destCc1@example.com'), 'destCc2@example.com'])
//     ..bccRecipients.add('bccAddress@example.com')
//     ..subject = 'Test Dart Mailer library :: 😀 :: ${DateTime.now()}'
//     ..text = 'This is the plain text.\nThis is line 2 of the text part.'
//     ..html = '<h1>Test</h1>\n<p>Hey! Here is some HTML content</p><img src="cid:myimg@3.141"/>'
//     ..attachments = [
//       FileAttachment(File('exploits_of_a_mom.png'))
//         ..location = Location.inline
//         ..cid = '<myimg@3.141>'
//     ];

//   final sendReport2 = await send(equivalentMessage, smtpServer);

}
