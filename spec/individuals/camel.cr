module StringInflectionTest
  define_method :camel
  expect_two_words :camel, "fooBar"
end
