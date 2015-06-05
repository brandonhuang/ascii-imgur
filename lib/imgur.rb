class Imgur
  attr_reader :image_list, :doc

  def initialize
    @doc = self.class.fetch_html("http://www.imgur.com/")
    @image_list = images_html
  end

  def posts_html
    doc.search('.post')
  end

  def images_html
    posts_html.select {|div| div.search('.post-info').inner_text.split(" ").first == 'image'}
  end

  def render_image(div)
    title = div.search('.hover p').inner_text
    img_url = "http://i.imgur.com/#{div['id']}.jpg"
    Image.new(title, img_url)
  end

  def self.fetch_html(url)
    doc = Nokogiri::HTML(open(url))
  end
end