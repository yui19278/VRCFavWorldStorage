## モデル要件定義

### テーブル

world
属性

- id int, 主キー
- name string, ワールドネーム 必須
- launch_url string, https://vrchat.com/...
- description string null 可
- created_at, updated_at timestamp

Tag

- id int, 主キー
- name string, 一意・必須
- created_at, updated_at timestamp

- UNIQUE で二重付与防止

Tagging

- world_id 外部キー
- tag_id 外部キー
- created_at, updated_at timestamp

## ルーティング要件定義

root home#index
resouce: worlds [
GET / index DB 内のワールド一覧
GET /new new 新規 DB 保存
POST / create new で入力したデータの保存
GET /:id/edit edit DB 編集
PUT /:id/ update 編集 DB の更新
DELETE /:id destory DB 保存の削除
collection GET /worlds/search vrcAPI でワールド検索
後から追加する箇所
自動ログインのメンテ用 API
GET 最近表示 10 件のワールドを表示

## arcitecture 構成

後日追記

## サイトマップ

![sitemap](https://github.com/user-attachments/assets/011e831d-d8b5-4dfc-a6ef-d0b60634c9ca)

## ワイヤーフレーム

![wireflame](https://github.com/user-attachments/assets/225b9edb-37d2-4802-afda-2efa3d59f161)
