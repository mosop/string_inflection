require "./common"

module StringInflection
  def self.pascal(s, **options)
    s.gsub(/[\s\-]+/, "_").camelcase
  end
end
