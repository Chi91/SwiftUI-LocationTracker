# Reminder App for Mr. Kaiser - README

Welcome to the Reminder App for Mr. Kaiser! This app helps Mr. Kaiser keep track of important tasks during his walks by reminding him of specific actions he needs to complete at designated locations. The app uses GPS data to monitor certain stations along the route and provides appropriate notifications.

## Project Overview

This app is designed to assist Mr. Kaiser during his walks by reminding him of tasks he needs to complete at specific stations along his route. The route is based on the GPS track `Berlin100.gpx`.

## Features

- **Important Stations**: Six key stations are defined along the route, each with a title and reminder content.
- **Geometric Definition**: Each station is defined as a circle or rectangle, not as a point.
- **User Interface**: Six buttons on the application window, each labeled with the title and reminder content of the corresponding station.
- **Button Color Changes**: At app startup, all buttons are red. When Mr. Kaiser reaches a station, the corresponding button turns yellow, and after the task is completed, it turns green.
- **Notifications**:
  - **Sound Alert**: A sound alert is played when a station is reached.
  - **Alert**: An alert with the title and reminder content is shown and automatically closes after 5 seconds.
  - **Button Interaction**: Clicking the button changes its color from yellow to green, marking the task as completed.


### Technologies Used

- **SwiftUI**: For building the user interface.
- **CoreLocation**: For GPS navigation and location tracking.
