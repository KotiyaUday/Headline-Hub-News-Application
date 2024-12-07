# Headline Hub (HH News)

Welcome to **Headline Hub (HH News)**, a mobile application built using Flutter. This application combines the functionality of fetching the latest news headlines and weather updates, providing users with a seamless and user-friendly experience.

## Features

### 1. User Management
- **Registration**: Create an account to personalize your experience.
- **Login**: Secure authentication for returning users.
- **Profile Management**: Update your password and manage your profile details.

### 2. News Functionality
- **Latest Headlines**: View the most recent news updates.
- **Category-specific News**: Select specific categories to filter news (e.g., sports, technology, politics, etc.).
- **Search News**: Search for news articles based on specific topics or keywords.

### 3. Weather Updates
- **Current Weather**: View the weather conditions for predefined locations.
- **Search Weather**: Look up the weather for your own city or any location of interest.

### 4. Intuitive User Interface
- Clean and minimalistic design for a seamless user experience.
- Easy navigation between news and weather sections.

### 5. Responsive Design
- Fully responsive UI for compatibility across various device sizes.

## Technical Stack
- **Frontend**: Flutter (Dart)
- **Backend Services**: Integration with external APIs (NewsData API, WeatherAPI)
- **State Management**: Provider for managing application state efficiently.
- **Storage**: Secure local storage for user data.

## Core Workflow
1. **User Authentication**: 
   - New users register with their details.
   - Returning users log in securely.
2. **Fetching News Data**:
   - The app connects to the NewsData API to fetch the latest headlines and category-specific articles.
   - Users can search for specific topics or keywords.
3. **Fetching Weather Data**:
   - The app retrieves real-time weather data from WeatherAPI for predefined cities.
   - Users can search for weather updates in their desired locations.
4. **Profile Management**:
   - Users can update their password within the app.

## Development Challenges
- **API Rate Limits**: Ensuring the app remains functional without exceeding API request limits.
- **State Management**: Efficiently managing application state across multiple features using Provider.
- **Error Handling**: Implementing robust error handling to manage API failures and network connectivity issues.
- **UI Responsiveness**: Ensuring a consistent and smooth user experience across various device sizes.

## APIs Used

### News Data API
The application fetches news data using the [NewsData API](https://newsdata.io/). Below is an example of the API endpoint used:
```plaintext
https://newsdata.io/api/1/latest?apikey=pub_6154705eff46b74dsfsdgfdg7eee9f266854faf59610a7&category=top&language=en
```

### Weather Data API
Weather data is retrieved using the [WeatherAPI](https://www.weatherapi.com/). An example endpoint is shown below:
```plaintext
https://api.weatherapi.com/v1/current.json?key=e8de875adfdssdfd1264214a7754459240508&q=Mumbai&aqi=no
```

## Screenshots
Here are some screenshots of the application:
### Registration Page
![Registration Page](https://github.com/KotiyaUday/Headline-Hub-News-Application/blob/main/assets/Application%20Image/Registration%20Page.jpeg)
### Login Page
![Login Page](https://github.com/KotiyaUday/Headline-Hub-News-Application/blob/main/assets/Application%20Image/Login%20Page.jpeg)
### Home Screen 
![Home Screen 1](https://github.com/KotiyaUday/Headline-Hub-News-Application/blob/main/assets/Application%20Image/Home%20Page%201.jpeg)
![Home Screen 2](https://github.com/KotiyaUday/Headline-Hub-News-Application/blob/main/assets/Application%20Image/Home%20Page%202.jpeg)
### News Search Page
![News Search Page](https://github.com/KotiyaUday/Headline-Hub-News-Application/blob/main/assets/Application%20Image/Search%20Page.jpeg)
### Description Page
![Description Page](https://github.com/KotiyaUday/Headline-Hub-News-Application/blob/main/assets/Application%20Image/Description%20Page.jpeg)
### Weather Page
![Weather Page](https://github.com/KotiyaUday/Headline-Hub-News-Application/blob/main/assets/Application%20Image/Weather%20Page.jpeg)
### Weather Search Page
![Weather Search Page](https://github.com/KotiyaUday/Headline-Hub-News-Application/blob/main/assets/Application%20Image/Weather%20Search%20Page.jpeg)
### Profile Page
![Profile Page](https://github.com/KotiyaUday/Headline-Hub-News-Application/blob/main/assets/Application%20Image/Profile%20Page.jpeg)
### Change Password Page
![Change Password Page](https://github.com/KotiyaUday/Headline-Hub-News-Application/blob/main/assets/Application%20Image/Change%20Password%20Page.jpeg)

## Download the App
Download the APK to experience the app:

[Download APK](https://github.com/KotiyaUday/Headline-Hub-News-Application/raw/refs/heads/main/assets/APK/app-release.apk)

## How to Run the App
1. Clone this repository:
   ```bash
   git clone https://github.com/KotiyaUday/Headline-Hub-News-Application.git
   ```
2. Navigate to the project directory:
   ```bash
   cd news_weather_app
   ```
3. Install dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app:
   ```bash
   flutter run
   ```

## About the Project
This application was developed as part of my internship project. It showcases my skills in Flutter development and integration of third-party APIs. I believe this project reflects my ability to create feature-rich, user-friendly applications.


## Contributing
Feel free to contribute to the project by submitting issues or pull requests.

## License
This project is licensed under the MIT License. See the LICENSE file for more details.

-------

Thank you for checking out my project! I hope you enjoy using the app as much as I enjoyed creating it.
