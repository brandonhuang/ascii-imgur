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
    image = imgur.render_image(imgur.image_list[image_index])

    puts
    puts image.title
    puts image.img_ascii
  end
end