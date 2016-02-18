# Project 3 - *MovieViewer*

**MovieViewer** is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: **13** hours spent in total

## User Stories

The following **required** functionality is completed:

- [x] User can view a list of movies currently playing in theaters. Poster images load asynchronously.
- [x] User can view movie details by tapping on a cell.
- [x] User sees loading state while waiting for the API.
- [x] User sees an error message when there is a network error.
- [x] User can pull to refresh the movie list.

The following **optional** features are implemented:

- [ ] Add a tab bar for **Now Playing** and **Top Rated** movies.
- [ ] Implement segmented control to switch between list view and grid view.
- [x] Add a search bar.
- [ ] All images fade in.
- [x] For the large poster, load the low-res image first, switch to high-res when complete.
- [x] Customize the highlight and selection effect of the cell.
- [x] Customize the navigation bar.

The following **additional** features are implemented:

- [x] Customize table view.
- [x] Customize status bar text color.
- [x] Use cool Swift features like `guard`, `defer`, and `IBInspectable`. 
- [x] Color coordinate detail page to each movie poster. (Even the heart image!)
- [ ] I messed around with blur on DetailsView but ended up preferring transparency.

## Video Walkthrough

Here's a walkthrough of implemented user stories:

<img src='http://i.imgur.com/hsBsqro.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

I've marked a bunch of issues I ran into with TODOs and GitHub comments, mostly around style questions.

I used [UIImageColors](https://github.com/jathu/UIImageColors) to customize colors to each poster, but for some reason it slows things down when using `imageView.setImageWithURL:placeholderImage:`, though it works fine with `imageView.setImageWithURL:`. 

I messed around with blur and vibrancy on DetailsView, but ran into a subview cycle since it's a custom view. I'd love to chat more about this in person. 

## License

Copyright 2016 Daniel Moreh

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.