require "./common"

module StringInflection
  def self.camel(s, **options)
    s.gsub(/[\s\-]+/, "_").camelcase.sub(/^./){|s| s.downcase}
  end
end
