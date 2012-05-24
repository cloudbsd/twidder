/*
$(function() {
  $(".pagination a").live("click", function() {
  //$(".pagination").html("Page is loading...");
    $.get(this.href, null, null, "script");
    return false;
  });
});
*/

if (history && history.pushState) {
  $(function() {
    $("#posts th a, #posts .pagination a").live("click", function() {
      $.getScript(this.href);
      history.pushState(null, document.title, this.href);
      return false;
    });
    $("#posts_search input").keyup(function() {
      $.get($("#posts_search").attr("action"), $("#posts_search").serialize(), null, "script");
      history.replaceState(null, document.title, $("#posts_search").attr("action") + "?" + $("#posts_search").serialize());
      return false;
    });
    $(window).bind("popstate", function() {
      $.getScript(location.href);
    });
  });
}
