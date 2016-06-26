require "../src/string_inflection/agid"

SUMMARY = {} of String => Int32

def diff(singular, plural, substring = nil)
  substring ||= plural
  raise "unmatched forms: #{singular} #{plural}" if substring.size == 0
  if singular.starts_with?(substring)
    {cut: plural.size - substring.size, tail: singular[(substring.size)..-1]}
  else
    diff(singular, plural, substring[0..-2])
  end
end

PATTERNS = [
  /hes$/,
  /oes$/,
  /ses$/,
  /xes$/,
  /zes$/,
  /men$/,
  /ies$/,
]

File.open(__DIR__ + "/../src/string_inflection/plurals.cr", "w") do |f|
  f.puts <<-EOS
  module StringInflection
    @@plurals = {
  EOS

  StringInflection::Agid.plurals_singulars.each do |plural, singular|
    diff = diff(singular, plural)
    if diff[:cut] == 1 && diff[:tail] == ""
      if PATTERNS.all?{|i| i !~ plural}
        SUMMARY["-"] ||= 0
        SUMMARY["-"] += 1
        next
      end
    elsif diff[:cut] == 1 && diff[:tail] == "um"
      cuttail = "1  um!#{plural[(-[plural.size, 3].min)..-1]}"
      SUMMARY[cuttail] ||= 0
      SUMMARY[cuttail] += 1
    elsif diff[:cut] == 1 && diff[:tail] == "us"
      cuttail = "1  us!#{plural[(-[plural.size, 3].min)..-1]}"
      SUMMARY[cuttail] ||= 0
      SUMMARY[cuttail] += 1
    elsif diff[:cut] == 2 && diff[:tail] == ""
      cuttail = "2  !#{plural[(-[plural.size, 3].min)..-1]}"
      SUMMARY[cuttail] ||= 0
      SUMMARY[cuttail] += 1
      next if (/hes$/ =~ plural)
      next if (/oes$/ =~ plural)
      next if (/ses$/ =~ plural)
      next if (/xes$/ =~ plural)
      next if (/zes$/ =~ plural)
    elsif diff[:cut] == 2 && diff[:tail] == "an"
      cuttail = "2  an!#{plural[(-[plural.size, 3].min)..-1]}"
      SUMMARY[cuttail] ||= 0
      SUMMARY[cuttail] += 1
      next if (/men$/ =~ plural)
    elsif diff[:cut] == 2 && diff[:tail] == "is"
      cuttail = "2  is!#{plural[(-[plural.size, 3].min)..-1]}"
      SUMMARY[cuttail] ||= 0
      SUMMARY[cuttail] += 1
      # next if (/ses$/ =~ plural)
    elsif diff[:cut] == 3 && diff[:tail] == "y"
      cuttail = "3  y!#{plural[(-[plural.size, 3].min)..-1]}"
      SUMMARY[cuttail] ||= 0
      SUMMARY[cuttail] += 1
      next if (/ies$/ =~ plural)
    end
    cuttail = "#{diff[:cut].to_s.ljust(2)} #{diff[:tail]}"
    SUMMARY[cuttail] ||= 0
    SUMMARY[cuttail] += 1
    f.puts <<-EOS
        "#{plural}" => #{diff.inspect},
    EOS
  end

  f.puts <<-EOS
    }
    def self.plurals
      @@plurals
    end
  end
  EOS
end

SUMMARY.keys.sort.each do |cuttail|
  next if SUMMARY[cuttail] < 50
  puts "#{cuttail.ljust(15)}: #{SUMMARY[cuttail]}"
end
