module StringInflectionTest
  define_method :plural
  expect_method :plural, "child", "children"
end
