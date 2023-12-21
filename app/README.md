# High 👋

HighFive is an application focused towards digital learning in remote areas with limited internet connectivity. As we all know, in today's times, Digital Education is very much needed and also lays the foundation of learning. It was in the olden times when books were the only major source of study. Nowadays, we've a lot of content available through digital mediums, and using them is very crucial to stay relevant in the race of gaining knowledge.

Highfive provides a way for a physical classroom to share the data amongst each other, without requiring internet. It is powered by Raspberry Pi 4 that helps in setting up a WiFi Access Point (Hotspot) and a Web Server to serve the files and the content.

The users could be of two types:- teacher or a student. Teacher would have features like uploading files and putting up announcements, and participating in chat, pretty much like Google Classroom but offline. On the other hand, students could download the files, view announcements and chat as well. All they require is a mobile phone with valid WiFi connection to the raspberry Pi, of who's password shall be told by the teacher to the students!

# Tools and Frameworks
- Flutter framework for building the mobile application.
- Raspberry Pi 4 - 1GB RAM for creating a WiFi Access Point.
- Python and Flask for setting up web server on Raspberry Pi.
- dnsmasq and hostapd for setting up hotspot and DHCP routing in Raspberry Pi.

# Running Locally

## Mobile App
- ```dart pub get```
- ```flutter run```

## Flask App
- ```pip install -r requirements.txt```
- ```python3 app.py```