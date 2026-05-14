# DSP Audio Signal Manipulation App

## Project Overview
This project is a comprehensive Digital Signal Processing (DSP) application featuring a Graphical User Interface (GUI) developed in **MATLAB App Designer**. The application allows users to record, manipulate, and visualize audio signals in real-time. 

## Key Features
* **Signal Generation:** Generate fundamental signals such as Sine waves (Beep sound) and Gaussian White Noise.
* **Audio Recording & Playback:** Built-in capability to record audio directly from the microphone and play it back.
* **Noise Manipulation:** * Add Gaussian White Noise (AWGN) to an audio signal.
  * Implement noise removal techniques to purify the audio.
* **Audio Effects (Filtering & Convolution):**
  * **Echo Effect:** Applies an echo to the audio signal using a custom-built Convolution function (`myConv`) without relying entirely on built-in MATLAB filtering functions.
* **Signal Transformation:** Real-time adjustment of audio volume (scaling) and playback speed (time stretching).
* **Data Visualization:** The GUI includes multiple interactive plots to display the time-domain representation of:
  * Original and manipulated audio signals.
  * The impulse response used for the echo effect.
  * Generated noise and beep signals.

## Tools & Technologies
* **Environment:** MATLAB / MATLAB App Designer
* **Core Concepts:** Convolution, Audio Filtering, AWGN, Signal Visualization.

## Repository Structure
* `Audio_1.mlapp`: The main MATLAB App Designer file containing the GUI and backend logic.
* `DSP Project.m`: MATLAB scripts containing custom DSP functions (e.g., custom convolution `myConv`).
* `/Screenshots`: Contains images of the running application interface.

## Academic Context
This project was developed as part of the Digital Signal Processing (DSP) coursework at the Faculty of Computers and Artificial Intelligence, Fayoum University, demonstrating practical implementation of signal manipulation theories.
