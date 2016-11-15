module StringInflectionTest
  define_method :snake
  expect_two_words :snake, "foo_bar"
end
