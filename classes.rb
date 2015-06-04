class Image
  @@images = []
  @@image_index = 0
  attr_reader :title, :img_url

  def initialize(title, img_url)
    @title = title
    @img_url = img_url
  end

  class << self
    def import_imgs
      html = open("http://imgur.com/")
      parsed_html = Nokogiri::HTML(html)
      post_divs = parsed_html.search('.post')
      images = post_divs.select {|div| div.search('.post-info').inner_text.split(" ").first == 'image'}

      images.each do |div|
        title = div.search('.hover p').inner_text
        img_url = "http://i.imgur.com/#{div['id']}.jpg"

        @@images << new(title, img_url)
    end
    def browse(command = "")
      case command
      when "r"
        puts @@images[@@image_index].title
        puts AsciiArt.new(@@images[@@image_index].img_url).to_ascii_art(color: true, width: 113)
      when "]"
        @@image_index += 1 if @@image_index < @@images.count
        puts @@images[@@image_index].title
        puts AsciiArt.new(@@images[@@image_index].img_url).to_ascii_art(color: true, width: 113)
      when "["
        @@image_index -= 1 if @@image_index > 0
        puts @@images[@@image_index].title
        puts AsciiArt.new(@@images[@@image_index].img_url).to_ascii_art(color: true, width: 113)
      when "exit"
        return
      end

      input = gets.chomp
      browse(input)
    end

      # puts AsciiArt.new(img_url).to_ascii_art(color: true)
      # images.each {|div| puts div.search('.post-info').inner_text}
      # title = parsed_html.search('.post .hover p').collect {|p| p.inner_text}
      # image_ids = parsed_html.search('.post').collect {|div| div['id']}
    end
  end
end

class Comments

  def initialize(user, content)
    @user = user
    @content = content
  end
end