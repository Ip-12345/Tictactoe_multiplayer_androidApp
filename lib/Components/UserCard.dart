import 'package:basico/Configs/AssestsPath.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UserCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String coins;
  final String status;
  const UserCard(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.coins,
      this.status = ""});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: w / 2.6,
          height: 140,
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer, //white
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            children: [
              SizedBox(height: 50),
              Text(name, style: Theme.of(context).textTheme.bodyMedium),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(IconsPath.coinIcon, width: 20),
                  SizedBox(width: 10),
                  Text("$coins Coins",
                      style: Theme.of(context).textTheme.bodyMedium)
                ],
              ),
              status == ""
                  ? SizedBox()
                  : status == "ready"
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.done, color: Colors.green, size: 20),
                            SizedBox(width: 10),
                            Text(status)
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.watch_later_outlined,
                                color: Colors.orange, size: 20),
                            SizedBox(width: 10),
                            Text(status)
                          ],
                        )
            ],
          ),
        ),
        Positioned(
            top: -40,
            left: w / 2.6 / 2 - 40,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      width: 3)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ))
      ],
    );
  }
}
