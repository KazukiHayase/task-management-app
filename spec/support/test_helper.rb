def sort(text)
    select(text, from: "sort_tasks_select")
    page.evaluate_script("$('#sorttasks_select').trigger('change')")
    sleep 1
end
