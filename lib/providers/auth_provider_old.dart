import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  
  User? _user;
  bool _isLoading = false;
  String _errorMessage = '';

  // Getters
  User? get user => _user;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  bool get isAuthenticated => _user != null;

  AuthProvider() {
    // Listen to auth state changes
    _authService.authStateChanges.listen((User? user) {
      _user = user;
      notifyListeners();
    });
    
    // Check if user is already signed in
    _user = _authService.currentUser;
  }

  Future<bool> signIn(String email, String password) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    try {
      // Simple validation for demo
      if (email.isNotEmpty && password.length >= 6) {
        _user = MockUser(email);
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        throw Exception('Credenciales inválidas');
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = _getErrorMessage(e);
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String email, String password) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    try {
      // Simple validation for demo
      if (email.isNotEmpty && password.length >= 6) {
        _user = MockUser(email);
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        throw Exception('Datos inválidos para registro');
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = _getErrorMessage(e);
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    _user = null;
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> resetPassword(String email) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    _isLoading = false;
    notifyListeners();
    return true; // Always success for demo
  }

  void clearError() {
    _errorMessage = '';
    notifyListeners();
  }

  String _getErrorMessage(dynamic error) {
    return 'Error: ${error.toString()}';
  }
}