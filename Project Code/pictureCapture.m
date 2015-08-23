function pictureCapture
% PICTURECAPTURE captures the picture from the real time video of the front camera
% The picture would be captured when user left click the mouse once.
% User could choose to save the captured picture into any path.

% Set up the front camera
frontCam = videoinput('winvideo', 1,'YUY2_640x480');
set(frontCam,'TriggerRepeat',inf);
set(frontCam,'FramesPerTrigger',1);
set(frontCam,'ReturnedColorSpace','rgb');
vidRes=get(frontCam,'VideoResolution');
nBands=get(frontCam,'NumberOfBands');

% Set up the capture window and function
fig1 = figure;
set(fig1,'doublebuffer','on');
hImage=image(zeros(vidRes(2),vidRes(1),nBands));
set(fig1,'Name','Please left click your mouse to capture a picture');
set(fig1,'WindowButtonDownFcn',@LeftClickFcn);

fig2 = 0;
% once left click the mouse, one picture would be captured
% the last captured picture would be saved defautly as "snap.jpg"
    function LeftClickFcn(~,~)
        frame = getsnapshot(frontCam);
        if fig2 == 0
            fig2 = figure;
        else
            figure(fig2)
        end
        imshow(frame);
        title('The picture we just captured¡¡^_< ')
        imwrite(frame,'snap.jpg','jpg');
    end

% Set up the real time video preview window
preview(frontCam, hImage);
            
end

