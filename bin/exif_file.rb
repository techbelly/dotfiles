#!/usr/bin/env ruby

this_dir = Dir.pwd
files = Dir.glob("**/*.JPG") + Dir.glob("**/*.jpg") + Dir.glob("**/*.jpeg")

files.each do |file|
  data = `exif "#{file}" | grep "Date and Time  "`
  md5 = `md5 -q "#{file}"`.strip[0..10]
  if data != ""
    regexp = %r{.*(\d\d\d\d:\d\d:\d\d).*}
    dates = data.scan(regexp)
    if dates.length > 0
      date = dates[0]
      dir = date
      `mkdir -p #{date} && mv -n "#{file}" #{date}/#{md5}.jpg`
    end
  end
end
