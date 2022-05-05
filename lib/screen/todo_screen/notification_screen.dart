import 'package:flutter/material.dart';

import '../../theme.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key, required this.payload}) : super(key: key);
  final String payload;

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late String payload;
  @override
  void initState() {
    payload = widget.payload;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(
          payload.toString().split('|')[0],
          style: const TextStyle(
            color: darkGreyClr,
          ),
        ),

        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: darkGreyClr,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Text(AppLocalizations.of(context)!.welcome_to_back,
                    style:const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: darkGreyClr)),

                const SizedBox(height: 10),
                Text(AppLocalizations.of(context)!.you_have_a_reminder,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                        color: darkGreyClr)),
              ],
            ),
            Expanded(
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                margin: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                  color: primaryClr,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      rowNotification(AppLocalizations.of(context)!.title, Icons.text_format),
                      const SizedBox(height: 20),
                      Text(
                        payload.toString().split('|')[0],
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      rowNotification(AppLocalizations.of(context)!.note, Icons.description),
                      const SizedBox(height: 20),
                      Text(
                        payload.toString().split('|')[1],
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      rowNotification(AppLocalizations.of(context)!.time, Icons.calendar_today_sharp),
                      const SizedBox(height: 20),
                      Text(
                        payload.toString().split('|')[2],
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row rowNotification(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 35, color: Colors.white),
        const SizedBox(width: 10),
        Text(title, style: const TextStyle(fontSize: 30, color: Colors.white)),
      ],
    );
  }
}
