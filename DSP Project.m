classdef Audio_1 < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                   matlab.ui.Figure
        EditField2                 matlab.ui.control.EditField
        EditField2Label            matlab.ui.control.Label
        EditField                  matlab.ui.control.EditField
        EditFieldLabel             matlab.ui.control.Label
        defultsuondsPanel          matlab.ui.container.Panel
        UIAxes                     matlab.ui.control.UIAxes
        UIAxes_4                   matlab.ui.control.UIAxes
        subplotPanel               matlab.ui.container.Panel
        UIAxes2_3                  matlab.ui.control.UIAxes
        UIAxes2_2                  matlab.ui.control.UIAxes
        UIAxes2                    matlab.ui.control.UIAxes
        multiply2audioButton       matlab.ui.control.Button
        subtract2audioButton       matlab.ui.control.Button
        speed1Button_2             matlab.ui.control.Button
        removenoiseButton          matlab.ui.control.Button
        speed1Button               matlab.ui.control.Button
        volum1Button_2             matlab.ui.control.Button
        echotheaudioButton         matlab.ui.control.Button
        volum1Button               matlab.ui.control.Button
        addnoiseButton             matlab.ui.control.Button
        playaudioButton            matlab.ui.control.Button
        recordaudio1Button         matlab.ui.control.Button
        whitenoisesoundButton      matlab.ui.control.Button
        beepsoundButton            matlab.ui.control.Button
        signalmanipulatingLabel    matlab.ui.control.Label
        signalmanipulatingLabel_2  matlab.ui.control.Label
        UIAxes4                    matlab.ui.control.UIAxes
        UIAxes_3                   matlab.ui.control.UIAxes
    end

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: beepsoundButton
        function beepsoundButtonPushed(app, event)
          T=2;
          fm=500;
          fs1=20000;
          [x1,t1] =sin_NU(fs1,fm,T);
          cla;
          % t = (0:size(x1,1)-1)/fs1;
          plot(app.UIAxes_4,t1,x1)  
          xlabel(app.UIAxes_4,'Time (s)')
          ylabel(app.UIAxes_4,'Amplitude')
          title(app.UIAxes_4,'beep sound')
          % axis tight
          xlim(app.UIAxes_4,[0,0.001])
          grid on
          soundsc(x1,fs1)
        end

        % Button pushed function: whitenoisesoundButton
        function whitenoisesoundButtonPushed(app, event)
            fs=8000;
            time=2;
            N=fs*time;
            t = linspace(0,time,N);
            A=0.1;
            x=A*rand(1,N)*2-1;           
            cla;
            plot(app.UIAxes,t,x)  
            xlabel(app.UIAxes,'Time (s)')
            ylabel(app.UIAxes,'Amplitude')
            title(app.UIAxes,'white noise')
            xlim(app.UIAxes,[0 0.01])
            grid on
            sound(x,fs) 
        end

        % Button pushed function: recordaudio1Button
        function recordaudio1ButtonPushed(app, event)
            fs=44100;
            time=5;
            recObj1=audiorecorder(fs,16,1);%define object of recorder
            disp('start speaking');
            recordblocking(recObj1,time);
            disp('end of reco');
            x=getaudiodata(recObj1);
            audiowrite('Audio1.wav',x,fs);
        end

        % Button pushed function: playaudioButton
        function playaudioButtonPushed(app, event)
            [x,fs]=audioread('Audio1.wav');
            t = (0:size(x,1)-1)/fs;
            plot(app.UIAxes4,t,x)  
            xlabel(app.UIAxes4,'Time (s)')
            ylabel(app.UIAxes4,'Amplitude')
            title(app.UIAxes4,'Audio')
            axis tight
            grid on
            sound(x,fs);
        end

        % Button pushed function: addnoiseButton
        function addnoiseButtonPushed(app, event)
            % Read audio file
            [y, fs] = audioread('Audio1.wav');
            % Add Gaussian white noise
            snr = 5;  % Signal-to-noise ratio in dB
            y_noisy = awgn(y, snr, 'measured');
            % Play the original and noisy audio     
            sound(y_noisy, fs);
        end

        % Button pushed function: removenoiseButton
        function removenoiseButtonPushed(app, event)
            % Read audio file
            [y, fs] = audioread('Audio1.wav');
            % Add Gaussian white noise
            snr = 105;  % Signal-to-noise ratio in dB
            y_noisy = awgn(y, snr, 'measured');
            % Play the original and noisy audio
            sound(y_noisy, fs);
        end

        % Button pushed function: echotheaudioButton
        function echotheaudioButtonPushed(app, event)
           [y,fs]=audioread('Audio1.wav');
           h=[1,zeros(1,0.4*fs),0.5,zeros(1,0.4*fs),0.25];%fs=100 / 40 -> 0
           echo=conv(y,h);
           t = (0:size(y,1)-1)/fs;

           plot(app.UIAxes2,echo)
           title(app.UIAxes2,'echo')
           xlabel(app.UIAxes2,'Time (s)')
           ylabel(app.UIAxes2,'Amplitude')

           plot(app.UIAxes2_2,h)
           title(app.UIAxes2_2,'impluse')
           xlabel(app.UIAxes2,'Time (s)')
           ylabel(app.UIAxes2,'Amplitude')

        
          
           plot(app.UIAxes2_3,y)
           title(app.UIAxes2_3,'original signal');
           xlabel(app.UIAxes2,'Time (s)')
           ylabel(app.UIAxes2,'Amplitude')

           sound(echo,fs); 
           audiowrite('EchoAudio1.wav',echo,fs);
        end

        % Button pushed function: volum1Button
        function volum1ButtonPushed(app, event)
            [x,fs]=audioread('Audio1.wav');
            sound(4*x,fs); 
        end

        % Button pushed function: volum1Button_2
        function volum1Button_2Pushed(app, event)
             [x,fs]=audioread('Audio1.wav');
             sound(0.25*x,fs);
        end

        % Button pushed function: speed1Button
        function speed1ButtonPushed(app, event)
           [audioIn,fs] = audioread("Audio1.wav");
           audioOut = stretchAudio(audioIn,2);
           % t = (0:size(audioOut,1)-1)/fs;
           % plot(app.UIAxes,t,audioOut)  
           % xlabel(app.UIAxes,'Time (s)')
           % ylabel(app.UIAxes,'Amplitude')
           % title(app.UIAxes,'Modified Signal, Speedup Factor = 2')
           % axis tight
           % grid on
           sound(audioOut,fs)
        end

        % Button pushed function: speed1Button_2
        function speed1Button_2Pushed(app, event)
           [audioIn,fs] = audioread("Audio1.wav");
           audioOut = stretchAudio(audioIn,0.5);
           t = (0:size(audioOut,1)-1)/fs;
           % plot(app.UIAxes,t,audioOut)  
           % xlabel(app.UIAxes,'Time (s)')
           % ylabel(app.UIAxes,'Amplitude')
           % title(app.UIAxes,'Modified Signal, Speedup Factor = 0.5')
           % axis tight
           % grid on
           sound(audioOut,fs)
        end

        % Callback function
        function subplotButtonPushed(app, event)
          % [echo,fs]=audioread('EchoAudio1.wav');
          %  h=[1,zeros(1,0.4*fs),0.5,zeros(1,0.4*fs),0.25];%fs=100 / 40 -> 0
          %  subplot(app.UIAxes,3,1,1);
          %  plot(app.UIAxes,echo)
          %  title(app.UIAxes,'echo')
          %  subplot(app.UIAxes_2,3,1,2)
          %  plot(app.UIAxes_2,h)
          %  title(app.UIAxes_3,'impluse')
          %  subplot(app.UIAxes_3,3,1,3)
          %  plot(app.UIAxes,y)
          %  title(app.UIAxes,'original signal');
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 939 611];
            app.UIFigure.Name = 'MATLAB App';

            % Create UIAxes_3
            app.UIAxes_3 = uiaxes(app.UIFigure);
            title(app.UIAxes_3, 'plot3')
            xlabel(app.UIAxes_3, 'X')
            ylabel(app.UIAxes_3, 'Y')
            zlabel(app.UIAxes_3, 'Z')
            app.UIAxes_3.Position = [32 72 255 145];

            % Create UIAxes4
            app.UIAxes4 = uiaxes(app.UIFigure);
            title(app.UIAxes4, 'Title')
            xlabel(app.UIAxes4, 'X')
            ylabel(app.UIAxes4, 'Y')
            zlabel(app.UIAxes4, 'Z')
            app.UIAxes4.Position = [384 349 164 174];

            % Create signalmanipulatingLabel_2
            app.signalmanipulatingLabel_2 = uilabel(app.UIFigure);
            app.signalmanipulatingLabel_2.FontSize = 18;
            app.signalmanipulatingLabel_2.FontWeight = 'bold';
            app.signalmanipulatingLabel_2.FontColor = [0.8 0.8 0.8];
            app.signalmanipulatingLabel_2.Position = [339 565 186 23];
            app.signalmanipulatingLabel_2.Text = 'signal (manipulating)';

            % Create signalmanipulatingLabel
            app.signalmanipulatingLabel = uilabel(app.UIFigure);
            app.signalmanipulatingLabel.FontSize = 18;
            app.signalmanipulatingLabel.FontWeight = 'bold';
            app.signalmanipulatingLabel.FontColor = [1 0 0];
            app.signalmanipulatingLabel.Position = [341 565 247 30];
            app.signalmanipulatingLabel.Text = 'signal (manipulating)';

            % Create beepsoundButton
            app.beepsoundButton = uibutton(app.UIFigure, 'push');
            app.beepsoundButton.ButtonPushedFcn = createCallbackFcn(app, @beepsoundButtonPushed, true);
            app.beepsoundButton.BackgroundColor = [0.5569 0.6471 0.749];
            app.beepsoundButton.FontColor = [0.902 0.902 0.902];
            app.beepsoundButton.Position = [32 524 78 37];
            app.beepsoundButton.Text = 'beep sound';

            % Create whitenoisesoundButton
            app.whitenoisesoundButton = uibutton(app.UIFigure, 'push');
            app.whitenoisesoundButton.ButtonPushedFcn = createCallbackFcn(app, @whitenoisesoundButtonPushed, true);
            app.whitenoisesoundButton.BackgroundColor = [0.5569 0.6471 0.749];
            app.whitenoisesoundButton.FontColor = [0.902 0.902 0.902];
            app.whitenoisesoundButton.Position = [122 524 111 37];
            app.whitenoisesoundButton.Text = 'white noise sound';

            % Create recordaudio1Button
            app.recordaudio1Button = uibutton(app.UIFigure, 'push');
            app.recordaudio1Button.ButtonPushedFcn = createCallbackFcn(app, @recordaudio1ButtonPushed, true);
            app.recordaudio1Button.BackgroundColor = [0.9804 0.4196 0.4196];
            app.recordaudio1Button.FontColor = [1 1 1];
            app.recordaudio1Button.Position = [39 478 92 29];
            app.recordaudio1Button.Text = 'record audio 1';

            % Create playaudioButton
            app.playaudioButton = uibutton(app.UIFigure, 'push');
            app.playaudioButton.ButtonPushedFcn = createCallbackFcn(app, @playaudioButtonPushed, true);
            app.playaudioButton.BackgroundColor = [0.651 0.651 0.651];
            app.playaudioButton.FontColor = [0.9412 0.9412 0.9412];
            app.playaudioButton.Position = [42 438 97 29];
            app.playaudioButton.Text = 'play audio';

            % Create addnoiseButton
            app.addnoiseButton = uibutton(app.UIFigure, 'push');
            app.addnoiseButton.ButtonPushedFcn = createCallbackFcn(app, @addnoiseButtonPushed, true);
            app.addnoiseButton.BackgroundColor = [0.651 0.651 0.651];
            app.addnoiseButton.FontColor = [0.9412 0.9412 0.9412];
            app.addnoiseButton.Position = [42 400 97 29];
            app.addnoiseButton.Text = 'add noise';

            % Create volum1Button
            app.volum1Button = uibutton(app.UIFigure, 'push');
            app.volum1Button.ButtonPushedFcn = createCallbackFcn(app, @volum1ButtonPushed, true);
            app.volum1Button.BackgroundColor = [0.651 0.651 0.651];
            app.volum1Button.FontColor = [0.9412 0.9412 0.9412];
            app.volum1Button.Position = [40 363 98 29];
            app.volum1Button.Text = 'volum +1';

            % Create echotheaudioButton
            app.echotheaudioButton = uibutton(app.UIFigure, 'push');
            app.echotheaudioButton.ButtonPushedFcn = createCallbackFcn(app, @echotheaudioButtonPushed, true);
            app.echotheaudioButton.BackgroundColor = [0.651 0.651 0.651];
            app.echotheaudioButton.FontColor = [0.9412 0.9412 0.9412];
            app.echotheaudioButton.Position = [153 438 94 29];
            app.echotheaudioButton.Text = 'echo the audio';

            % Create volum1Button_2
            app.volum1Button_2 = uibutton(app.UIFigure, 'push');
            app.volum1Button_2.ButtonPushedFcn = createCallbackFcn(app, @volum1Button_2Pushed, true);
            app.volum1Button_2.BackgroundColor = [0.651 0.651 0.651];
            app.volum1Button_2.FontColor = [0.9412 0.9412 0.9412];
            app.volum1Button_2.Position = [153 361 93 29];
            app.volum1Button_2.Text = 'volum -1';

            % Create speed1Button
            app.speed1Button = uibutton(app.UIFigure, 'push');
            app.speed1Button.ButtonPushedFcn = createCallbackFcn(app, @speed1ButtonPushed, true);
            app.speed1Button.BackgroundColor = [0.651 0.651 0.651];
            app.speed1Button.FontColor = [0.9412 0.9412 0.9412];
            app.speed1Button.Position = [41 324 95 28];
            app.speed1Button.Text = 'speed +1';

            % Create removenoiseButton
            app.removenoiseButton = uibutton(app.UIFigure, 'push');
            app.removenoiseButton.ButtonPushedFcn = createCallbackFcn(app, @removenoiseButtonPushed, true);
            app.removenoiseButton.BackgroundColor = [0.651 0.651 0.651];
            app.removenoiseButton.FontColor = [0.9412 0.9412 0.9412];
            app.removenoiseButton.Position = [152 399 94 29];
            app.removenoiseButton.Text = 'remove noise';

            % Create speed1Button_2
            app.speed1Button_2 = uibutton(app.UIFigure, 'push');
            app.speed1Button_2.ButtonPushedFcn = createCallbackFcn(app, @speed1Button_2Pushed, true);
            app.speed1Button_2.BackgroundColor = [0.651 0.651 0.651];
            app.speed1Button_2.FontColor = [0.9412 0.9412 0.9412];
            app.speed1Button_2.Position = [153 323 94 29];
            app.speed1Button_2.Text = 'speed -1';

            % Create subtract2audioButton
            app.subtract2audioButton = uibutton(app.UIFigure, 'push');
            app.subtract2audioButton.BackgroundColor = [0.651 0.651 0.651];
            app.subtract2audioButton.FontColor = [0.9412 0.9412 0.9412];
            app.subtract2audioButton.Position = [32 23 124 37];
            app.subtract2audioButton.Text = 'subtract 2 audio';

            % Create multiply2audioButton
            app.multiply2audioButton = uibutton(app.UIFigure, 'push');
            app.multiply2audioButton.BackgroundColor = [0.651 0.651 0.651];
            app.multiply2audioButton.FontColor = [0.9412 0.9412 0.9412];
            app.multiply2audioButton.Position = [164 24 124 36];
            app.multiply2audioButton.Text = 'multiply 2 audio';

            % Create subplotPanel
            app.subplotPanel = uipanel(app.UIFigure);
            app.subplotPanel.Title = 'subplot';
            app.subplotPanel.Position = [417 0 512 335];

            % Create UIAxes2
            app.UIAxes2 = uiaxes(app.subplotPanel);
            title(app.UIAxes2, 'Title')
            xlabel(app.UIAxes2, 'X')
            ylabel(app.UIAxes2, 'Y')
            zlabel(app.UIAxes2, 'Z')
            app.UIAxes2.Position = [26 223 447 82];

            % Create UIAxes2_2
            app.UIAxes2_2 = uiaxes(app.subplotPanel);
            title(app.UIAxes2_2, 'Title')
            xlabel(app.UIAxes2_2, 'X')
            ylabel(app.UIAxes2_2, 'Y')
            zlabel(app.UIAxes2_2, 'Z')
            app.UIAxes2_2.Position = [27 125 445 84];

            % Create UIAxes2_3
            app.UIAxes2_3 = uiaxes(app.subplotPanel);
            title(app.UIAxes2_3, 'Title')
            xlabel(app.UIAxes2_3, 'X')
            ylabel(app.UIAxes2_3, 'Y')
            zlabel(app.UIAxes2_3, 'Z')
            app.UIAxes2_3.Position = [27 30 445 79];

            % Create defultsuondsPanel
            app.defultsuondsPanel = uipanel(app.UIFigure);
            app.defultsuondsPanel.Title = 'defult suonds';
            app.defultsuondsPanel.Position = [566 348 363 179];

            % Create UIAxes_4
            app.UIAxes_4 = uiaxes(app.defultsuondsPanel);
            title(app.UIAxes_4, 'plot1')
            xlabel(app.UIAxes_4, 'X')
            ylabel(app.UIAxes_4, 'Y')
            zlabel(app.UIAxes_4, 'Z')
            app.UIAxes_4.Position = [10 24 173 125];

            % Create UIAxes
            app.UIAxes = uiaxes(app.defultsuondsPanel);
            title(app.UIAxes, 'plot1')
            xlabel(app.UIAxes, 'X')
            ylabel(app.UIAxes, 'Y')
            zlabel(app.UIAxes, 'Z')
            app.UIAxes.Position = [195 23 151 125];

            % Create EditFieldLabel
            app.EditFieldLabel = uilabel(app.UIFigure);
            app.EditFieldLabel.HorizontalAlignment = 'right';
            app.EditFieldLabel.Position = [44 265 55 22];
            app.EditFieldLabel.Text = 'Edit Field';

            % Create EditField
            app.EditField = uieditfield(app.UIFigure, 'text');
            app.EditField.Position = [114 265 100 22];

            % Create EditField2Label
            app.EditField2Label = uilabel(app.UIFigure);
            app.EditField2Label.HorizontalAlignment = 'right';
            app.EditField2Label.Position = [37 236 62 22];
            app.EditField2Label.Text = 'Edit Field2';

            % Create EditField2
            app.EditField2 = uieditfield(app.UIFigure, 'text');
            app.EditField2.Position = [114 236 100 22];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = Audio_1

            runningApp = getRunningApp(app);

            % Check for running singleton app
            if isempty(runningApp)

                % Create UIFigure and components
                createComponents(app)

                % Register the app with App Designer
                registerApp(app, app.UIFigure)
            else

                % Focus the running singleton app
                figure(runningApp.UIFigure)

                app = runningApp;
            end

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end