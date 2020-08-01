$(document).ready(function(){

        thisButton = $("#interested");
        if (thisButton.text() == "I'm signed up!") {
            thisButton.css("background-color", "#B76D68");
            $("#click-again").show();
        } else {
            thisButton.css("background-color", "#686868");
        }

        featureButton = $("#featured");
        if (featureButton.text() == "Unfeature this post") {
            featureButton.css("background-color", "#0577B1");
        } else {
            featureButton.css("background-color", "#686868");
        }

        /*
        if (thisButton.hasClass("right-button-clicked")) {
          thisButton.removeClass("right-button-clicked");
          thisButton.text(clickIfText);
          console.log("make it pink");
        } else {
          thisButton.addClass("right-button-clicked");
          thisButton.text(imInterestedText);
          console.log("make it grey");
        }
        */

    $(".radio-box").on("click", function(){

        thisRadio = $(this);
        if (thisRadio.hasClass("imChecked")) {
          $(".radio-box").removeClass("imChecked");
            thisRadio.prop('checked', false);
        } else {
          $(".radio-box").removeClass("imChecked");
          thisRadio.prop('checked', true);
          thisRadio.addClass("imChecked");
        }
    });

    $(".filter-custom-tag-checked").each(function() {
        var checkedTag = $(this);

        var hiddenField = "<input class='hiddenTag' type='hidden' name='tags[]' value='" + checkedTag.attr("name") + "'>";
        $("#tagInputContainer").append(hiddenField);
    });

    $(".filter-custom-tag").on("click", function(){
        thisTag = $(this);
        if (thisTag.hasClass("filter-custom-tag-checked")) {
            thisTag.removeClass("filter-custom-tag-checked");
            var hiddenField = $(".hiddenTag[value='" + thisTag.attr("name") + "']")[0];
            hiddenField.remove();
            // thisTag.value = "off";
        } else {
            thisTag.addClass("filter-custom-tag-checked");
            // thisTag.value = "on";
            var hiddenField = "<input class='hiddenTag' type='hidden' name='tags[]' value='" + thisTag.attr("name") + "'>"
            $("#tagInputContainer").append(hiddenField);
        }
    });

    

    $(".filter-custom-tag-checked-mobile").each(function() {
        var checkedTag = $(this);

        var hiddenField = "<input class='hiddenTagMobile' type='hidden' name='mobile_tags[]' value='" + checkedTag.attr("name") + "'>";
        $("#tagInputContainerMobile").append(hiddenField);
    });

    $(".filter-custom-tag-mobile").on("click", function(){
        thisTag = $(this);
        if (thisTag.hasClass("filter-custom-tag-checked-mobile")) {
            thisTag.removeClass("filter-custom-tag-checked-mobile");
            var hiddenField = $(".hiddenTagMobile[value='" + thisTag.attr("name") + "']")[0];
            hiddenField.remove();
            // thisTag.value = "off";
        } else {
            thisTag.addClass("filter-custom-tag-checked-mobile");
            // thisTag.value = "on";
            var hiddenField = "<input class='hiddenTagMobile' type='hidden' name='mobile_tags[]' value='" + thisTag.attr("name") + "'>"
            $("#tagInputContainerMobile").append(hiddenField);
        }
    });

});
