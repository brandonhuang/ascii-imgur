class Interface
  attr_reader :imgur, :image_index, :images_count

  def initialize(imgur)
    @imgur = imgur
    @images_count = imgur.image_list.count
    @image_index = 0
  end

  def browse(command = nil)
    case command
    when "r"
      display_page
    when "]"
      @image_index += 1 if @image_index < images_count
      display_page
    when "["
      @image_index -= 1 if @image_index > 0
      display_page
    when "exit"
      return
    else
      puts "Unknown command"
    end

    input = gets.chomp
    browse(input)
  end

  def display_page
    puts imgur.image_list[image_index].title
    puts imgur.image_list[image_index].img_ascii
  end
end

class Website
  attr_reader :doc

  def initialize(doc)
    @doc = doc
  end

  class << self

    def create(url)
      new(fetch_html(url))
    end

    def fetch_html(url)
      doc = Nokogiri::HTML(open(url))
    end
  end
end

class Imgur < Website
  def posts_html
    doc.search('.post')
  end

  def images_html
    posts_html.select {|div| div.search('.post-info').inner_text.split(" ").first == 'image'}
  end

  def image_list
   images_html.collect do |div|
      title = div.search('.hover p').inner_text
      img_url = "http://i.imgur.com/#{div['id']}.jpg"
      Image.new(title, img_url)
    end
  end

  def self.create
    super("http://www.imgur.com/")
  end
end

class Image
  attr_reader :title, :img_url, :img_ascii

  def initialize(title, img_url)
    @title = title
    @img_url = img_url
    @img_ascii = AsciiArt.new(img_url).to_ascii_art(color: true, width: 113)
  end
end

class Comments

  def initialize(user, content)
    @user = user
    @content = content
  end
end