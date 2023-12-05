import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:medic_admin/shared_components/selection_button.dart';

class MainMenu extends StatelessWidget {
  final Function(int index, SelectionButtonData value) onSelected;

  const MainMenu({required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return SelectionButton(
      data: [
        SelectionButtonData(
          activeIcon: EvaIcons.home,
          icon: EvaIcons.homeOutline,
          label: "Home",
        ),
        SelectionButtonData(
          activeIcon: Icons.add,
          icon: Icons.add,
          label: "Add Category",
        ),
        SelectionButtonData(
          activeIcon: Icons.view_agenda_outlined,
          icon: Icons.view_agenda_outlined,
          label: "View Category",
        ),
        SelectionButtonData(
          activeIcon: Icons.add,
          icon: Icons.add,
          label: "Add Medicine",
        ),
        SelectionButtonData(
          activeIcon: Icons.view_agenda_outlined,
          icon: Icons.view_agenda_outlined,
          label: "View Medicine",
        ),
        SelectionButtonData(
          activeIcon: Icons.list,
          icon: Icons.list,
          label: "Orders",
        ),
        SelectionButtonData(
          activeIcon: Icons.list,
          icon: Icons.list,
          label: "Prescription",
        ),
        SelectionButtonData(
          activeIcon: Icons.star,
          icon: Icons.star,
          label: "Discount",
        ),
        SelectionButtonData(
          activeIcon: Icons.logout,
          icon: Icons.logout,
          label: "Log Out",
        ),
      ],
      onSelected: onSelected,
    );
  }
}
