import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_test_task/controllers/servers_controller.dart';
import 'package:vpn_test_task/data/models/server_model.dart';

class ServersScreen extends GetView<ServersController> {
  const ServersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(() {
        return ListView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              controller: controller.searchTextController,
              decoration: InputDecoration(
                hintText: "Servers",
                hintStyle: Theme.of(context).textTheme.headlineSmall,
                suffixIcon: Icon(Icons.search),
              ),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
              onChanged: (value) => controller.updateSearchQuery(value),
            ),
            SizedBox(height: 10.0),
            if (controller.unlockedServers.isNotEmpty)
              _ServersSectionWidget("UNLOCKED", controller.unlockedServers),
            if (controller.lockedServers.isNotEmpty)
              _ServersSectionWidget("LOCKED", controller.lockedServers),
          ],
        );
      }),
    );
  }
}

class _ServersSectionWidget extends GetView<ServersController> {
  final String title;
  final List<ServerModel> servers;

  const _ServersSectionWidget(this.title, this.servers);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 4.0),
          child: Text(title, style: Theme.of(context).textTheme.titleMedium),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: servers.length,
          itemBuilder: (context, index) {
            final server = servers[index];
            return Obx(() {
              final bool isSelected =
                  controller.selectedServer.value?.id == server.id;

              Color borderColor;
              if (isSelected && !server.isPremium) {
                borderColor = Theme.of(context).colorScheme.primary;
              } else {
                borderColor = Theme.of(context).colorScheme.outlineVariant;
              }

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: borderColor,
                    width: isSelected && !server.isPremium ? 1.5 : 1.0,
                  ),
                ),
                color: Theme.of(context).colorScheme.primaryContainer,
                child: ListTile(
                  leading: Opacity(
                    opacity: server.isPremium ? 0.5 : 1.0,
                    child: Image.asset(
                      server.flagAsset,
                      width: 40,
                      height: 40,
                      errorBuilder:
                          (context, error, stackTrace) => Icon(
                            Icons.flag_circle_outlined,
                            size: 40,
                            color: Theme.of(
                              context,
                            ).colorScheme.onSurface.withValues(alpha: 0.7),
                          ),
                    ),
                  ),
                  title: Text(
                    server.name,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  subtitle: Text(
                    server.isPremium
                        ? "${server.name} is a locked server in this app using secure connection."
                        : "${server.name} is a unlocked server in this app using secure connection.",
                    style: Theme.of(context).textTheme.labelSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    controller.selectServer(server);
                  },
                ),
              );
            });
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
