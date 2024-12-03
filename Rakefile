require './app'
require 'net/http'

DAY_RANGE = 1..25

namespace :solve do
  DAY_RANGE.each do |i|
    number = i.to_s
    desc "Solve day #{number}"
    task number.to_sym do
      Message.text "Running solution for day #{number}..."
      Solve.day(i)
    end
  end
end

namespace :test do
  DAY_RANGE.each do |i|
    number = i.to_s
    desc "Test day #{number}"
    task number.to_sym do
      Message.text "Running tests for day #{number}..."
      Test.day(i)
    end
  end
end

namespace :download do
  DAY_RANGE.each do |i|
    number = i.to_s
    task number.to_sym do
      session_path = File.join(ROOT, '.session')

      unless File.file?(session_path)
        Message.error "Copy session cookie to ./.session"
        return
      end

      Message.text "Downloading puzzle input for day #{number}"

      response = Net::HTTP.get_response(
        URI("https://adventofcode.com/2024/day/#{number}/input"),
        { 'Cookie' => "session=#{File.read(session_path)}" }
      )

      input = if response.code == '200'
        response.body
      end

      if input
        File.write(File.join(ROOT, 'puzzle_input', "day#{number}.txt"), input)
        Message.success "Download successful! Created puzzle_input/day#{number}.txt"
      else
        Message.error "Download failed! #{response.message}"
      end
    end
  end
end
