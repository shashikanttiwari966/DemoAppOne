//= require arctic_admin/base
//= require activeadmin_addons/all
//= require jquery
//= require best_in_place
//= require best_in_place.jquery-ui
//= require chartkick
// = require Chart.bundle
//= require jquery-ui/widgets/tabs

//= require rails_emoji_picker
//= require cable
// import "active_material"
// import 'jquery-ui/ui/widget'
// import 'jquery-ui/ui/widgets/mouse'

//= require action_cable
//= require_self
//= require_tree .



$(document).ready(function() {
  /* Activating Best In Place */  
  jQuery(".best_in_place").best_in_place()

  new SlimSelect({
      select: '#selectElement'
  })
});


$(document).ready(function(){

  // action cable
  (function() {
    this.App || (this.App = {});

    App.cable = ActionCable.createConsumer();

    App.yourChannel = App.cable.subscriptions.create({ channel: 'ChatsChannel' }, {
      received: function(data) {
        // $("#body").val('')
        var d = new Date();

        $('#mess_'+data.conversation.id).html(data.message.body)
        $('#time_'+data.conversation.id).html(d.getHours()+":"+d.getMinutes())
        if($('#current_user').find('span').text() ==  data.current_user.email){
          $('#'+data.conversation.id).append("<div class='message text-only' id='message_'"+data.message.id+"><div class='response'><p class='text'>"+data.message.body+"</p></div></div><p class='response-time time'>"+d.getHours()+"h"+d.getMinutes()+"</p>")
        }
        else{
          $('#'+data.conversation.id).append("<div class='message' id='message_'"+data.message.id+"><div class='photo' style='background-image: url("+data.receiver_image+");'><div class='online'></div></div><p class='text'>"+data.message.body+"</p></div><p class='time'>"+d.getHours()+"h"+d.getMinutes()+"</p>")
        }
        $('#'+data.conversation.id).scrollTop($('#'+data.conversation.id)[0].scrollHeight)
        console.log(data);

      }
    });

    App.yourChannel = App.cable.subscriptions.create({ channel: 'AppearancesChannel' }, {
      received: function(data) {
        user = $(".user-"+data['user_id'])
        user.toggleClass('online', data['online'])
      }
    });
  }).call(this);


  $("#latest-plan-info-3").hide()
  $("#latest-product-info-3").hide()

  $(".nav-tabs").on('click','li',function(){
    $(".nav-tabs li.active").removeClass("active");
    $(this).addClass("active");
    if ($(this).find('a').text() == 'Latest Plan Info(3)'){
      $("#latest-product-info-3").hide()
      $("#latest-plan-info-3").show()
    }
    else{
      $("#latest-plan-info-3").hide()
      $("#latest-product-info-3").show()
    }
});

  // Conversation Mesagges start with buttom of chat
  if (window.location.pathname.includes("/admin/conversations")){
    $('.messages-chat').scrollTop($('.messages-chat')[0].scrollHeight)
  } 

  // On create product show sizes of product type
  if (window.location.pathname.includes("/admin/products/new")){
    $("#product_product_type").change( function(){
      myfunction();
    });
  }

  $(".product_sizings").find('.has_many_add').click(function(){
    myfunction();
  })

  function myfunction(){
    $.ajax({
      type: "GET",
      url: '/admin/products/get_product_size',
      data: {product_type: $("#product_product_type option:selected").text()} 
        }).done(function(res) {
          setTimeout(function() {$('.has_many_fields').find('select').each(function(index){
            $(this).replaceWith(res)
            var select = $('#product_product_sizings_attributes_'+index+'_product_size_id_input').find('select')
            select.attr("name", "product[product_sizings_attributes]["+index+"][product_size_id]")
            select.attr("id","product_product_sizings_attributes_"+index+"_product_size_id")
          }) }, 100)
          if ($('.has_many_fields').length < 1){
            $('.has_many_add').click()
          }
      })
  }

  // batch action.............................................................................
  $(".dropdown_menu_list").css("display", "none")
  $(".dropdown_menu_button").click(function(){ 
    $(".dropdown_menu_list").toggle()
  })


  // show notifications.......................................................................
  $('#notification').append('<div class="notification-list show"></div>');
  $('#notification').click(function(e) {

    $(".show").css("height", "550px")
    $(".show").css("overflow-y", "scroll")
    $.ajax({
      type: "GET",
      url: '/notifications/index',
        }).done(function(res) {
          $(".notification-list").html(res);
    });
  });

  // show and hide filters.....................................................................
  // $('div.action_items').append('<span class="action_item"><a id="toggle_filters" href="#" class=\'epon\'>Filters</a></span>')
  // // when we request a filtered collection, we won't hide the sidebar
  // if(!window.location.search.includes('Filter')){ 
  //   $('div#sidebar').hide(); $('a#toggle_filters').removeClass('epon') 
  // }
  // $('a#toggle_filters').click(function(){ 
  //   $('div#sidebar').toggle(); $(this).toggleClass('epon') 
  // })
});



// $('.has_many_fields').find('select').change(function(){
//   $('.has_many_fields').find('select').each(function() {  
//       $('option').each(function() {
//           if(!this.selected) {
//               $(this).attr('disabled', true);
//           }
//       });
//   })
// });