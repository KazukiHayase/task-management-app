def sort(text)
    select(text, from: "sort_tasks_select")
    page.evaluate_script("$('#sorttasks_select').trigger('change')")
    sleep 1
end

def login(user)
    visit login_path
    fill_in "メールアドレス", with: user.email 
    fill_in "パスワード", with: user.password 
    click_button "ログイン"
end
