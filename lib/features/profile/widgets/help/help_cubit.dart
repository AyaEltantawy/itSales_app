import 'package:bloc/bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import 'help_state.dart';

class HelpCubit extends Cubit<HelpState> {
  HelpCubit() : super(HelpState().init());
  Future<void> launchURL() async {
    const url = 'https://flutter.dev'; // Replace with your desired URL
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }   }
}
