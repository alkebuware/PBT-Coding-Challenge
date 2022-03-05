import 'package:coding_challenge/bloc/ptb_bloc.dart';
import 'package:coding_challenge/repositories/ptb.dart';
import 'package:coding_challenge/ui/screen/home.dart';
import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PTBCodingChallengeApp extends StatelessWidget {
  const PTBCodingChallengeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PTBRepository(Dio()),
      child: BlocProvider(
        create: (context) => PTBBloc(
            ptbRepository: RepositoryProvider.of<PTBRepository>(context))
          ..add(InitializePTBEvent()),
        child: MaterialApp(
          title: 'PTB Coding Challenge',
          scrollBehavior: PTBScrollingBehavior(),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}

class PTBScrollingBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
