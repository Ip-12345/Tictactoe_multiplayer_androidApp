import 'package:basico/Components/InGameUserCard.dart';
import 'package:basico/Configs/AssestsPath.dart';
import 'package:basico/Controller/SinglePlayerController.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SinglePlayer extends StatelessWidget {
  const SinglePlayer({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    SinglePlayerController singlePlayerController =
        Get.put(SinglePlayerController());
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: SvgPicture.asset(IconsPath.voiceIcon),
        ),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //Row(
                      //  children: [
                      //    SvgPicture.asset(IconsPath.backIcon),
                      //    const SizedBox(width: 15),
                      //    Text("Play Game",
                      //        style: Theme.of(context).textTheme.bodyMedium),
                      //  ],
                      //),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 45),
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    borderRadius: BorderRadius.circular(10)),
                                child: SvgPicture.asset(
                                  IconsPath.xxIcon,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 25),
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(IconsPath.winIcon),
                                    SizedBox(width: 10),
                                    Obx(() => Text(
                                        "WON : ${singlePlayerController.xScore}"))
                                  ],
                                ),
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 45),
                                decoration: BoxDecoration(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    borderRadius: BorderRadius.circular(10)),
                                child: SvgPicture.asset(
                                  IconsPath.oIcon,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 25),
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primaryContainer,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(IconsPath.winIcon),
                                    SizedBox(width: 10),
                                    Obx(() => Text(
                                        "WON : ${singlePlayerController.oScore}"))
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 60),
                      DottedBorder(
                        borderType: BorderType.RRect,
                        color: Theme.of(context).colorScheme.primary,
                        strokeWidth: 2,
                        dashPattern: [10, 10],
                        radius: Radius.circular(20),
                        child: Container(
                            margin: EdgeInsets.all(5),
                            width: w,
                            height: w - 33,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.background,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Obx(
                              () => GridView.builder(
                                  itemCount:
                                      singlePlayerController.playValue.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3),
                                  itemBuilder: ((context, index) {
                                    return InkWell(
                                      onTap: () {
                                        singlePlayerController.onClick(index);
                                      },
                                      child: Container(
                                        margin: EdgeInsets.all(0.5),
                                        decoration: BoxDecoration(
                                            color: singlePlayerController
                                                        .playValue[index] ==
                                                    'X'
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                                : singlePlayerController
                                                            .playValue[index] ==
                                                        'O'
                                                    ? Theme.of(context)
                                                        .colorScheme
                                                        .secondary
                                                    : singlePlayerController.playValue[index] ==
                                                            ''
                                                        ? Theme.of(context)
                                                            .colorScheme
                                                            .primaryContainer
                                                        : Theme.of(context)
                                                            .colorScheme
                                                            .primaryContainer,
                                            borderRadius: index == 0
                                                ? const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20))
                                                : index == 2
                                                    ? const BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(20))
                                                    : index == 6
                                                        ? const BorderRadius.only(
                                                            bottomLeft: Radius.circular(
                                                                20))
                                                        : index == 8
                                                            ? const BorderRadius.only(
                                                                bottomRight:
                                                                    Radius.circular(20))
                                                            : const BorderRadius.only()),
                                        child: Center(
                                            child: singlePlayerController
                                                        .playValue[index] ==
                                                    'X'
                                                ? SvgPicture.asset(
                                                    IconsPath.xxIcon,
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primaryContainer,
                                                    width: 45,
                                                  )
                                                : singlePlayerController
                                                            .playValue[index] ==
                                                        'O'
                                                    ? SvgPicture.asset(
                                                        IconsPath.oIcon,
                                                        color: Theme.of(context)
                                                            .colorScheme
                                                            .primaryContainer,
                                                        width: 50,
                                                      )
                                                    : singlePlayerController
                                                                    .playValue[
                                                                index] ==
                                                            ''
                                                        ? SizedBox()
                                                        : SizedBox()),
                                      ),
                                    );
                                  })),
                            )),
                      ),
                      SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(() => AnimatedContainer(
                                duration: const Duration(milliseconds: 500),
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                decoration: BoxDecoration(
                                    color: singlePlayerController.isXtime.value
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Row(
                                  children: [
                                    Obx(
                                      () => singlePlayerController.isXtime.value
                                          ? SvgPicture.asset(IconsPath.xxIcon,
                                              width: 30, color: Colors.white)
                                          : SvgPicture.asset(IconsPath.oIcon,
                                              width: 30, color: Colors.white),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      "Turn",
                                      style: TextStyle(
                                        fontSize: 25,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primaryContainer,
                                      ),
                                    )
                                  ],
                                ),
                              ))
                        ],
                      )
                    ],
                  ),
                ))));
  }
}
