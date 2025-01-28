import 'package:bugrani2/models/leave.dart';
import 'package:bugrani2/models/leaveBalances.dart';
import 'package:bugrani2/services/leaves_services.dart';
import 'package:flutter/material.dart';

class LeavesProvider extends ChangeNotifier {
  List<Leave> leaves = [];
  LeaveBalance? leaveBalance;
  List<String> recommendations = [];
  bool isLoading = false;

  Future<void> getMyLeave() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await LeavesService().getMyLeave();
      leaves =
          (response.data as List).map((leave) => Leave.fromMap(leave)).toList();
    } catch (e) {
      print("Error fetching leaves: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> getLeaves() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await LeavesService().getLeaves();
      leaves =
          (response.data as List).map((leave) => Leave.fromMap(leave)).toList();
    } catch (e) {
      print("Error fetching leaves: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> getLeaveBalance() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await LeavesService().getLeaveBalance();
      leaveBalance = LeaveBalance.fromMap(response.data['leaveBalance']);
    } catch (e) {
      print("Error fetching leaves: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> getLeaveRecommendations() async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await LeavesService().getLeaveRecommendations();
      recommendations = List<String>.from(response.data['recommendation']);
    } catch (e) {
      print("Error fetching leaves: $e");
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> submitLeave({
    required String type,
    required String startDate,
    required String endDate,
    required String description,
  }) async {
    try {
      final response = await LeavesService().createLeave(
        type: type,
        startDate: startDate,
        endDate: endDate,
        description: description,
      );

      leaves.add(Leave.fromMap(response));
      notifyListeners();

      print("Submitted Leave Request Successfully");
    } catch (e) {
      print("Error submitting leave: $e");
    }
  }

  Future<void> approveLeave(String leaveId) async {
    try {
      await LeavesService().approveLeave(leaveId);
      // Update the leave status locally
      leaves = leaves.map((leave) {
        if (leave.id == leaveId) {
          leave.setStatus = 'Approved';
        }
        return leave;
      }).toList();
      notifyListeners();
    } catch (e) {
      print("Error approving leave: $e");
    }
  }

  Future<void> rejectLeave(String leaveId) async {
    try {
      await LeavesService().rejectLeave(leaveId);
      // Update the leave status locally
      leaves = leaves.map((leave) {
        if (leave.id == leaveId) {
          leave.setStatus = 'Rejected';
        }
        return leave;
      }).toList();
      notifyListeners();
    } catch (e) {
      print("Error rejecting leave: $e");
    }
  }
}
