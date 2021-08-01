library(magick)
library(sysfonts)
library(hexSticker)
font_add("harlow", "HARLOWSI.TTF")

s <- image_read(path = "https://gjabel.files.wordpress.com/2012/08/fanplot-sv2.png")

sticker(s, package="fanplot",
        p_size = 40, p_color = "grey20",
        p_family = "harlow",
        p_y = 1.1,
        s_x = 2, s_y = 1.5,
        s_width=5, s_height=5,
        filename="./hex/logo.png",
        # spotlight = TRUE, l_x = 0.25,
        h_color = "grey20",
        h_fill = "grey20", white_around_sticker = TRUE)

file.show("./hex/logo.png")



p <- image_read("./hex/logo.png")
pp <-
  p %>%
  # image_rotate(180) %>%
  # image_chop(geometry = "x1") %>%
  # image_rotate(180) %>%
  # image_extent(geometry = "518x600", gravity = "north") %>%
  image_fill(color = "transparent", refcolor = "white",
             fuzz = 75, point = "+1+1") %>%
  image_fill(color = "transparent", refcolor = "white",
             fuzz = 75, point = "+517+1") %>%
  image_fill(color = "transparent", refcolor = "white",
             fuzz = 75, point = "+1+590") %>%
  image_fill(color = "transparent", refcolor = "white",
             fuzz = 75, point = "+510+590")
image_write(image = pp, path = "./hex/logo_transp.png")
file.show("./hex/logo_transp.png")

usethis::use_logo(img = "./hex/logo_transp.png")

