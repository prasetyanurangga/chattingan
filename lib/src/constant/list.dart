import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ListData{
  static const List<String> CategoryClaim = [
    'Food',
    'Transportation',
    'Medical',
    'Entertaiment'
  ];

  static const List<String> CategoryLeave = [
    'Anual',
    'Pregnan',
    'Medical',
    'Entertaiment'
  ];

  static const List<Permission> permission = [
    Permission.camera,
    Permission.location,
    Permission.storage
  ];
}