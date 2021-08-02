usethis::use_cran_badge()
usethis::use_lifecycle_badge(stage = "superseded")
usethis::use_news_md()
usethis::use_readme_rmd()
# usethis::use_citation()
usethis::use_build_ignore(
  c("build_package.R", "hex", 
     "README", "vignette", "README_files")
)

roxygen2::roxygenise()

devtools::check()
devtools::build()

file.show("NEWS.md")

usethis::use_pkgdown()
pkgdown::build_site(run_dont_run = TRUE)
pkgdown::build_reference()

usethis::use_spell_check()

