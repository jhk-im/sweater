// AddressCard
const kCurrentLocationId = 'current_location_id'; // 현재위치 주소 id
const kCreateWidgetId = 'create_widget_id'; // 생성하려는 경우 로컬에 추가하지 않ㅇ므

// SharedPreferences key
const kLocationPermission = 'location_permission'; // 위치 권한 toggle
const kNotificationPermission = 'notification_permission'; // 알림 권한 toggle
const kFahrenheit = 'fahrenheit'; // 화씨 toggle
const kOnBoard = 'on_board'; // 화씨 toggle
const kYesterdayHumidity = 'yesterday_humidity';
const kTodayMaxTemperature = 'today_max_temperature';
const kTodayMinTemperature = 'today_min_temperature';
const kTodayAmRainPercentage = 'today_am_rain_percentage';
const kTodayPmRainPercentage = 'today_pm_rain_percentage';
const kTodayAmStatus = 'today_am_status';
const kTodayPmStatus = 'today_pm_status';
const kTodayMaxFeel = 'today_max_feel';
const kTodayMinFeel = 'today_min_feel';
const kTomorrowMaxTemperature = 'tomorrow_max_temperature';
const kTomorrowMinTemperature = 'tomorrow_min_temperature';
const kTomorrowAmRainPercentage = 'tomorrow_am_rain_percentage';
const kTomorrowPmRainPercentage = 'tomorrow_pm_rain_percentage';
const kTomorrowAmStatus = 'tomorrow_am_status';
const kTomorrowPmStatus = 'tomorrow_pm_status';

// WeatherCardIDs
const kWeatherCardTime = 'weather_card_time'; // 시간대별 날씨
const kWeatherCardWeek = 'weather_card_week'; // 주간 날씨
const kWeatherCardDust = 'weather_card_dust'; // 대기질
const kWeatherCardRain = 'weather_card_rain'; // 강수
const kWeatherCardHumidity = 'weather_card_humidity'; // 습도
const kWeatherCardFeel = 'weather_card_feel'; // 체감온도
const kWeatherCardWind = 'weather_card_wind'; // 바람
const kWeatherCardSun = 'weather_card_sun'; // 일출, 일몰
const kWeatherCardUltraviolet = 'weather_card_ultraviolet'; // 자외선

// WeatherCategory
const kWeatherCategoryTemperature = 'T1H';
const kWeatherCategoryTemperatureShort = 'TMP';
const kWeatherCategoryHumidity = 'REH';
const kWeatherCategoryRain = 'RN1';
const kWeatherCategoryRainStatus = 'PTY';
const kWeatherCategoryWindSpeed = 'WSD';
const kWeatherCategoryWindDirection = 'VEC';
const kWeatherCategorySky = 'SKY';
const kWeatherCategoryRainPercent = 'POP';

// 단기 예보
const List<String> kBaseTimeList = [
  '2300',
  '2300',
  '2300',
  '0200',
  '0200',
  '0200',
  '0500',
  '0500',
  '0500',
  '0800',
  '0800',
  '0800',
  '1100',
  '1100',
  '1100',
  '1400',
  '1400',
  '1400',
  '1700',
  '1700',
  '1700',
  '2000',
  '2000',
  '2000',
];

const Map<String, String> kMidCode = {
  '서울특별시, 인천광역시, 경기도': '11B00000',
  '고성, 속초, 양양, 강릉, 동해, 삼척, 태백': '11D10000',
  '강원도, 철원, 화천, 춘천, 양구, 인제, 홍천, 횡성, 평창, 정선, 영월': '11D20000',
  '대전광역시, 세종특별자치시, 충청남도': '11C20000',
  '충청북도': '11C10000',
  '광주광역시, 전라남도': '11F20000',
  '전라북도': '11F10000',
  '대구광역시, 경상북도': '11H10000',
  '부산광역시, 울산광역시 경상남도': '11H20000',
  '제주도': '11G00000',
};

const Map<String, int> kStatusStates = {
  '비' : 0,
  '비/눈' : 0,
  '소나기' : 0,
  '빗방울' : 0,
  '빗방울/눈날림' : 0,
  '눈' : 1,
  '눈날림' : 1,
  '맑음' : 2,
  '구름많음' : 3,
  '흐림' : 4,
};

const List<String> kWeatherWeekIconList = [
  'drizzle',
  'blizzard',
  'clear',
  'cloudy_clear',
  'cloudy',
];

const kWeatherIconList = [
  'drizzle',
  'blizzard',
  'clear',
  'night_clear',
  'cloudy_clear',
  'night_cloudy_clear',
  'cloudy'
];

const Map<String, String> kWeatherStatus = {
  'drizzle': '비',
  'blizzard': '눈',
  'clear': '맑음',
  'night_clear': '맑음',
  'cloudy_clear': '구름 조금',
  'night_cloudy_clear': '구름 조금',
  'cloudy': '흐림',
};

const Map<String, String> kCityName = {
  '서울특별시, 서울시, 서울': '서울',
  '충청북도, 충북': '충북',
  '충청남도, 충남': '충남',
  '경기도, 경기': '경기',
  '강원도, 강원특별자치도, 강원': '강원',
  '경상남도, 경남': '경남',
  '경상북도, 경북': '경북',
  '전라남도, 전남': '전남',
  '전라북도, 전북': '전북',
  '제주도, 제주특별자치도, 제주': '제주',
  '세종시, 세종특별자치시, 세종': '세종',
  '부산시, 부산광역시, 부산': '부산',
  '대구시, 대구광역시, 대구': '대구',
  '인천시, 인천광역시, 인천': '인천',
  '광주시, 광주광역시, 광주': '광주',
  '대전시, 대전광역시, 대전': '대전',
  '울산시, 울산광역시, 울산': '울산',
};
