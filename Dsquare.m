
 clc;

 inputvideo=vision.VideoFileReader('traffic.avi');
 vid1=vision.VideoPlayer;
 while~isDone(inputvideo)
    frame1=step(inputvideo);
    step(vid1,frame1);
     pause(0.05);
 end
 
 imwrite(frame1,'C:\Users\Desktop\refernceimg.jpg','jpg');
 release(inputvideo);
 release(vid1);
 referenceimage=imread('C:\Users\Desktop\refernceimg.jpg');
 vid2=vision.VideoFileReader('Traffic.avi');
 for i=2:121
     clc
     frame=step(vid2);
     frame2=((im2double(frame))-(im2double(referenceimage)));%background subtracting using referenceimg
     frame1=im2bw(frame2,0.2);%converting it into binary image
     [labelimage]=bwlabel(frame1);
     stats=regionprops(labelimage,'basic');
     BB=stats.BoundingBox;%creating a bounding box and extracting features
     X(i)=BB(1); %feature extraction extracts feature and locates the position of the moving object in the frame
     Y(i)=BB(2);
     Dist=((X(i)-X(i-1))^2+(Y(i)-Y(i-1))^2)^(1/2)%calculating the diplacement of the object in two consecutive frames
     Z(i)=Dist;%total displacement covered in one second
     if(Dist>10&&Dist<20) %estimating the speed
         display('MEDIUM SPEED');
     elseif(Dist<10)
         display('SLOW SPEED');
     else
         display('FAST SPEED');
     end
     S=strel('disk',4);%creating a a disk as a structuring element S that helps in morphological processing
     frame3=imclose(frame1,S);% does erosion followed by dilation
     step(vid1,frame1);
     pause(0.25);
 end
 M=median(Z);
 Speed=(M)*(120/8)%calculating the speed wrt fps
 release(vid1)
 