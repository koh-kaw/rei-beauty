json.extract! post, :id, :title, :content, :category_id, :price, :created_at, :updated_at
json.url post_url(post, format: :json)