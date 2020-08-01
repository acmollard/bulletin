$(document).ready(function(){

    function resizeHandler() {
        if ($(window).width() <= 500) {
        	console.log("window bigger than 500");
			$('.sign-in-external-button').addClass('sign-in-responsive');
        } else if($(window).width() > 500) {
        	if ($('.sign-in-external-button').hasClass('sign-in-responsive')) {
                $('.sign-in-external-button').removeClass('sign-in-responsive');
            }
        }
    }
    resizeHandler();
    $(window).resize(resizeHandler);

    setTimeout(function(){
    $('.flash').fadeOut();
    }, 8000);

    $(".assign-admin").on("click", function () {
        thisDiv = $("#create-admin-form");

        if (thisDiv.css("display") == "none") {
            thisDiv.show();
        } else {
            thisDiv.hide();
        }
    });
    $("#admin-cancel").on("click", function () {
        thisDiv = $("#create-admin-form");
        thisDiv.hide();

        $("#create-admin-cancel").show();
    });
    $("#admin-submit").on("click", function () {
        if($("#admin-name").val().empty() && $("#admin-email").val().empty()) {
            alert("Submission failed: please enter a name and email")
        }
        else if($("#admin-name").val().empty()) {
            alert("Submission failed: please enter a name")
        }
        else if($("#admin-email").val().empty()) {
            alert("Submission failed: please enter an email")
        }
        else {
            thisDiv = $("#create-admin-form");
            thisDiv.hide();
            $("#create-admin-submit").show();
        }
    });
    $("#admin-back").on("click", function () {
        thisDiv = $("#create-admin-cancel");
        thisDiv.hide();
    });


    $("#render_volunteer").on("click", function() {
        $("#onboard-display").empty();
        var thisButton = $(this);

        if ($("#render_org").hasClass("onboard-button-clicked")) {
            $("#render_org").removeClass("onboard-button-clicked");
        }

        thisButton.addClass("onboard-button-clicked");
        $.ajax({
            url: "/volunteer_partial",
            type: "GET",
            success: function(response) {
                console.log(response);
                $("#onboard-display").append(response);
                volunteerRouting();
                affiliationDropdown();
                enableVolunteerTags();
                scrollToAnchor('display-anchor');
            }
        });
    });
    $("#render_org").on("click", function() {
        $("#onboard-display").empty();
        var thisButton = $(this);

        if ($("#render_volunteer").hasClass("onboard-button-clicked")) {
            $("#render_volunteer").removeClass("onboard-button-clicked");
        }

        thisButton.addClass("onboard-button-clicked");
        $.ajax({
            url: "/organization_partial",
            type: "GET",
            success: function(response) {
                console.log(response);
                $("#onboard-display").append(response);
                orgRouting();
                orgNav();
                enableOrgTags();
                submitAlert();
                scrollToAnchor('display-anchor');
            }
        });
    });
});



// controlling volunteer display from next arrows
function volunteerRouting() {
    $('#volunteer-reload').click(function() {
        $("#render_volunteer").removeClass("onboard-button-clicked");
        $("#onboard-display").empty();
    });
    $("#volunteer-next-two").on("click", function() {
        if($("#volunteer-name").val()===""){
            alert("Name field required")
        }
        else{
            $("#volunteer-step-one").hide();
            $("#volunteer-step-two").show();
        }
    });

    $("#volunteer-back").on("click", function() {
        $("#volunteer-step-two").hide();
        $("#volunteer-step-one").show();
    });
    $("#volunteer-next-complete").on("click", function() {
        $("#volunteer-step-two").hide();
        $("#volunteer-complete").show();
    });

    $("#volunteer-back-two").on("click", function() {
        $("#volunteer-complete").hide();
        $("#volunteer-step-two").show();
    });
}
// switching up affiliation divs based on answer
function affiliationDropdown() {
    $("#affiliation").change(function(){
        $(".o-hidden").hide();

        var e = $("#affiliation");
        var result = e.val();

        if (result == "Undergraduate student") {
            $("#undergrad-major").show();
            $("#undergrad-year").show();

        } else if (result == "Graduate/professional student") {
            $("#grad-year").show();
            $("#grad-school").show();

        } else if (result == "Alumni") {
            $("#alumni-major").show();
            $("#alumni-year").show();

        } else if (result == "Faculty" || result == "Staff") {
            $("#staff-dept").show();
        }
    });
}
// tags on volunteer page
function enableVolunteerTags() {
    $(".volunteer-tag").on("click", function(){
        thisTag = $(this);
        if (thisTag.hasClass("volunteer-tag-checked")) {
            thisTag.removeClass("volunteer-tag-checked");
            var hiddenField = $(".hiddenTagVol[value='" + thisTag.attr("name") + "']")[0];
            hiddenField.remove();

        } else {
            thisTag.addClass("volunteer-tag-checked");
            var hiddenField = "<input class='hiddenTagVol' type='hidden' name='tags[]' value='" + thisTag.attr("name") + "'>";
            $("#volTagInputContainer").append(hiddenField);
        }
    });
}

// controlling org display from next arrows
function orgRouting() {
    $('#org-reload').click(function() {
        $("#render_org").removeClass("onboard-button-clicked");
        $("#onboard-display").empty();
    });
    $('#org-reload-2').click(function() {
        $("#render_org").removeClass("onboard-button-clicked");
        $("#onboard-display").empty();
    });

    $("#org-join-complete").on("click", function() {
        $("#org-join").hide();
        $("#org-register").hide();
        $("#org-complete").show();
    });
    $("#org-reg-complete").on("click", function() {
        $("#org-join").hide();
        $("#org-register").hide();
        $("#org-complete").show();
    });
    $("#org-back").on("click", function() {
        $("#org-register").hide();
        $("#org-complete").hide();
        $("#org-join").show();
    });
}
// switching color of organization navbar for join or register an organization
function orgNav() {
    $("#register-an-org").on("click", function() {
        console.log("hit register");

        $("#org-join").hide();
        $("#org-register").show();
    });
    $("#join-an-org").on("click", function() {
        console.log("hit join");

        $("#org-register").hide();
        $("#org-join").show();
    });
}
// tags on org page
function enableOrgTags() {
    $(".organization-tag").on("click", function(){
        thisTag = $(this);
        if (thisTag.hasClass("organization-tag-checked")) {
            thisTag.removeClass("organization-tag-checked");
            var hiddenField = $(".hiddenTag[value='" + thisTag.attr("name") + "']")[0];
            hiddenField.remove();

        } else {
            thisTag.addClass("organization-tag-checked");
            var hiddenField = "<input class='hiddenTag' type='hidden' name='tags[]' value='" + thisTag.attr("name") + "'>";
            $("#orgTagInputContainer").append(hiddenField);
        }
    });
}
// submit button alert
function submitAlert() {
    $("#join-org-alert").on("click", function() {
        text = $("#join-org-name").val();
        alert(`Please confirm that you selected the correct organization: ${text}`);
    });
}

function scrollToAnchor(aid){
    var aTag = $("a[name='"+ aid +"']");
    $('html,body').animate({scrollTop: aTag.offset().top},'slow');
}

    