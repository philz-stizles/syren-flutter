import 'package:get/get.dart';
import 'package:syren/screens/schedule_care/ambulance_service/ambulance_service_controller.dart';
import 'package:syren/screens/schedule_care/clinic_appointment/clinic_appointment_controller.dart';
import 'package:syren/screens/schedule_care/home_visit/home_visit_controller.dart';
import 'package:syren/screens/medications/medications_controller.dart';
import 'package:syren/screens/notifications/notifications_controller.dart';
import 'package:syren/screens/otp/otp_controller.dart';
import 'package:syren/screens/schedule_care/schedule_care_controller.dart';
import 'package:syren/screens/settings/notification_settings/notification_settings_controller.dart';
import 'package:syren/screens/settings/settings_controller.dart';
import 'package:syren/screens/signin/signin_controller.dart';
import 'package:syren/screens/urgent_care/message/message_controller.dart';
import 'package:syren/screens/vitals/blood_pressure/blood_pressure_controller.dart';
import 'package:syren/screens/vitals/blood_pressure_add/blood_pressure_add_controller.dart';
import 'package:syren/screens/vitals/blood_sugar/blood_sugar_controller.dart';
import 'package:syren/screens/settings/change_password/change_password_controller.dart';
import 'package:syren/screens/reminders/reminders_controller.dart';
import 'package:syren/screens/reminders/set_med_reminder/set_med_reminder_controller.dart';
import 'package:syren/screens/reminders/set_vital_reminder/set_vital_reminder_controller.dart';
import 'package:syren/screens/settings/feedback/feedback_controller.dart';
import 'package:syren/screens/forgot_password/forgot_password_controller.dart';
import 'package:syren/screens/profile/medical_record_edit/medical_record_edit_controller.dart';
import 'package:syren/screens/profile/profile_controller.dart';
import 'package:syren/screens/profile/profile_edit/profile_edit_controller.dart';
import 'package:syren/screens/signup/signup_controller.dart';
import 'package:syren/screens/urgent_care/urgent_care_controller.dart';
import 'package:syren/screens/views.dart';
import 'package:syren/screens/vitals/blood_sugar_add/blood_sugar_add_controller.dart';

getPages() {
  return [
    GetPage(
        name: OtpView.routeName, page: () => OtpView(), binding: OtpBinding()),
    GetPage(
        name: SignInView.routeName,
        page: () => SignInView(),
        binding: SignInBinding()),
    GetPage(
        name: SignUpView.routeName,
        page: () => const SignUpView(),
        binding: SignUpBinding()),
    GetPage(
        name: SignUpMedicalsView.routeName,
        page: () => SignUpMedicalsView(),
        binding: SignUpBinding()),
    GetPage(
        name: ForgotPasswordView.routeName,
        page: () => ForgotPasswordView(),
        binding: ForgotPasswordBinding()),
    GetPage(
        name: ChangePasswordView.routeName,
        page: () => ChangePasswordView(),
        binding: ChangePasswordBinding()),
    GetPage(
        name: ProfileView.routeName,
        page: () => ProfileView(),
        binding: ProfileBinding()),
    GetPage(
        name: ProfileEditView.routeName,
        page: () => const ProfileEditView(),
        binding: ProfileEditBinding()),
    GetPage(
        name: MedicationsView.routeName,
        page: () => MedicationsView(),
        binding: MedicationsBinding()),
    GetPage(
        name: SettingsView.routeName,
        page: () => SettingsView(),
        binding: SettingsBinding()),
    GetPage(
        name: NotificationSettingsView.routeName,
        page: () => NotificationSettingsView(),
        binding: NotificationSettingsBinding()),
    GetPage(
        name: MedicalRecordEditView.routeName,
        page: () => MedicalRecordEditView(),
        binding: MedicalRecordEditBinding()),
    GetPage(
        name: BloodPressureView.routeName,
        page: () => BloodPressureView(),
        binding: BloodPressureBinding()),
    GetPage(
        name: BloodPressureAddView.routeName,
        page: () => BloodPressureAddView(),
        binding: BloodPressureAddBinding()),
    GetPage(
        name: BloodSugarView.routeName,
        page: () => BloodSugarView(),
        binding: BloodSugarBinding()),
    GetPage(
        name: BloodSugarAddView.routeName,
        page: () => BloodSugarAddView(),
        binding: BloodSugarAddBinding()),
    GetPage(
        name: UrgentCareView.routeName,
        page: () => UrgentCareView(),
        binding: UrgentCareBinding()),
    GetPage(
        name: MessageView.routeName,
        page: () => MessageView(),
        binding: MessageBinding()),
    GetPage(
        name: FeedbackView.routeName,
        page: () => FeedbackView(),
        binding: FeedbackBinding()),
    GetPage(
        name: RemindersView.routeName,
        page: () => const RemindersView(),
        binding: RemindersBinding()),
    GetPage(
        name: SetMedReminderView.routeName,
        page: () => SetMedReminderView(),
        binding: SetMedReminderBinding()),
    GetPage(
        name: SetVitalReminderView.routeName,
        page: () => SetVitalReminderView(),
        binding: SetVitalReminderBinding()),
    GetPage(
        name: ScheduleCareView.routeName,
        page: () => ScheduleCareView(),
        binding: ScheduleCareBinding()),
    GetPage(
        name: NotificationsView.routeName,
        page: () => const NotificationsView(),
        binding: NotificationsBinding()),
    GetPage(
        name: HomeVisitView.routeName,
        page: () => HomeVisitView(),
        binding: HomeVisitBinding()),
    GetPage(
        name: ClinicAppointmentView.routeName,
        page: () => ClinicAppointmentView(),
        binding: ClinicAppointmentBinding()),
    GetPage(
        name: AmbulanceServiceView.routeName,
        page: () => AmbulanceServiceView(),
        binding: AmbulanceServiceBinding()),
  ];
}
