good_data <- extrip
wrong_col_name <- good_data
missing_values <- good_data
wrong_date_fmt <- good_data
wrong_num_fmt <- good_data

names(wrong_col_name)[names(wrong_col_name) == "group"] <- "bad_name"

missing_values["country"][missing_values["country"] == "Norway"] <- ""

wrong_date_fmt$arrival <- as.character(wrong_date_fmt$arrival)
wrong_date_fmt["arrival"][wrong_date_fmt["arrival"] == "2022-08-10"] <- "10-AUG-2022"

wrong_num_fmt$duration_days <- as.character(wrong_num_fmt$duration_days)
wrong_num_fmt["duration_days"][wrong_num_fmt["duration_days"] == 3] <- "wrong"

testthat::test_that("Correct dataset passes", {
  testthat::expect_equal(validate_dataset(good_data), TRUE)
})

testthat::test_that("Wrong column names fails", {
  testthat::expect_match(validate_dataset(wrong_col_name), "required columns are not present")
})

testthat::test_that("Missing values fails", {
  testthat::expect_match(validate_dataset(missing_values), "Rows cannot be left empty")
})

testthat::test_that("Wrong date format fails", {
  testthat::expect_match(validate_dataset(wrong_date_fmt), "should be in YYYY-MM-DD format")
})

testthat::test_that("Wrong numeric fields fails", {
  testthat::expect_match(validate_dataset(wrong_num_fmt), "values should be numbers")
})
