$(document).ready(function() {
  var $firstPara = $('.speech p').eq(1);
  $firstPara.hide();

  $('a.more').click(function() {
    $firstPara.slideToggle(1000);
    var $link = $(this);
    if ($link.text() == 'read more') {
      $link.text('read less');
    } else {
      $link.text('read more');
    }
    return false;
  });
  /*
  $('.speech p').eq(1).hide();
  $('a.more').click(function() {
//  $('.speech p').eq(1).show('slow');
//  $('.speech p').eq(1).show(5000);
//  $('.speech p').eq(1).fadeIn(5000);
    $('.speech p').eq(1).slideDown(5000);
    $(this).hide();
    return false;
  });
  */
});
