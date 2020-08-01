$(document).ready(function(){
    $(".edit-o-hidden").hide();
    // switching up affiliation divs based on answer
    $("#edit-affiliation").change(function(){
        $(".render-affiliation").remove();
        $(".edit-o-hidden").hide();

        var e = $("#edit-affiliation");
        var result = e.val();

        if (result == "Undergraduate student") {
            $("#edit-undergrad").show();
            $("#undergrad-major-field").prop("disabled", false);
            $("#undergrad-year-field").prop("disabled", false);

        } else if (result == "Graduate/professional student") {
            $("#edit-grad").show();
            $("#grad-major-field").prop("disabled", false);
            $("#grad-year-field").prop("disabled", false);

        } else if (result == "Alumni") {
            $("#edit-alumni").show();
            $("#alumni-year-field").prop("disabled", false);
            $("#alumni-major-field").prop("disabled", false);

        } else if (result == "Faculty" || result == "Staff") {
            $("#edit-staff").show();
            $("#staff-major-field").prop("disabled", false);
        }
    });
});
