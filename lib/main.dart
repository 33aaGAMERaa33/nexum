import 'package:nexum_core/foundation/events/input_events.dart';
import 'package:nexum_core/run_app.dart';
import 'package:nexum_core/widgets/align.dart';
import 'package:nexum_core/widgets/framework.dart';
import 'package:nexum_core/widgets/input_detector.dart';
import 'package:nexum_core/widgets/rich_text.dart';

void main() {
  runApp(Example());
}

class Example extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ExampleState();
}

class ExampleState extends State<Example> {
  int ? keyCode;
  PointerClickEvent ? pointerClickEvent;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InputDetector(
          onInput: (event) {
            if(event is KeyboardInputEvent && !event.released) {
              setState(() {
                keyCode = event.keyCode;
                pointerClickEvent = null;
              });
            }
          },
          child: RichText((keyCode ?? "Nenhum input detectado").toString())
      )
    );
  }
}