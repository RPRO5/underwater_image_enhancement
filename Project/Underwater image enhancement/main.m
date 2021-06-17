
clear all; clc; close all;

trainData = imageSet('./Data','recursive');
newSize = 500; %Size of the image
OutputPath = './Results/'; % Path for saving output images
intialRegions=5; % No of regions
for count = 1:trainData.Count
    
     img = read(trainData, count);
    imgpath = char(trainData.ImageLocation(count));
    [~,imgname,~] = fileparts(imgpath) ;

    %Pre-Processing
    img = imresize(img, [newSize,newSize]);
   
    
%% Statistical approach
    %parameters
    t0=0.1;
    r = 15;
    res = 0.001;
    
    [ JRDark1,JRSDark] = Red_channel(img);
    img = double(img)/255.0;
    
   
     %Superpixel segmentation
     [L,N,avgInten] = superPixelSegment(JRDark1, intialRegions);
     BW = boundarymask(L);
    
    %Adaptive red channel prior
   [ JRDark,Adaptivedark] = Adaptive_Red_channel(img,L,N,avgInten);

      Adaptivedark = double(Adaptivedark);
      Adaptivedark = Adaptivedark./255;
    
     %Atmospheric light estimation
      atmospheric=atmLight(img,Adaptivedark);
 
     %transmission estimation
     [ trans ] =Adaptivetransmission(img,atmospheric,L,N,avgInten);
     
    %Refined transmission estimation
    trans = guided_filter(rgb2gray(img), trans, r, res);

    %Recover radiance
    input1 =Get_Radiance(img, atmospheric,t0,trans);
 
 %% contrast based method

    Input2 = ContrastApproach(img);
%% Fusion 

        for i=1:500
            for j=1:500
                for d=1:3
                 I(i,j,d)=(4*Input2(i,j,d)+input1(i,j,d))/5;
                end
            end
           end

    savepath = strcat(OutputPath,imgname, '.png');
    imwrite(I,savepath);
    
    
end
