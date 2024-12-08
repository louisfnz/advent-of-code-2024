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

namespace :template do
  DAY_RANGE.each do |i|
    number = i.to_s
    desc "Create template for day #{number}..."
    task number.to_sym do
      Message.text "Creating template for day #{number}..."

      day_file = File.join(ROOT, 'lib', 'days', "day#{number}.rb")
      if File.file?(day_file)
        Message.error "Day#{number} already exists, skipping..."
      else
        File.write(day_file, File.read(File.join(ROOT, 'templates', 'Day.txt')).gsub('{number}', number))
        Message.success "Created Day#{number}!"
      end

      test_file = File.join(ROOT, 'lib', 'tests', "day#{number}_test.rb")
      if File.file?(test_file)
        Message.error "Day#{number}Test already exists, skipping..."
      else
        File.write(test_file, File.read(File.join(ROOT, 'templates', 'DayTest.txt')).gsub('{number}', number))
        Message.success "Created Day#{number}Test!"
      end
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
