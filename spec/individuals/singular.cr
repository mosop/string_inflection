module StringInflectionTest
  define_method :singular
  expect_method :singular, "data", "datum"
end
