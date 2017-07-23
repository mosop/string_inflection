require "./common"
require "./plurals"

module StringInflection
  PLURAL_SEPARATOR_PATTERN = /[^a-zA-Z0-9]|[a-z0-9](?=[A-Z])/
  PLURAL_SUFFIXES = [
    {re: /([hosxz])es$/i, tail: ["", ""]},
    {re: /ies$/i, tail: ["y", "Y"]},
    {re: /(m)en$/i, tail: ["an", "AN"]},
  ]

  def self.singular(this, **options)
    a = this.split(PLURAL_SEPARATOR_PATTERN)
    s = a.last.dup
    dicts = options[:dicts]? || [PLURALS]
    tail = options[:up]? ? 1 : 0
    if (begin
      downcased = s.downcase
      diff = nil
      dicts.any?{|dict| diff = dict[downcased]?}
      diff && (s = s[0..(-1 - diff[:cut])] + diff[:tail][tail])
    end)
    else
      unless PLURAL_SUFFIXES.any?{|i|
        if md = i[:re].match(s)
          s = "#{md.pre_match}#{md[1]?}#{i[:tail][tail]}"
        end
      }
        s = s.rchop
      end
    end
    this[0, this.size - a.last.size] + s
  end
end
