class Synchronize

  def self.call(*args)
    new(*args).call
  end


  def call
    clear_db if initial
    res = client.sync(initial: true, type: 'Entry', content_type: Product.content_type)
    res.each_item do |resource|
      ActiveRecord::Base.transaction do
        brand = create_brand(resource.fields[:brand].id)
        product = create_product(resource, brand)
      end
    end
    SyncTrace.create(sync_url: res.next_sync_url)
  end


  private
  attr_reader :initial

  def initialize(initial: false)
    @initial = initial
  end

  def clear_db
    Brand.destroy_all
    Tag.destroy_all
    Category.destroy_all
  end

  def client
    @client ||= Contentful::Client.new(
      access_token: ENV['access_token'],
      space: ENV['space_id'],
      default_locale: 'en-US'
    )
  end

  def create_brand(brand_id)
    brand_entry = client.entry(brand_id)
    brand_fields = brand_entry.fields.select do |k,v|
      Brand.column_names.include?(k.to_s)
    end.merge({
      logo: brand_entry.fields[:logo].url,
      contentful_id: brand_id 
    })
    brand = Brand.find_or_create_by(brand_fields)
    create_brand_phones(brand_entry.fields[:phone], brand)
    brand
  end

  def create_brand_phones(phone_fields, brand)
    if phone_fields
      phone_fields.each do |phone|
        brand.phones << Phone.create(number: phone)
      end
    end
  end

  def create_product(product_entry, brand)
    product_fields = product_entry.fields.select do |k,v|
      Product.column_names.include?(k.to_s)
    end.merge({
      contentful_id: product_entry.id
    })
    product = Product.new(product_fields)
    product.brand = brand
    product.save
    create_images(product_entry.fields[:image], product)
    create_tags(product_entry.fields[:tags], product)
    create_categories(product_entry.fields[:categories], product)
  end

  def create_images(image_fields, product)
    image_fields.each do |image|
      image_asset = client.asset(image.id)
      image_fields = image_asset.fields.select do |k,v|
        Image.column_names.include?(k.to_s)
      end.merge({url: image_asset.url})
      product.images << Image.create(image_fields)
    end

  end

  def create_tags(tag_fields, product)
    if tag_fields
      tag_fields.each do |tag_field|
        tag = Tag.find_or_create_by(name: tag_field)
        tag.products << product
      end
    end
  end

  def create_categories(category_fields, product)
    category_fields.each do |cat|
      cat_entry = client.entry(cat.id)
      cat_fields = cat_entry.fields.select do |k,v|
        Category.column_names.include?(k.to_s)
      end.merge({
        icon: cat_entry.fields[:icon].url,
        contentful_id: cat.id
      })
      category = Category.find_or_create_by(cat_fields)
      category.products << product
    end
  end
end
