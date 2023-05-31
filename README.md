# Sweater - MVVM(Provider + Hive + Repository)

[![License](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Github](https://img.shields.io/badge/github-jhk-orange?logo=github&logoColor=white)](https://github.com/jhk-im)

<p align="center">  
  <img src="./readme/dark1.png" width="250" height="500"/>
  <img src="./readme/dark2.png" width="250" height="500"/>
  <img src="./readme/dark3.png" width="250" height="500"/>
</p>

<p align="center">  
  <img src="./readme/light1.png" width="250" height="500"/>
  <img src="./readme/light2.png" width="250" height="500"/>
  <img src="./readme/light3.png" width="250" height="500"/>
</p>

</br>
<img src = "./readme/dark.gif" align="right" width="25%"/>

## Tech Stack

- Flutter
- MVVM Architecture (Provider + Hive + Repository)
- [Provider](https://pub.dev/packages/provider)
- [Hive](https://pub.dev/packages/hive)
- [hive_generator](https://pub.dev/packages/hive)
- [freezed](https://pub.dev/packages/freezed)
- [freezed_annotation](https://pub.dev/packages/freezed_annotation)
- [build_runner](https://pub.dev/packages/build_runner)
- [geolocator](https://pub.dev/packages/geolocator)
</br>
</br>
</br>
</br>

## Open API

`assets폴더에 .env파일을 추가하세요.`

```txt
SERVICE_KEY = '공공데이터 Service Key';
API_KEY = 'KAKAO API Key';
```

- [단기예보](https://www.data.go.kr/data/15084084/openapi.do)
- [중기예보](https://www.data.go.kr/data/15059468/openapi.do)
- [생활기상지수](https://www.data.go.kr/tcs/dss/selectApiDataDetailView.do?publicDataPk=15085288)
- [출몰시각정보](https://www.data.go.kr/tcs/dss/selectApiDataDetailView.do?publicDataPk=15012688)
- [대기오염정보](https://www.data.go.kr/tcs/dss/selectApiDataDetailView.do?publicDataPk=15073861)
- [Kakao주소검색](https://developers.kakao.com/docs/latest/ko/local/dev-guide)

</br>

## Emulator 설정

- iOS
  - Features -> Location -> Custom Location -> Latitude, Longitude 입력
  - Example -> Latitude: 37.569674 / Longitude: 126.84476 (강서구)
- Android
  - Emulator Extended Controls -> Location -> 한국 특정 지역 검색 -> Set Location

</br>

```txt
MIT License

Copyright (c) 2023 jhk

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```
