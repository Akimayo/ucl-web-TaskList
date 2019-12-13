$(document).on("turbolinks:load", function() {
    $("input#task_deadline_at").each(function() {
        // I want HTML date input, which simple_form cannot do
        let content = $(this).val().split(" ")[0];
        $(this).val(content).attr("type", "date");
    });
    $("form.edit_task label.task-done-state").on("click", function() {
        // Labels were being derpy, so fixed it hardcore
        $(this).parent().find("input#task_is_done").trigger("click");
    });
    $("form.edit_task input#task_is_done").on("change", function() {
        // Automatically submit task.is_done form on is_done change
        // Render change before DOM is re-rendered
        $(this).parent().find(".task-done-state").toggleClass("active");
        $(this).parents("form.edit_task").trigger("submit");
    });
    $(".task-info .category-link").each(function() {
        /* SVGs cannot be colorified using style, so might as well do it in
           one place along with thext styling */
        let color = $(this).data("entity-color");
        $(this).css({ textDecorationColor: color });
        $(this).find("path").css({ fill: color });
    });
    $(".task-info .tag-link").each(function() {
        /* SVGs cannot be colorified using style, so might as well do it in
           one place along with thext styling */
        let color = $(this).data("entity-color");
        $(this).find("a").css({ textDecorationColor: color });
        $(this).find("path").css({ fill: color });
    });
    $(".list_is_done input[type=checkbox]").on("change", function() {
        // Allows only zero or one checked items in Is done/
        let sender = $(this);
        console.debug(sender);
        $(this).parents(".list_is_done").find("input[type=checkbox]").each(function() {
            if($(this).val() != sender.val() && sender.is(":checked") && sender.is(":checked") == $(this).is(":checked"))
                $(this).trigger("click");
        });
    });
    // Workaround for re-checking checkboxes for categories, tags and is_done
    if($("input#categories_selected").length > 0 && $("input#categories_selected").val() !== "\"\"") {
        JSON.parse(JSON.parse($("input#categories_selected").val())).forEach(id => {
            $("input#list_categories_"+id).trigger("click");
        });
    }
    if($("input#tags_selected").length > 0 && $("input#tags_selected").val() !== "\"\"") {
        JSON.parse(JSON.parse($("input#tags_selected").val())).forEach(id => {
            $("input#list_tags_"+id).trigger("click");
        });
    }
    if($("input#is_done_selected").length > 0 && $("input#is_done_selected").val() !== "") {
        $("input#list_is_done_" + $("input#is_done_selected").val()).trigger("click");
    }
    // Multiple destroy button visibility
    let toggleMultiDeleteButton = function() {
        let any = false;
        let checks = $("input[type=checkbox].mdi");
        for(let i = 0; i < checks.length; i++) {
            if($(checks[i]).is(":checked")) {
                any = true;
                break;
            }
        }
        if(any) $("#multiple-destroy-call").slideDown("fast");
        else $("#multiple-destroy-call").slideUp("fast");
    }
    toggleMultiDeleteButton();
    $("input[type=checkbox].mdi").on("change", function() {
        toggleMultiDeleteButton();
    });
});