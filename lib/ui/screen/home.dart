import 'package:coding_challenge/bloc/ptb_bloc.dart';
import 'package:coding_challenge/models/ptb.dart';
import 'package:coding_challenge/ui/colors.dart';
import 'package:coding_challenge/ui/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: Colors.black,
          height: 600,
          child: BlocBuilder<PTBBloc, PTBState>(
            builder: (context, state) {
              if (state is ErrorPTBState) {
            return PTBError(state: state);
          } else if (state is SuccessPTBState) {
            return PTBSuccess(state: state);
          } else {
            return const PTBLoading();
          }
        },
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}

class PTBSuccess extends StatelessWidget {
  final SuccessPTBState state;

  const PTBSuccess({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned.fill(
          child: Image.network(state.selectedItem.covers.first.url,
              fit: BoxFit.cover)),
      Positioned.fill(
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
          Colors.black.withOpacity(.7),
          Colors.transparent
        ]))),
      ),
      Positioned(
        bottom: 16,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16, left: 16),
              child: Text(state.selectedItem.label, style: white36Bold),
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 24, left: 16),
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * .6),
                    child: Text(state.selectedItem.description,
                        maxLines: 2,
                        style: white20Medium,
                        overflow: TextOverflow.ellipsis))),
            PTBItemList(items: state.items, selectedItem: state.selectedItem)
          ],
        ),
      )
    ]);
  }
}

class PTBItemList extends StatelessWidget {
  final List<PTBItem> items;
  final PTBItem selectedItem;

  const PTBItemList({Key? key, required this.items, required this.selectedItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight: 270, maxWidth: MediaQuery.of(context).size.width),
      child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          separatorBuilder: (_, __) =>
              SizedBox.fromSize(size: const Size.fromWidth(8)),
          itemBuilder: (context, index) => PTBItemListIndex(
              item: items[index], selected: items[index] == selectedItem)),
    );
  }
}

class PTBItemListIndex extends StatelessWidget {
  final PTBItem item;
  final bool selected;

  const PTBItemListIndex({Key? key, required this.item, this.selected = false})
      : super(key: key);

  void _onSelect(BuildContext context) =>
      BlocProvider.of<PTBBloc>(context).add(SelectPTBEvent(item: item));

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onSelect(context),
      onHover: (_) => _onSelect(context),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: SizedBox(
              width: 370,
              height: selected ? 220 : 200,
              child: Stack(
                children: [
                  Positioned.fill(
                      child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        border: selected
                            ? Border.all(color: ptbYellow, width: 4)
                            : null),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: Image.network(item.covers.first.url,
                          fit: BoxFit.cover),
                    ),
                  )),
                  Positioned(
                      left: 16,
                      bottom: 16,
                      child: PTBBadgeIndicator(
                          badge: item.badge, highlight: selected)),
                ],
              ),
            ),
          ),
          Text(item.label, style: white20Medium)
        ],
      ),
    );
  }
}

class PTBBadgeIndicator extends StatelessWidget {
  final PTBBadge badge;
  final bool highlight;

  const PTBBadgeIndicator(
      {Key? key, required this.badge, this.highlight = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final backgroundColor = highlight ? badge.badgeBGFlutterColor : ptbGray;
    return Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.circular(7)),
        child: Text(badge.badgeText, style: white20));
  }
}

class PTBLoading extends StatelessWidget {
  const PTBLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator(color: Colors.white));
  }
}

class PTBError extends StatelessWidget {
  final ErrorPTBState state;

  const PTBError({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Error loading, please try again"),
          ElevatedButton(
              onPressed: () =>
                  BlocProvider.of<PTBBloc>(context).add(InitializePTBEvent()),
              child: const Text("Reload"))
        ]);
  }
}
