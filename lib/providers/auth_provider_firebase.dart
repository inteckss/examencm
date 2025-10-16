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

    try {
      await _authService.signInWithEmailAndPassword(email, password);
      _isLoading = false;
      notifyListeners();
      return true;
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

    try {
      await _authService.registerWithEmailAndPassword(email, password);
      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = _getErrorMessage(e);
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      await _authService.signOut();
    } catch (e) {
      _errorMessage = _getErrorMessage(e);
      notifyListeners();
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      await _authService.resetPassword(email);
      return true;
    } catch (e) {
      _errorMessage = _getErrorMessage(e);
      notifyListeners();
      rethrow;
    }
  }

  void clearError() {
    _errorMessage = '';
    notifyListeners();
  }

  String _getErrorMessage(dynamic error) {
    if (error is FirebaseAuthException) {
      switch (error.code) {
        case 'user-not-found':
          return 'No se encontró una cuenta con este email';
        case 'wrong-password':
          return 'Contraseña incorrecta';
        case 'email-already-in-use':
          return 'Ya existe una cuenta con este email';
        case 'weak-password':
          return 'La contraseña es muy débil';
        case 'invalid-email':
          return 'Email inválido';
        case 'user-disabled':
          return 'Esta cuenta ha sido deshabilitada';
        case 'too-many-requests':
          return 'Demasiados intentos. Intenta más tarde';
        case 'network-request-failed':
          return 'Error de conexión. Verifica tu internet';
        default:
          return 'Error de autenticación: ${error.message}';
      }
    }
    return error.toString();
  }
}