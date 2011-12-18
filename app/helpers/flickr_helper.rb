module FlickrHelper

  def flickr_photos_info url
    url_portions = url.gsub("items", "item").split('/')
    entity =url_portions[url_portions.count-2]
    id = url_portions.last
    flickr.photos.search(:machine_tags => "srnsw:#{entity}=#{id}")
  end
  
  def flickr_photos_thumbs photo_info
    sizes = flickr.photos.getSizes :photo_id => photo_info.id
    thumb_url = nil    
    sizes.each do |size|
      thumb_url = size.source if size.label == "Thumbnail"
    end 
    #use the smallest if the 'Thumb' doesn't exist
    thumb_url = sizes.first if thumb_url.nil?
    thumb_url
  end
  
  def flickr_photo_tags url

    url_portions = url.gsub("items", "item").split('/')
    entity =url_portions[url_portions.count-2]
    id = url_portions.last
    
    tags = Array.new
    photos = flickr.photos.search(:machine_tags => "srnsw:#{entity}=#{id}")

    photos.each do |photo|
      
      info = flickr.photos.getInfo(:photo_id => photo.id)
            
      info.tags.each do |tag|
        tags << tag.raw
      end
    end
    tags
  end
  
end