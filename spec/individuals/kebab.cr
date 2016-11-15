module StringInflectionTest
  define_method :kebab
  expect_two_words :kebab, "foo-bar"
end
