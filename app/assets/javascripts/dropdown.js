$(document).ready(function() { 

    var b = $('.choice_collection');
    var choices = $('.filter_collection_panel')

    $(".choice_collection").click(function(event) {
        event.preventDefault();
        // if ($('.filter_collection_panel').css("display", "none");

            // $('#display_advance').toggle('1000');
            // if ($('.filter_collection_panel').style.display === 'none') {
            //     $('.filter_collection_panel').style.display = 'block';
            //   } else {
            //     $('.filter_collection_panel').style.display = 'none';
            //   }



            //This Works
            // $('ul').slideToggle(280);

           
            // $(this).closest(".Box")$('.filter_collection_panel').slideToggle('2000');
            $(this).closest('.fil_con').find('.filter_collection_panel').slideToggle();

            // $("i", this).toggleClass("");
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