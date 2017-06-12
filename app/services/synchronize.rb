class Synchronize

  def self.call(*args)
    new(*args).call
  end


  def call
    if initial
      clear_db
      res = client.sync(initial: true, type: 'Entry', content_type: Product.content_type)
    else
      res = client.sync(SyncTrace.last.sync_url)
    end
    res.each_item do |resource|
      ActiveRecord::Base.transaction do
        brand_entry = client.entry(resource.fields[:brand].id)
        brand = Brand.create_from_entry(brand_entry)
        product = Product.create_from_entry(resource, brand)
        create_tags(resource.fields[:tags], product)
        create_categories(resource.fields[:categories], product)
        create_images(resource.fields[:image], product)
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

  def create_images(image_fields, product)
    product.images.destroy_all
    if image_fields
      image_fields.each do |image|
        image_asset = client.asset(image.id)
        image_fields = image_asset.fields.select do |k,v|
          Image.column_names.include?(k.to_s)
        end.merge({url: image_asset.url})
        product.images << Image.create(image_fields)
      end
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
      Category.create_from_entry(cat_entry, product)
    end
  end
end
