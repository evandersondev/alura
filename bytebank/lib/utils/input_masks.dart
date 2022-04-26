import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

final maskAgency = MaskTextInputFormatter(
  mask: '####',
  initialText: '0000',
  filter: {"#": RegExp(r'[0-9]')},
  // type: MaskAutoCompletionType.lazy,
);

final maskAccount = MaskTextInputFormatter(
  mask: '#####-#',
  initialText: '00000-0',
  filter: {"#": RegExp(r'[0-9]')},
  // type: MaskAutoCompletionType.lazy,
);
