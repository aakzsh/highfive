# HighFive
The absence of reliable offline sharing platforms usable within classrooms remains a significant concern that needs addressing. Access to quality education shouldn't be restricted by limited internet connectivity. There's a pressing need for a universally accessible offline digital education solution.

Introducing HighFive, an innovative offline digital education platform designed as an Android application. Through this app, teachers can securely log in using their admin credentials to create a classroom. Each classroom will be connected via a dedicated Wi-Fi network created by a Raspberry Pi, and students can join by connecting to this Wi-Fi network using the provided password.

Initially, the plan involves using the teacher's mobile device to create the server. However, the aim is to transition to employing a Raspberry Pi for the same purpose. This shift not only alleviates the load on the teacher's phone but also enhances connection speed and security.

Once connected, students can engage in various activities such as exchanging text messages, downloading files uploaded by the teacher, participating in polls, and more—all facilitated through a shared web server on the same network, eliminating the need for data usage. Meanwhile, teachers can disseminate announcements, share text, upload files, and manage classroom activities seamlessly.

HighFive revolutionizes classroom interaction and the sharing of digital information, fostering an inclusive and engaging educational experience regardless of internet availability.

# Running Locally
Ideally, this would require a hardware piece called the Raspberry Pi 4. I used the 1gb RAM variant of the same. But, it can work with your PC acting as a web server as well!

## Steps
- ```git clone https://github.com/aakzsh/highfive```

### Server Setup
- ``cd server``
- ``pip3 install -r requirements.txt``
- ``flask run --host=0.0.0.0``

### App Setup
- ``cd app``
- ``dart pub get``
- ``flutter run``

## Demo Video
https://youtu.be/XfMp2dKuLfs?feature=shared