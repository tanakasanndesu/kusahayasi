## 概要
実装途中となっている`spec/system/task_spec.rb`を修正してください。

各テストケースに修正内容をコメントしています。
```
・FIXME --> テストが失敗するので、成功するよう修正をお願いします。
・TODO --> テストは成功しますが、記載事項に沿ってリファクタリングしてください。
```

## 環境構築
1. リポジトリをfork
2. `git clone`して`cd rspec_app_exam`で移動
3. 修正用ブランチを`git checkout -b fix_testcode`で作成
4. specファイルを修正して、テスト実行
実行コマンド `rspec spec/system/task_spec.rb`

## 備考
・`spec/support/driver_setting.rb` にspec実行時のブラウザON/OFFの切替設定があります。
`driven_by(:selenium_chrome_headless)` をコメントアウトし、
`driven_by(:selenium_chrome)` のコメントを外すことでspec実行時にブラウザが起動します。

・失敗するテストケースは実行時にPendingになるよう`xit`にしています。`xit`を`it`に変更してテストコードを修正してください。

・`it`を`fit`にするとspec実行時にそのテストケースのみ実行するようfocusしてくれます。またspecファイルでは`byebug`も使用できます。
※ 詳しくは`spec/spec_helper.rb`を確認してください。

・`.rspec` という設定ファイルに `--format documentation` を設定しているため、spec実行時に describeやit以下の文字列をコンソールに表示させています。

## FIXMEのヒント
・`it 'Project詳細からTask一覧ページにアクセスした場合、Taskが表示されること'` は、まず何が起きているかを整理し、何故テストが失敗するかを考えてください。（一旦後回しにしても良いです。）

・`it 'Taskを編集した場合、一覧画面で編集後の内容が表示されること'` はテスト対象のコードも併せて確認した方が良いと思います。

・`it 'Taskが削除されること'` は削除処理自体が成功しているかどうかなど、問題の切り分けを行ってください。原因が判明した場合、画面や他のテストケースを手がかりにして修正してください。

## 原因調査時のヒント
・`page.body`をbyebugで実行してください

・テスト失敗時には`tmp/screenshots`フォルダ以下に画面キャプチャが保存され、確認することが出来ます。（このフォルダは`git ignore`されています。）

## 進め方の注意
・修正の際には、適切な単位でコミットを分け（細かければ良いと言う訳ではないです）、コミットメッセージは以下のURLを参考にしてください。
https://www.tam-tam.co.jp/tipsnote/program/post16686.html

・PRの概要には、レビュアーに対してどんな情報を伝えるべきかを考えて記載しましょう。

# 注意点
- cloneする前に、forkしたかどうかを確認しましょう。
- pushする前に、作業ブランチをcheckoutしているかを確認しましょう。
- PRを作成する際は、forkしたリポジトリに対してPRを作成できているかを確認しましょう。
- 課題に記載されている注意事項は、漏れなく確認しましょう。
- （確認を怠る人に対して）現場でも「よく読んでいなかった」から適当に作業するつもりですか？？
