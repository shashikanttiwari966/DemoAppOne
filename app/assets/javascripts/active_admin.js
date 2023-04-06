//= require active_admin/base
//= require activeadmin_addons/all
// import "active_material"
//= require jquery
//= require best_in_place
//= require best_in_place.jquery-ui
// import 'jquery-ui/ui/widget'
// import 'jquery-ui/ui/widgets/mouse'
//= require chartkick
//= require Chart.bundle
$(document).ready(function() {
  /* Activating Best In Place */  
  jQuery(".best_in_place").best_in_place() 
});

$(document).ready(function(){
  $(".dropdown_menu_list").css("display", "none")
  $(".dropdown_menu_button").click(function(){ 
    $(".dropdown_menu_list").toggle()
  })

  $('#notification').append('<div class="notification-list show"></div>');
  $('#notification').click(function(e) {
    $.ajax({
      type: "GET",
      url: '/notifications/index',
        }).done(function(res) {
          $(".notification-list").html(res);
    });
  });

  // var imageUrl = "https://www.geeksforgeeks.org/wp-content/uploads/jquery-banner-768x256.png";
  // $("#utility_nav").css("background-image", "url(" + imageUrl + ")");
  $('div.action_items').append('<span class="action_item"><a id="toggle_filters" href="#" class=\'epon\'>Filters</a></span>')
  // when we request a filtered collection, we won't hide the sidebar
  if(!window.location.search.includes('Filter')){ 
    $('div#sidebar').hide(); $('a#toggle_filters').removeClass('epon') 
  }
  $('a#toggle_filters').click(function(){ 
    $('div#sidebar').toggle(); $(this).toggleClass('epon') 
  })
});