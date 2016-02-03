# Shoppu

Shoppu is a web-based, multi-device app that provides a platform for connecting customers and personal shoppers with each other.

### Try it at http://shoppuapp.herokuapp.com/

*Heads-up: As of Dec. 1, 2015, this app uses the free tier of Amazon S3, which expires after 12 months. Therefore, the image-uploading feature may break in the future, unless other arrangements are made.*

### Running the app locally
A file with environment constants _(shoppu\config\application.yml)_ is required to run the app locally. For more info, please contact existing developers.

##### Installation steps:
1. Install ImageMagick (http://www.imagemagick.org/)
2. Copy over application.yml file to 276-g16\shoppu\config\
3. Open terminal with Ruby on Rails environment, change directory to 276-g16\shoppu\, and enter:
```
gem install rmagick // See comment below!
bundle install
rake db:migrate
bin\rails server
```

\* Basic form; this command will likely require additional arguments. It is highly recommended to follow a platform-specific guide for this step.

### Authors
| Name            | Initials  |
| --------------- |:---------:|
| Mengying "Nico" | N         |
| Karan           | K         |
| Agnes Carissa   | A         |
| Terrence        | T         |
| Cheng "Mike"    | M         |

### References
* Child, M. (2014, October 12). How To Build A Todo App In Rails 4. Retrieved November 10, 2015, from https://www.youtube.com/watch?v=fd1Vn-Wvy2w
* Hartl, M. (2015). Ruby on rails tutorial: Learn web development with rails (Third ed.).
