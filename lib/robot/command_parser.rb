class Robot::CommandParser

  attr_accessor :text

  def initialize(text = nil)
    @text = text
  end

  def command
    if text.include?('PLACE')
      "PLACE"
    else
      text.strip
    end
  end

  def arguments
    regexp_match = text.match(/\ ([^)]+)/)
    match_string = regexp_match ? regexp_match[1] : nil
    if match_string
      args_array = match_string.split(',')
    end
    args_array || []
  end
end