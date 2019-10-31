files <- list.files("./slides_source", pattern = ".Rmd", full.names = TRUE)
for(file in files){
  rmarkdown::render(file, output_dir = "./slides", knit_root_dir = getwd(), 
                    output_options = list(lib_dir = "../slides/slides_libs", css = "style.css"))
}
