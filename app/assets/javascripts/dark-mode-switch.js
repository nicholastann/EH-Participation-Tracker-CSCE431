document.addEventListener('turbolinks:load', function() {
  // Initialize theme
  if (localStorage.getItem('themeSwitch') == 'dark') {
    $("body").attr("data-theme", "dark");
    localStorage.setItem('themeSwitch', 'dark');
    document.getElementById("themeSwitch").checked = true;
  } else {
    $("body").attr("data-theme", "light");
    localStorage.setItem('themeSwitch', 'light');
    document.getElementById("themeSwitch").checked = false;
  }

  // Change theme
  $('#themeSwitch').change(function() {
   if ($(this).prop("checked")) {
     $("body").attr("data-theme", "dark");
     localStorage.setItem('themeSwitch', 'dark');
   } else {
     $("body").attr("data-theme", "light");
     localStorage.setItem('themeSwitch', 'light');
   }
  });
});