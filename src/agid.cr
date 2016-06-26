module StringInflection
  module Agid
    class Word
      POSES = {"N" => :N, "A" => :A, "V" => :V}

      @pos : Symbol
      getter :pos

      @spell : String
      getter :spell

      @plural : String
      getter :plural

      @tags = %w()
      getter :tags

      def self.import(line)
        new(line)
      end

      def initialize(line)
        raise line unless (/^([\w']+)\s([NAV])\??:\s([\w']+)(~?)(<?)(!?)(\??)/ =~ line)
        @spell = $1
        @pos = POSES[$2]
        @plural = $3
        @tags << $4 unless $4.empty?
        @tags << $5 unless $5.empty?
        @tags << $6 unless $6.empty?
        @tags << $7 unless $7.empty?
      end
    end

    @@singulars_plurals = {} of String => String
    @@plurals_singulars = {} of String => String
    def self.singulars_plurals; @@singulars_plurals; end
    def self.plurals_singulars; @@plurals_singulars; end

    import_words

    def self.import_words
      File.each_line(__DIR__ + "/../ext/agid/infl.txt") do |line|
        word = Word.import(line)
        next unless word.pos == :N && word.tags.size == 0
        singular = word.spell.downcase
        plural = word.plural.downcase
        @@singulars_plurals[singular] = plural
        @@plurals_singulars[plural] = singular
      end
    end
  end
end
