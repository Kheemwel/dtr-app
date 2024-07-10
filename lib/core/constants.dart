const appLogo = 'assets/images/app_logo.png';
const iconHome = 'assets/icons/icon_home.svg';
const iconDelete = 'assets/icons/icon_delete.svg';

/// List of date formats
final Map<String, String> dateFormats = {
  'YYYY-MM-DD': 'YYYY-MM-DD',
  'MM-DD-YYYY': 'MM-DD-YYYY',
  'MM/DD/YYYY': 'MM/DD/YYYY',
  'MMM DD, YYYY': 'MMM DD, YYYY',
  'MMMM DD, YYYY': 'MMMM DD, YYYY',
  'EEEE, MMMM DD': 'EEEE, MMMM DD, YYYY',
};

/// List of time formats
final Map<String, String> timeFormats = {
  'h:mm a ': '12-Hour Clock',
  'h:mm ': '24-Hour Clock'
};
