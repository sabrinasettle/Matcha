$(document).ready(function() { 

    var b = $('#choice_collection');
    var choices = $('.filter_collection_panel')

    $("#choice_collection").click(function(event) {
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

           
                $('.filter_collection_panel').slideToggle('2000');
           
            // $("i", this).toggleClass("");
            // $(this).html('<p>Interests</p><i class="material-icons">keyboard_arrow_up</i>');


            alert("Clicked!");
    });
   
}); 