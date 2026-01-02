import 'package:nexum_core/run_app.dart';
import 'package:nexum_core/widgets/flex.dart';
import 'package:nexum_core/widgets/framework.dart';
import 'package:nexum_core/widgets/rich_text.dart';

void main() {
  runApp(const Example());
}

class Example extends StatelessWidget {
  const Example({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      childrens: [
        const RichText("Olá, Mundo!"),
      ]
    );
  }
}