import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/app_buttons.dart';

class PreferenceModal<T> extends StatefulWidget {
  final String title;
  final List<T> options;
  final Set<T> initialSelection;
  final String Function(T) labelBuilder;
  final void Function(Set<T>) onConfirm;
  final Set<T> Function(Set<T>, T)? exclusivityResolver;

  const PreferenceModal({
    super.key,
    required this.title,
    required this.options,
    required this.initialSelection,
    required this.labelBuilder,
    required this.onConfirm,
    this.exclusivityResolver,
  });

  @override
  State<PreferenceModal<T>> createState() => _PreferenceModalState<T>();
}

class _PreferenceModalState<T> extends State<PreferenceModal<T>> {
  late Set<T> _tempSelection;

  @override
  void initState() {
    super.initState();
    _tempSelection = Set<T>.from(widget.initialSelection);
  }

  void _toggleOption(T option) {
    setState(() {
      if (widget.exclusivityResolver != null) {
        _tempSelection = widget.exclusivityResolver!(_tempSelection, option);
      } else {
        if (_tempSelection.contains(option)) {
          _tempSelection.remove(option);
        } else {
          _tempSelection.add(option);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 760),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 8),
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: SingleChildScrollView(
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      alignment: WrapAlignment.center,
                      children: widget.options.map((option) {
                        final isSelected = _tempSelection.contains(option);
                        return _PreferenceChip(
                          label: widget.labelBuilder(option),
                          isSelected: isSelected,
                          onTap: () => _toggleOption(option),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                AppPrimaryButton(
                  text: 'Confirm',
                  onPressed: () {
                    widget.onConfirm(_tempSelection);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PreferenceChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _PreferenceChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(32),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE8F5E9) : AppColors.card,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(
            color: isSelected ? const Color(0xFF6B8E7A) : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: isSelected ? const Color(0xFF1B5E20) : AppColors.primaryText,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
