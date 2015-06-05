class Image
  attr_reader :title, :img_url, :img_ascii

  def initialize(title, img_url)
    @title = title
    @img_url = img_url
    @img_ascii = AsciiArt.new(img_url).to_ascii_art(color: true, width: 113)
  end
end