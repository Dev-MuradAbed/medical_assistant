import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:medical_assistant/provider/result_provider.dart';
import 'package:medical_assistant/utils/helpers.dart';
import 'package:provider/provider.dart';

import '../size_config.dart';
import '../theme.dart';
import '../widgets/list_rate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ListResult extends StatefulWidget {
  const ListResult({Key? key}) : super(key: key);

  @override
  State<ListResult> createState() => _ListResultState();
}

class _ListResultState extends State<ListResult> with Helper {
  SizeConfig size = SizeConfig();
  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ResultProvider>(context, listen: false).getRecord();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size.init(context);
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        title:  Text(
            AppLocalizations.of(context)!.medical_assistant,
          style: const TextStyle(
              fontFamily: 'Candara',
              color: blueClr,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureProvider(
        create: (_) => Provider.of<ResultProvider>(context, listen: false)
            .getRecord(),
        initialData: [],
        child: Consumer<ResultProvider>(
          builder: (context, resultProvider, child) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  showRecord()
                ],
              ),
            );
          },

    ),
      ));
  }

  Expanded showRecord() {
    return Expanded(
      child: Provider.of<ResultProvider>(context).resultList.isEmpty
          ? noTask(_onRefresh, AppLocalizations.of(context)!.dont_have_any_task,context)
          : RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.builder(
                scrollDirection:
                    SizeConfig.orientation == Orientation.landscape
                        ? Axis.horizontal
                        : Axis.vertical,
                itemCount:
                    Provider.of<ResultProvider>(context).resultList.length,
                itemBuilder: (context, index) {
                  var task =
                      Provider.of<ResultProvider>(context).resultList[index];
                  return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 1500),
                      child:  SlideAnimation(
                        horizontalOffset: 300,
                        child: FadeInAnimation(
                          child: ListRate(task),
                        ),
                      ));
                },
              ),
            ),
    );
  }

  Future<void> _onRefresh() async {
    Provider.of<ResultProvider>(context).getRecord();
  }
}
