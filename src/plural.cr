require "./common"
require "./singulars"

module StringInflection
  SINGULAR_SEPARATOR_PATTERN = /[^a-zA-Z0-9]|[a-z0-9](?=[A-Z])/
  SINGULAR_SUFFIXES = [
    {re: /([sxz])$/i, tail: ["es", "ES"]},
    {re: /y$/i, tail: ["ies", "IES"]},
    {re: /(m)an$/i, tail: ["en", "EN"]},
  ]

  def self.plural(this, **options)
    a = this.split(SINGULAR_SEPARATOR_PATTERN)
    s = a.last.dup
    dicts = options[:dicts]? || [SINGULARS]
    tail = options[:up]? ? 1 : 0
    if (begin
      downcased = s.downcase
      diff = nil
      dicts.any?{|dict| diff = dict[downcased]?}
      diff && (s = s[0..(-1 - diff[:cut])] + diff[:tail][tail])
    end)
    else
      unless SINGULAR_SUFFIXES.any?{|i|
        if md = i[:re].match(s)
          s = "#{md.pre_match}#{md[1]?}#{i[:tail][tail]}"
        end
      }
        s += (options[:up]? ? 'S' : 's')
      end
    end
    this[0, this.size - a.last.size] + s
  end
end
