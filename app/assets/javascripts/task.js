$(document).ready(function(){
  // セレクトボックスが変更されたら送信
  $("#sort_tasks_select").change(function(){
    const value = $("#sort_tasks_select").val();
    if (value) {
      $('#sort_tasks_form').submit();
    }
  });
});
