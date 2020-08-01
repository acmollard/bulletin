$(document).ready(function(){

    if ($("#edit-checkbox").prop("checked") == true) {
        $("#edit-date-time").hide();
        $("#edit-volunteer-inputs").hide();
    }
    if ($("#clone-checkbox").prop("checked") == true) {
        $("#clone-date-time").hide();
        $("#clone-volunteer-inputs").hide();
    }
    if ($("#edit-approval-checkbox").prop("checked") == true) {
        $("#edit-approved-text").show();
    }
    if ($("#clone-approval-checkbox").prop("checked") == true) {
        $("#clone-approved-text").show();
    }

    $(".signup-dropdown").on("click", function () {
        var thisDiv = $(".signups");
        var thisArrow = $(".signup-arrow");
  
        if (thisArrow.hasClass("signup-arrow-flip") ) {
            thisArrow.removeClass("signup-arrow-flip");
            thisDiv.hide();
        } else {
            thisArrow.addClass("signup-arrow-flip");
            thisDiv.show();
        }
    });
    $("#new-approval-checkbox").on("click", function(){
        thisBox = $(this);
        if (thisBox.prop("checked") == true) {
            $("#new-approved-text").show();
        } else {
            $("#new-approved-text").hide();
        }
    });
    $("#edit-approval-checkbox").on("click", function(){
        thisBox = $(this);
        if (thisBox.prop("checked") == true) {
            $("#edit-approved-text").show();
        } else {
            $("#edit-approved-text").hide();
        }
    });
    $("#clone-approval-checkbox").on("click", function(){
        thisBox = $(this);
        if (thisBox.prop("checked") == true) {
            $("#clone-approved-text").show();
        } else {
            $("#clone-approved-text").hide();
        }
    });

    $(".new-custom-tag-checked").each(function() {
        var checkedTag = $(this);

        var hiddenField = "<input class='hiddenTag' type='hidden' name='tags[]' value='" + checkedTag.attr("name") + "'>";
        $(".tagInputContainer").append(hiddenField);
    });

    $(".new-custom-tag").on("click", function(){
        thisTag = $(this);
        if (thisTag.hasClass("new-custom-tag-checked")) {
            thisTag.removeClass("new-custom-tag-checked");
            var hiddenField = $(".hiddenTag[value='" + thisTag.attr("name") + "']")[0];
            hiddenField.remove();

        } else {
            thisTag.addClass("new-custom-tag-checked");
            var hiddenField = "<input class='hiddenTag' type='hidden' name='tags[]' value='" + thisTag.attr("name") + "'>";
            $(".tagInputContainer").append(hiddenField);
        }
    });

    $("#like-org-profile").on("click", function(){
        thisButton = $(this);
        if (thisButton.hasClass("right-button-clicked")) {
            thisButton.removeClass("right-button-clicked");
        } else {
            thisButton.addClass("right-button-clicked");
        }
    });

    $(".thumb-icon-posting").on("click", function(){
        thisButton = $(this);
        if (thisButton.hasClass("thumb-icon-posting-check")) {
            thisButton.removeClass("thumb-icon-posting-check");
        } else {
            thisButton.addClass("thumb-icon-posting-check");
        }
    });
    $(".thumb-icon-profile").on("click", function(){
        thisButton = $(this);
        if (thisButton.hasClass("thumb-icon-profile-check")) {
            thisButton.removeClass("thumb-icon-profile-check");
        } else {
            thisButton.addClass("thumb-icon-profile-check");
        }
    });

    $("#new-checkbox").on("click", function(){
        thisBox = $(this);
        if (thisBox.prop("checked") == true) {
            $("#new-date-time").hide();
            $("#new-volunteer-inputs").hide();
        } else {
            $("#new-date-time").show();
            $("#new-volunteer-inputs").show();
        }
    });
    
    $("#feedback-checkbox").on("click", function(){
        thisBox = $(this);
        if (thisBox.prop("checked") == true) {
            $("#feedback-inputs").show();
        } else {
            $("#feedback-inputs").hide();
        }
    });

    $("#edit-checkbox").on("click", function(){
        thisBox = $(this);
        if (thisBox.prop("checked") == true) {
            $("#edit-date-time").hide();
            $("#edit-volunteer-inputs").hide();
        } else {
            $("#edit-date-time").show();
            $("#edit-volunteer-inputs").show();
        }
    });
    $("#clone-checkbox").on("click", function(){
        thisBox = $(this);
        if (thisBox.prop("checked") == true) {
            $("#clone-date-time").hide();
            $("#clone-volunteer-inputs").hide();
        } else {
            $("#clone-date-time").show();
            $("#clone-volunteer-inputs").show();
        }
    });
});