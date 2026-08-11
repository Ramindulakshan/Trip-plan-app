import 'package:flutter/material.dart';

import '../../models/travel_group.dart';

class AddGroupScreen extends StatefulWidget {
  const AddGroupScreen({super.key});

  @override
  State<AddGroupScreen> createState() => _AddGroupScreenState();
}

class _AddGroupScreenState extends State<AddGroupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _memberController = TextEditingController();
  final List<String> _members = [];

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _memberController.dispose();
    super.dispose();
  }

  void _addMember() {
    final member = _memberController.text.trim();
    if (member.isEmpty || _members.contains(member)) return;
    setState(() {
      _members.add(member);
      _memberController.clear();
    });
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;
    _addMember();
    Navigator.of(context).pop(
      TravelGroup(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        members: List.unmodifiable(_members),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Group')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Bring your crew together',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 6),
              const Text('Add names or email addresses one at a time.'),
              const SizedBox(height: 24),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Group name',
                  prefixIcon: Icon(Icons.groups_outlined),
                ),
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Enter a group name'
                    : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Description (optional)',
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 22),
              Text(
                'Members',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _memberController,
                      decoration: const InputDecoration(
                        labelText: 'Name or email',
                        prefixIcon: Icon(Icons.person_add_outlined),
                      ),
                      onFieldSubmitted: (_) => _addMember(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  IconButton.filled(
                    onPressed: _addMember,
                    icon: const Icon(Icons.add),
                    tooltip: 'Add member',
                  ),
                ],
              ),
              if (_members.isNotEmpty) ...[
                const SizedBox(height: 14),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _members
                      .map(
                        (member) => InputChip(
                          label: Text(member),
                          onDeleted: () =>
                              setState(() => _members.remove(member)),
                        ),
                      )
                      .toList(),
                ),
              ],
              const SizedBox(height: 28),
              FilledButton.icon(
                onPressed: _save,
                icon: const Icon(Icons.check_rounded),
                label: const Text('Create group'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
