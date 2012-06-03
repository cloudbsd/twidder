$(document).ready(function() {
  var $firstPara = $('.speech p').eq(1);
  $firstPara.hide();

  $('a.more').click(function() {
//  $firstPara.slideToggle(1000);
    $firstPara.animate({opacity: 'toggle', height: 'toggle'}, 1000);
    var $link = $(this);
    if ($link.text() == 'read more') {
      $link.text('read less');
    } else {
      $link.text('read more');
    }
    return false;
  });

  var $speech = $('div .speech a, div .speech p');
  var defaultSize = $speech.css('fontSize');
  $('#switcher button').click(function() {
    var num = parseFloat($speech.css('fontSize'));
    switch (this.id) {
      case 'switcher-large':
        num *= 1.4;
        break;
      case 'switcher-small':
        num /= 1.4;
        break;
      default:
        num = parseFloat(defaultSize);
        break;
    }
    $speech.css('fontSize', num + 'px')
  });
});
