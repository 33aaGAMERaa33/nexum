import 'package:nexum_core/run_app.dart';
import 'package:nexum_core/widgets/align.dart';
import 'package:nexum_core/widgets/debug_box.dart';
import 'package:nexum_core/widgets/flex.dart';
import 'package:nexum_core/widgets/framework.dart';
import 'package:nexum_core/widgets/rich_text.dart';
import 'package:nexum_core/widgets/single_child_scroll_view.dart';
import 'package:nexum_core/widgets/sized_box.dart';

void main() {
  runApp(const Example());
}

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> childrens = [];

    for(int i = 1; i <= 100; i++) {
      childrens.add(DebugBox(
        child: SizedBox(
          width: 100,
          height: 100,
          child: Center(
            child: RichText("Olá, Mundo!")
          )
        ),
      ));
    }

    return Center(
        child: SingleChildScrollView(
          child: Column(childrens: childrens)
        )
    );
  }
}