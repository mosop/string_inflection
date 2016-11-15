require "./common"

module StringInflection
  def self.kebab(s, **options)
    s.gsub(/[\s\-]+/, "_").underscore.gsub(/_/, "-")
  end
end
