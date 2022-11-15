import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';

import '../resources/colors_manager.dart';
import '../resources/font_manager.dart';
import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';

class CipherFormWidget extends StatelessWidget {
  const CipherFormWidget({
    Key? key,
    required this.inputTextController,
    required this.keyTextController,
    required this.formKey,
    required this.result,
    required this.onEncrypt,
    required this.onDecrypt,
    required this.title,
    required this.onReset,
    required this.inputFormat,
    required this.keyFormat,
    required this.keyType,
  }) : super(key: key);

  final TextEditingController inputTextController;
  final TextEditingController keyTextController;
  final GlobalKey<FormState> formKey;
  final String result;
  final Function onEncrypt;
  final Function onDecrypt;
  final Function onReset;
  final String title;
  final RegExp inputFormat;
  final RegExp keyFormat;
  final TextInputType keyType;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(AppPadding.p16),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: AppSize.s16,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: AppSize.s24,
                fontWeight: FontWeightManager.bold,
              ),
            ),
            const SizedBox(
              height: AppSize.s16,
            ),
            TextFormField(
              controller: inputTextController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  inputFormat,
                ),
              ],
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                labelText: 'Enter Text',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            const SizedBox(
              height: AppPadding.p16,
            ),
            TextFormField(
              controller: keyTextController,
              keyboardType: keyType,
              inputFormatters: [
                FilteringTextInputFormatter.allow(keyFormat),
              ],
              decoration: const InputDecoration(
                labelText: 'Enter Key',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter some key';
                }
                return null;
              },
            ),
            const SizedBox(
              height: AppPadding.p16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      onEncrypt();
                    }
                  },
                  child: const Text(StringsManager.encrypt),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      onDecrypt();
                    }
                  },
                  child: const Text(StringsManager.decrypt),
                ),
              ],
            ),
            const SizedBox(
              height: AppSize.s16,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: Row(
                  children: [
                    const Text(
                      '${StringsManager.result}: ',
                      style: TextStyle(
                        fontSize: AppSize.s24,
                        fontWeight: FontWeightManager.medium,
                      ),
                    ),
                    Text(
                      result,
                      style: const TextStyle(
                        fontSize: AppSize.s24,
                        fontWeight: FontWeightManager.bold,
                        color: ColorManager.primary,
                      ),
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: AppSize.s16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {
                      if (result.isNotEmpty) {
                        FlutterClipboard.copy(result).then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                StringsManager.copiedToClipboard,
                                style: TextStyle(
                                  color: ColorManager.white,
                                  fontFamily: FontConstants.fontFamily,
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(AppSize.s20),
                                  topRight: Radius.circular(AppSize.s20),
                                ),
                              ),
                              backgroundColor: ColorManager.green,
                            ),
                          );
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              StringsManager.pleaseEncryptOrDecryptFirst,
                              style: TextStyle(
                                color: ColorManager.white,
                                fontFamily: FontConstants.fontFamily,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(AppSize.s20),
                                topRight: Radius.circular(AppSize.s20),
                              ),
                            ),
                            backgroundColor: ColorManager.error,
                          ),
                        );
                      }
                    },
                    icon: Icon(
                      Icons.copy,
                      color: Theme.of(context).primaryColor,
                    )),
                MaterialButton(
                  onPressed: () {
                    onReset();
                  },
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(AppSize.s8),
                    ),
                  ),
                  color: ColorManager.error,
                  child: const Text(
                    StringsManager.reset,
                    style: TextStyle(
                        color: ColorManager.white, fontSize: AppSize.s20),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      if (result.isNotEmpty) {
                        FlutterShare.share(
                          title: title,
                          text: result,
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              StringsManager.pleaseEncryptOrDecryptFirst,
                              style: TextStyle(
                                color: ColorManager.white,
                                fontFamily: FontConstants.fontFamily,
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(AppSize.s20),
                                topRight: Radius.circular(AppSize.s20),
                              ),
                            ),
                            backgroundColor: ColorManager.error,
                          ),
                        );
                      }
                    },
                    icon: Icon(Icons.share,
                        color: Theme.of(context).primaryColor)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
