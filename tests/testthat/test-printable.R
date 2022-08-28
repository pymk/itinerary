test_that("Print returns a {reactable} object", {
  expect_equal(object = attributes(printable(mtcars))$package, expected = "reactable")
})
