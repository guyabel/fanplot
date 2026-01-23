usethis::use_cran_badge()
cranlogs::cranlogs_badge(package_name = "fanplot", summary = "grand-total")
usethis::use_lifecycle_badge(stage = "superseded")
usethis::use_news_md()
usethis::use_readme_rmd()
# usethis::use_citation()
usethis::use_build_ignore(
  c("build_package.R", "hex", 
     "README", "vignettes", "README_files", "net-elicit", 
    "data-raw")
)

roxygen2::roxygenise()

devtools::check(args = "--as-cran")
devtools::check()
devtools::build()
usethis::use_data(th.mcmc, overwrite = TRUE)


file.show("NEWS.md")

usethis::use_pkgdown()
pkgdown::build_site_github_pages()
pkgdown::build_site(run_dont_run = TRUE)
pkgdown::build_reference()

usethis::use_spell_check()

usethis::use_github_action("check-standard.yaml", ref = "v4")
usethis::use_github_action("pkgdown")
usethis::use_github_actions_badge()
usethis::use_github_actions_badge()
usethis::use_github_action()

usethis::use_git()
usethis::use_github()

