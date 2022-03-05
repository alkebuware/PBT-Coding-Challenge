import 'package:coding_challenge/bloc/ptbbloc_bloc.dart';
import 'package:coding_challenge/repositories/ptb.dart';
import 'package:coding_challenge/ui/screen/home.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class PTBCodingChallengeApp extends StatelessWidget {
  const PTBCodingChallengeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PTBRepository(Dio()),
      child: BlocProvider(
        create: (context) => PTBBloc(
            ptbRepository: RepositoryProvider.of<PTBRepository>(context))
          ..add(PTBInitializeEvent()),
        child: const MaterialApp(
          title: 'PTB Coding Challenge',
          home: HomeScreen(),
        ),
      ),
    );
  }
}
