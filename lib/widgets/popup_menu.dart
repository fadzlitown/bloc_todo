import 'package:flutter/material.dart';

import '../models/task.dart';

class PopupMenu extends StatelessWidget {
  final VoidCallback cancelOrDeleteCallback;
  final VoidCallback likeOrDislikeCallback;

  final Task task;

  const PopupMenu(
      {Key? key,
      required this.task,
      required this.cancelOrDeleteCallback,
      required this.likeOrDislikeCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        itemBuilder: task.isDeleted == false
            ? ((context) => [
                  PopupMenuItem(
                      onTap: () {},
                      child: TextButton.icon(
                          onPressed: null,
                          icon: const Icon(Icons.edit),
                          label: const Text('Edit'))),
                  PopupMenuItem(
                      onTap: likeOrDislikeCallback,
                      child: TextButton.icon(
                          onPressed: null,
                          icon: task.isFav == false
                              ? const Icon(Icons.bookmark_add_outlined)
                              : const Icon(Icons.bookmark_remove),
                          label: task.isFav == false
                              ? const Text('Add bookmark')
                              : const Text('Remove bookmark'))),
                  PopupMenuItem(
                      onTap: cancelOrDeleteCallback,
                      child: TextButton.icon(
                          onPressed: null,
                          icon: const Icon(Icons.delete),
                          label: const Text('Delete')))
                ])
            : ((context) => [
                  PopupMenuItem(
                      onTap: () => {},
                      child: TextButton.icon(
                          onPressed: null,
                          icon: const Icon(Icons.restore_from_trash),
                          label: const Text('Restore'))),
                  PopupMenuItem(
                      onTap: cancelOrDeleteCallback,
                      child: TextButton.icon(
                          onPressed: null,
                          icon: const Icon(Icons.delete_forever),
                          label: const Text('Delete Forever')))
                ]));
  }
}
