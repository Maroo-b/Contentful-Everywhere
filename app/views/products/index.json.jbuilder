json.array! @products do |product|
  json.product_name product.product_name
  json.slug product.slug
  json.product_description product.product_description
  json.sizetypecolor product.sizetypecolor
  json.images product.images, :title, :description, :url
  json.tags product.tags, :name
  json.categories product.categories, :title, :icon, :category_description
  json.price product.price
  json.brand do
    json.company_name product.brand.company_name
    json.logo product.brand.logo
    json.description product.brand.description
    json.webiste product.brand.website
    json.twitter product.brand.twitter
    json.email product.brand.email
    json.phones product.brand.phones, :number
  end
  json.quantity product.quantity
  json.sku product.sku
  json.website product.website
end
