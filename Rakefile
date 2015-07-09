# coding: utf-8

desc 'Execute unit tests'
task :test do
  ruby %{ test/test_frame.rb }
  ruby %{ test/test_frame_parser.rb }
  ruby %{ test/test_game.rb }
end

task default: [:test]