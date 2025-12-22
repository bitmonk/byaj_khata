import 'package:empowered/core/extension/extensions.dart';


class {{name.pascalCase()}}Screen extends {{#isStateless}} StatelessWidget {{/isStateless}} {{^isStateless}} StatefulWidget {{/isStateless}}{
  const {{name.pascalCase()}}Screen({super.key});
  {{^isStateless}}
  @override
  State<{{name.pascalCase()}}Screen> createState()=>_{{name.pascalCase()}}ScreenState();
  }


class _{{name.pascalCase()}}ScreenState extends State<{{name.pascalCase()}}Screen>{
    {{/isStateless}}
  @override
  Widget build (BuildContext context){
    return Container();
  }
}

