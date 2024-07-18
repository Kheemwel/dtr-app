const appLogo = 'assets/images/app_logo.png';
const iconHome = 'assets/icons/icon_home.svg';
const iconDelete = 'assets/icons/icon_delete.svg';
const iconCalendar = 'assets/icons/icon_calendar.svg';
const iconBack = 'assets/icons/icon_back.svg';
const militaryHourFormat = 'HH:mm';

/// List of date formats
final Map<String, String> dateFormats = {
  'MM/dd/yyyy': 'MM/dd/yyyy (12/25/2024)',
  'yyyy-MM-dd': 'yyyy-MM-dd (2024-12-25)',
  'MM-dd-yyyy': 'MM-dd-yyyy (12-25-2024)',
  'MMM dd, yyyy': 'MMM dd, yyyy (Dec 25, 2024)',
  'MMMM dd, yyyy': 'MMMM dd, yyyy (December 25, 2024)',
  'EEEE, MMMM dd, yyyy': 'EEEE, MMMM dd, yyyy (wednesday, December, 25, 2024)',
};

/// List of time formats
final Map<String, String> timeFormats = {'h:mm a': '12-Hour Clock', 'HH:mm': '24-Hour Clock'};
