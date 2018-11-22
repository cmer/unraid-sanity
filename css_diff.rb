#!/usr/bin/env ruby
require 'open-uri'

GITHUB_USER          = 'limetech'
GITHUB_REPO          = 'webgui'
DIFF_TOOL            = 'ksdiff'  # ksdiff or diff
OPEN_TMP_DIR_ON_EXIT = true

WEBGUI_URL_TEMPLATE  = "https://github.com/#{GITHUB_USER}/#{GITHUB_REPO}/archive/{version}.tar.gz"
RELEASES_URL         = "https://github.com/#{GITHUB_USER}/#{GITHUB_REPO}/releases"
RANDOM               = Time.now.to_i
TMP_DIR              = "/tmp/unraid-dl-#{RANDOM}"

supported_version = File.open('./UNRAID_VERSION', &:readline).chomp
latest_version    = open(RELEASES_URL).read.match(/\/#{GITHUB_USER}\/#{GITHUB_REPO}\/releases\/tag\/([\d\.]*)/i)[1].chomp

puts "Current supported version: #{supported_version}"
puts "Latest Unraid version: #{latest_version}\n"

if supported_version == latest_version
  puts "Latest version is already supported. Nothing to diff."
  exit 1
end

puts "Downloading & extracting Unraid v#{supported_version}..."
`mkdir -p #{TMP_DIR}/old`
`cd #{TMP_DIR}; wget -O old.tar.gz #{WEBGUI_URL_TEMPLATE.sub('{version}', supported_version)} > /dev/null 2>&1`
`tar xfz #{TMP_DIR}/old.tar.gz --strip-components=2 -C #{TMP_DIR}/old > /dev/null`

puts "Downloading & extracting Unraid v#{latest_version}..."
`mkdir -p #{TMP_DIR}/new`
`cd #{TMP_DIR}; wget -O new.tar.gz #{WEBGUI_URL_TEMPLATE.sub('{version}', latest_version)} > /dev/null 2>&1`
`tar xfz #{TMP_DIR}/new.tar.gz --strip-components=2 -C #{TMP_DIR}/new > /dev/null`

puts "Removing all unnecessary files..."
`cd #{TMP_DIR}; rm *.tar.gz`
files = Dir["./theme/*"].map { |f| f.split('/').last }.uniq

%w(old new).each do |dir|
  del_cmd = "find #{TMP_DIR}/#{dir}/ -type f ! \\("
  files.each do |f|
    del_cmd += " -name \"#{f}\" "
    del_cmd += "-o " unless files.last == f
  end
  del_cmd += "\\) -delete; find #{TMP_DIR}/#{dir}/ -type d -empty -delete"

  `#{del_cmd}`
end

if DIFF_TOOL == 'diff'
  `diff -r -E -b -w -B #{TMP_DIR}/old #{TMP_DIR}/new`
elsif DIFF_TOOL == 'ksdiff'
  `ksdiff #{TMP_DIR}/old #{TMP_DIR}/new`
else
  puts "Invalid diff tool: #{DIFF_TOOL}. Exiting."
  exit 1
end

`open #{TMP_DIR}` if OPEN_TMP_DIR_ON_EXIT