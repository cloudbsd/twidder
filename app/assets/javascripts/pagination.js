/*
$(function() {
  $(".pagination a").live("click", function() {
  //$(".pagination").html("Page is loading...");
    $.get(this.href, null, null, "script");
    return false;
  });
});
*/

$(function() {
  $("#posts th a, #posts .pagination a").live("click", function() {
    $.getScript(this.href);
    return false;
  });
  $("#posts_search input").keyup(function() {
    $.get($("#posts_search").attr("action"), $("#posts_search").serialize(), null, "script");
    return false;
  });
});
