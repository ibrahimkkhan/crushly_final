import 'package:flutter/material.dart';

@immutable
abstract class ProfileSettingsEvent {}

class ChangeName extends ProfileSettingsEvent {}
