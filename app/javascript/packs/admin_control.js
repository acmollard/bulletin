$(document).ready(function(){
    statsToggle();

    $("#stats-tab").on('click', function(){
        if ($("#stats-tab").hasClass("admin-nav-active")){
            return;
        } else {
            $("#stats-tab").removeClass("admin-nav-inactive");
            $("#stats-tab").addClass("admin-nav-active");
            if ($("#requests-tab").hasClass("admin-nav-active")){
                $("#requests-tab").removeClass("admin-nav-active");
                $("#requests-tab").addClass("admin-nav-inactive");
            };
            if ($("#orgs-tab").hasClass("admin-nav-active")){
                $("#orgs-tab").removeClass("admin-nav-active");
                $("#orgs-tab").addClass("admin-nav-inactive");
            };
            $("#tab-display").empty();
            $.ajax({
                url: "/stat",
                tyle: "GET",
                success: function(response) {
                    console.log(response);
                    $("#tab-display").append(response);
                    statsToggle();
                }
            });
        }
    });

    $("#requests-tab").on('click', function(){
        if ($("#requests-tab").hasClass("admin-nav-active")){
            return;
        } else {
            $("#requests-tab").removeClass("admin-nav-inactive");
            $("#requests-tab").addClass("admin-nav-active");
            if ($("#stats-tab").hasClass("admin-nav-active")){
                $("#stats-tab").removeClass("admin-nav-active");
                $("#stats-tab").addClass("admin-nav-inactive");
            };
            if ($("#orgs-tab").hasClass("admin-nav-active")){
                $("#orgs-tab").removeClass("admin-nav-active");
                $("#orgs-tab").addClass("admin-nav-inactive");
            };
            $("#tab-display").empty();
            $.ajax({
                url: "/requests",
                tyle: "GET",
                success: function(response) {
                    console.log(response);
                    $("#tab-display").append(response);
                }
            });
        }
    });

    $("#orgs-tab").on('click', function(){
        if ($("#orgs-tab").hasClass("admin-nav-active")){
            return;
        } else {
            $("#orgs-tab").removeClass("admin-nav-inactive");
            $("#orgs-tab").addClass("admin-nav-active");
            if ($("#requests-tab").hasClass("admin-nav-active")){
                $("#requests-tab").removeClass("admin-nav-active");
                $("#requests-tab").addClass("admin-nav-inactive");
            };
            if ($("#stats-tab").hasClass("admin-nav-active")){
                $("#stats-tab").removeClass("admin-nav-active");
                $("#stats-tab").addClass("admin-nav-inactive");
            };
            $("#tab-display").empty();
            $.ajax({
                url: "/organizations",
                tyle: "GET",
                success: function(response) {
                    console.log(response);
                    $("#tab-display").append(response);
                }
            });
        }
    });
});

function statsToggle() {
    $('#weekly-button').on('click', function(){
        $('#weekly-button').addClass('is-light');
        $('#yearly-button').removeClass('is-light');
        $('#weekly-hours-graph').show();
        $('#yearly-hours-graph').hide();
    });

    $('#yearly-button').on('click', function(){
        $('#yearly-button').addClass('is-light');
        $('#weekly-button').removeClass('is-light');
        $('#yearly-hours-graph').show();
        $('#weekly-hours-graph').hide();
    });

    $('#amount-button').on('click', function(){
        $('#amount-button').addClass('is-light');
        $('#percentage-button').removeClass('is-light');
        $('#amount-bar').show();
        $('#percentage-bar').hide();
    });

    $('#percentage-button').on('click', function(){
        $('#percentage-button').addClass('is-light');
        $('#amount-button').removeClass('is-light');
        $('#percentage-bar').show();
        $('#amount-bar').hide();
    });
}