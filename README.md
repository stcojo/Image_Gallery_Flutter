
<!-- PROJECT 
-->
<br />
<p align="center">
  <a href="https://github.com/othneildrew/Best-README-Template">
    <img src="https://user-images.githubusercontent.com/17060399/110951190-71ce5480-834d-11eb-8474-319e45179927.jpg" alt="Logo" width="30%">
  </a>

  <h3 align="center">Flutter gallery (Progressive Web App)</h3>

<!-- ABOUT THE PROJECT -->
## About The Project

Progressive Web App (PWA) built with Dart and the Flutter framework. The same codebase is used for running on Android, iOS, Web and even desktop apps.
The app is a gallery / wallpaper finder app, which fetches data from a remote endpoint and displays images using a grid view and a page view. Hero (shared element) transitions are used to achieve a seamless experience.

<p><h4>Running natively by using the Flutter apps</h4>

The app is compiled to platform specific apps (iOS or Android) and runs normally by installing the app.
 
<img src="output2.gif" />                 
<h4>Running in the mobile browser</h4>

<a href="https://flutter.dev/docs/development/tools/sdk/release-notes/release-notes-2.0.0">Flutter 2.0</a> introduced stable web support and compiling for web is very easy, assuming all used plugins are web compatible. 
The web version of the app is hosted on Firebase and works on desktop and mobile browsers. 
It can be used a regular Web App or it can installed as a standalone app by opening the URL and choosing to install the PWA.

Try the web app for yourself: https://gardenapp-c9105.web.app/

<img src="output.gif" />

<h4>Running on a desktop browser</h4>

The web app is responsive and the code decides how to scale the columns based on the available screen space. 
Certain elements will only be displayed on the Web app, such as the arrows to navigate left/right.

Try the web app for yourself: https://gardenapp-c9105.web.app/

![2021-03-12 (2)](https://user-images.githubusercontent.com/17060399/110955636-79442c80-8352-11eb-8eb5-d06124b528b9.png)
![new](https://user-images.githubusercontent.com/17060399/110955647-7c3f1d00-8352-11eb-87e1-53c3c77675e6.png)



### Built With

* [Flutter](https://flutter.dev/)
* [Dart language](https://dart.dev/)


<!-- GETTING STARTED -->
## Concepts used

* Dio network client: https://pub.dev/packages/dio
* Flutter Navigation: https://flutter.dev/docs/development/ui/navigation
* Shared preferences: https://pub.dev/packages/shared_preferences
* Photo view library: https://pub.dev/packages/photo_view
* Drag down to pop transitions: https://pub.dev/packages/drag_down_to_pop
* Flutter Toast: https://pub.dev/packages/fluttertoast

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.

<!-- CONTACT -->
## Contact

Feel free to email if you have any questions about the concepts used or any questions about the app in general.

Stefan Cojocaru - stefan.cojocaru@microsoft.com

Project Link: [Flutter Gallery PWA](https://github.com/stcojo/Image_Gallery_Flutter)

[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/othneildrew/Best-README-Template.svg?style=for-the-badge
[contributors-url]: https://github.com/othneildrew/Best-README-Template/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/othneildrew/Best-README-Template.svg?style=for-the-badge
[forks-url]: https://github.com/othneildrew/Best-README-Template/network/members
[stars-shield]: https://img.shields.io/github/stars/othneildrew/Best-README-Template.svg?style=for-the-badge
[stars-url]: https://github.com/othneildrew/Best-README-Template/stargazers
[issues-shield]: https://img.shields.io/github/issues/othneildrew/Best-README-Template.svg?style=for-the-badge
[issues-url]: https://github.com/othneildrew/Best-README-Template/issues
[license-shield]: https://img.shields.io/github/license/othneildrew/Best-README-Template.svg?style=for-the-badge
[license-url]: https://opensource.org/licenses/MIT
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/stefangeorgecojocaru
[product-screenshot]: app.png
