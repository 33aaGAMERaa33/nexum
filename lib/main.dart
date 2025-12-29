import 'package:nexum_core/material/build_context.dart';
import 'package:nexum_core/material/main_axis_size.dart';
import 'package:nexum_core/material/state.dart';
import 'package:nexum_core/material/stateful_widget.dart';
import 'package:nexum_core/material/widget.dart';
import 'package:nexum_core/run_app.dart';
import 'package:nexum_widgets/widgets/center.dart';
import 'package:nexum_widgets/widgets/column.dart';
import 'package:nexum_widgets/widgets/debug_box.dart';
import 'package:nexum_widgets/widgets/gesture_detector.dart';
import 'package:nexum_widgets/widgets/rich_text.dart';
import 'package:nexum_core/material/value_key.dart';
import 'package:nexum_widgets/widgets/sized_box.dart';

void main() async {
  runApp(CounterList());
}

class CounterList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CounterListState();
}

class CounterListState extends State<CounterList> {
  int count = 0;
  bool trocado = false;

  @override
  Widget build(BuildContext context) {
    final Widget counterA = Counter("A", key: ValueKey("A"));
    final Widget counterB = Counter("B", key: ValueKey("B"));
    final Widget counterC = Counter("C", key: ValueKey("C"));
    final Widget counterD = Counter("D", key: ValueKey("D"));

    final List<Widget> childrens = [
      counterA,
      counterB,
      counterC,
      counterD,
    ];

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        childrens: [
          ...!trocado ? childrens : childrens.reversed,

          DebugBox(
              child: GestureDetector(
                onTap: () => setState(() {
                  trocado = !trocado;
                  count++;
                }),
                child: SizedBox(
                  width: 200,
                  height: 50,
                  child: Center(
                      child: RichText("Trocas: $count")
                  ),
                ),
              )
          )
        ]
      ),
    );
  }
}

class Counter extends StatefulWidget {
  final String title;
  Counter(this.title, {super.key});

  @override
  State<StatefulWidget> createState() => CounterState();

  @override
  String toString() => "Counter(title: $title)";
}

class CounterState extends State<Counter> {
  int count = 0;
  String get title => widget.title;

  @override
  Widget build(BuildContext context) {
    return DebugBox(
      child: GestureDetector(
        onTap: () => setState(() => count += 1),
        child: SizedBox(
          width: 200,
          height: 50,
          child: Center(
            child: RichText("$title: $count")
          ),
        ),
      )
    );
  }

  @override
  String toString() => "CounterState(title: $title, count: $count)";
}