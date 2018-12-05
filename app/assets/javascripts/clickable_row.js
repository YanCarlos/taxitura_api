document.addEventListener('turbolinks:load',function() {
  $('.clickable-row').click(function() {
      window.open($(this).data('href'));
  });
});
