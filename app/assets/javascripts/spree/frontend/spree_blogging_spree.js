// Placeholder manifest file.
// the installer will append this file to the app vendored assets here: vendor/assets/javascripts/spree/frontend/all.js'

jQuery(function() {
  $('#news-archive')
    .find('ul').hide()
      .filter('.months:first').show().end()
      .filter('.posts:first').show().end()
      .end()

    .find('span:lt(2)').addClass('open').text('▼').end()  
    .find('span:gt(1)').text('►').end()
    
    $('#news-archive span').click(function() {  
       if ($(this).hasClass('open'))
        {
          $(this).toggleClass('open').text('►');
        } 
        else
        {
          $(this).toggleClass('open').text('▼');
        }
        
        $(this).siblings('ul:first').toggle(); 
     });                           
});
