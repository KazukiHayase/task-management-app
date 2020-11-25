# Ruby on Rails on Docker



## テーブルスキーマ
### モデル名
- User
- Task
- Label

### テーブル構造(カラム名/データ型)
- User  
id/integer  
name/string  
password/string  
admin/boolean  

- Task  
id/integer  
name/string  
content/text  
deadline/date  
status/integer  
priority/integer  
user_id/integer  

- Label
id/integer  
name/string  
task_id/integer

## デプロイ方法
herokuにログイン後下記コマンドでデプロイ

```
    git push heroku master
    heroku run rails db:migrate
```
### [デプロイ先](https://desolate-gorge-93288.herokuapp.com/tasks)

### Versions
- Ruby 2.6.2
- Ruby on Rails 5.2.4.4


