By Maretta Morovitz, Maggie Chapman, Jerry Hu, Courtney Won, Aaron Forrest

****************************************************************************
*
*			Introduction
*
****************************************************************************
mOTivator is a hardware device and iOS software application for the iPhone, designed 
for pediatric patients with a wide variety of disabilities receiving treatment from a
OT. 

mOTivator incorporates functional activities into daily life, outside of OT sessions,
to allow for increased patient autonomy, motivation, and utilization of support networks.
In combination, these factors contribute better, longer lasting, recovery for pediatric patients.

Patients using mOTivator will wear a bracelet that monitors accelerometer and gyro data to detect 
when a scheduled task has been sucessfully completed. Patients work with OTs to schedule
weekly tasks. Data monitor confirms wether or not a specific task, during a specific time range,
has been completed. If not, a deisgnated caretaker is notified to assist the patient with the task.
Finally, data aggregation algorithms present the data to highlight trends in the task completion data 
for the OT.
****************************************************************************
*
*			System Requirements
*
****************************************************************************
iOS 
-iOS 9.2
-XCode 7.3
-iPhone 6s+

Server
-nodeJS

Arduino
-Arduino YUN
-Arduino 1.6.8
-Sparkfun 6 Degrees of Freedom IMU Digital Combo Board - ITG3200/ADXL345

****************************************************************************
*
*			Running instructions
*
****************************************************************************
iOS
build and run mOTivator.xcodeproj

Arduino
upload ADXK345
configure to Wifi

****************************************************************************
*
*			Future Work
*
****************************************************************************
- Add additional tasks 
- Fully integrate the support network notification system
- Multiple interfaces for different users
- More robust detection algorithms
- Less bulky hardware design
- Interface for patient to continue with independent scheduling after finished
with OT
****************************************************************************
*
*			Known Bugs & Issues
*
****************************************************************************
On 5/9 at 1am the YUN was disconnected from the YUN network and reset for a mobile hotspot
network. However, after holding the reset button for ~20 seconds we were no longer able to 
access the YUN, while connected to the YUN access point network at [YUN NAME].local/ We could
only access using the borwser interface through the default arduino ip (192.168.240.1). It then 
appeared to allow us to configure the wifi. However after seeing the restart screen 
complete sucessfully, we would click "find me here" and the redirected site would not 
be online. Any attempt to access the YUN via ssh would fail either due to host not found
or invalid password. Network analysis showed that the YUN was connected to the network and pinging
the ip was sucessful, but we were unable to get into the board. We are 100% confident that we were 
using the correct password.

Server can not handle files with large amounts of data. When it tries to read such a file the wifi
connection drops.

Server does absolutely 0 error checking...have fun with that. 

