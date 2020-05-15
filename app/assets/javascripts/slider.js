$(document).ready(function(){
    var slider = $('#age_slider').slider({
    
        range: true,
        min: 18,
        max: 90,
        values: [18, 90],
        animate: "slow",
        orientation: "horizontal",

        slide: function(event, ui) {
            $('#filter_youngest').val(ui.values[0]);
            $('#filter_oldest').val(ui.values[1]);

            $("#filter_young").val(ui.values[0]);
            $("#filter_old").val(ui.values[1]);
        }
    });
        $('#filter_youngest').val(slider.slider("values")[0]);
        $('#filter_oldest').val(slider.slider("values")[1]);

        $("#filter_young").val(slider.slider("values")[0]);
        $("#filter_old").val(slider.slider("values")[1]);
   
    
});

// ---------------------------------------------

$(document).ready(function(){
    var slider = $('#distance_slider').slider({

        // range: true,
        min: 1,
        max: 50,
        values: [50],
        animate: "slow",
        orientation: "horizontal",

        slide: function(event, ui) {
            // $('#filter_nearest').val(ui.values[0]);
            $('#filter_farthest').val(ui.values[0]);

            // $("#filter_near").val(ui.values[0]);
            $("#filter_far").val(ui.values[0]);
        }
    });
        // $('#filter_nearest').val(slider.slider("values")[0]);
        $('#filter_farthest').val(slider.slider("values")[0]);

        // // $("label[for = youngest]").text("mm");
        // $("#filter_near").val(slider.slider("values")[0]);
        $("#filter_far").val(slider.slider("values")[0]);
        

});

// ---------------------------------------------

$(document).ready(function(){
    var slider = $('#rating_slider').slider({

        range: true,
        min: 0,
        max: 10,
        values: [0, 10],
        animate: "slow",
        orientation: "horizontal",

        slide: function(event, ui) {
            $('#filter_lowest').val(ui.values[0]);
            $('#filter_highest').val(ui.values[1]);

            $("#filter_low").val(ui.values[0]);
            $("#filter_high").val(ui.values[1]);
        }
    });
        $('#filter_lowest').val(slider.slider("values")[0]);
        $('#filter_highest').val(slider.slider("values")[1]);

        // $("label[for = youngest]").text("mm");
        $("#filter_low").val(slider.slider("values")[0]);
        $("#filter_high").val(slider.slider("values")[1]);


});


