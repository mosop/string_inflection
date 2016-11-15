require "./common"

module StringInflection
  def self.snake(s, **options)
    s.gsub(/[\s\-]+/, "_").underscore
  end
end
