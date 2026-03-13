import 'package:byaz_track/core/extension/extensions.dart';


class AddScreen extends   StatefulWidget {
  const AddScreen({super.key});
  
  @override
  State<AddScreen> createState()=>_AddScreenState();
  }


class _AddScreenState extends State<AddScreen>{
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add')),
      body: const Center(child: Text('Add Screen')),
    );
  }
}
