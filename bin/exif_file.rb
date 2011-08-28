#!/usr/bin/env ruby

this_dir = Dir.pwd
files = Dir.glob("*")

files.each do |file|
  data = `exif #{file} | grep "Date and Time  "`
  if data != ""
    regexp = %r{.*(\d\d\d\d:\d\d:\d\d).*}
    dates = data.scan(regexp)
    if dates.length == 1
      date = dates[0]
      `mkdir -p #{date} && mv -n #{file} #{date}`
    end
  end
end