$(document).ready(function() { 

    // var b = $('.choice_collection');
    // var choices = $('.filter_collection_panel')

    $(".choice_collection").click(function(event) {
        event.preventDefault();
        
            $(this).closest('.fil_con').find('.filter_collection_panel').slideToggle();
            if ($(this).find('i').text() == 'keyboard_arrow_down'){
                $(this).find('i').text('keyboard_arrow_up');
            } else {
                $(this).find('i').text('keyboard_arrow_down');
            }
            $('.filter_collection_panel').toggleClass("active");

            // for testing 
            // alert("Clicked!");
    });
   
}); 