clear
Pictures='C:\Users\sulfa\Desktop\BE Capstone Senior Design\Pictures of Project';
ThePictures=dir(Pictures);
Names={ThePictures.name}';
%for i=3:length(ThePictures)
%    k=i-2;
%    Name(k,1)=string(ThePictures(i).name);
%end
PictureARead=char(fullfile(Pictures,Names(4)))
PictureA=imread(PictureARead);
PictureAR=PictureA(:,:,1);
PictureAG=PictureA(:,:,2);
PictureAB=PictureA(:,:,3);
%[PictureAR,PictureAG,PictureAB]=imsplit(PictureA);
BrightAG=find(PictureAG>=(0.5*max(PictureAG)));
figure(1)
subplot(2,2,1); imshow(PictureA), title('Full Picture')
subplot(2,2,2); imshow(PictureAR), title('Red Data')
subplot(2,2,3); imshow(PictureAG), title('Green Data')
subplot(2,2,4); imshow(PictureAB), title('Blue Data')
for i=1:length(PictureAG(1,:))
    PAG1(1,i)=mean(PictureAG(:,i));
    PAR1(1,i)=mean(PictureAR(:,i));
    PAB1(1,i)=mean(PictureAB(:,i));
    %These will show where the strips begin and end on the horizontal
    %plane.
end
%for i=1:4:(length(PAG1)/4)
    %PAG2Piece=PAG1(i)+PAG1(i+1)+PAG1(i+2)+PAG1(i+3);
    %PAG2(i,1)=mean(PAG2Piece);
    %PAR2Piece=PAR1(i)+PAR1(i+1)+PAR1(i+2)+PAR1(i+3);
    %PAR2(i,1)=mean(PAR2Piece);
    %PAB2Piece=PAB1(i)+PAB1(i+1)+PAB1(i+2)+PAB1(i+3);
    %PAB2(i,1)=mean(PAB2Piece);
    %X(i)=(4*i)-3;
%end
X1=[1:length(PictureAR(1,:))];
figure(2)
plot(X1,PAR1,'r.',X1,PAG1,'g.',X1,PAB1,'b.')%This will reveal where the strip is. The appropriate
%color will have a shaper curve than the others.
WhereStrip1=find(PAG1>50);%This will be the red color data when we use a green laser/light.
WhereStripRH=PictureAR(:,(WhereStrip1(1):WhereStrip1(end)));%Gives the horizontal pixels where the strip is.
WhereStripGH=PictureAG(:,(WhereStrip1(1):WhereStrip1(end)));
%Currently this looks at the red data. In our product, the Green data will tell us where we
%have the most contrast.

%Now we have identified which horizontal region the pixels are in.
%It's time to look at the vertical axis.
X2=ones(1,length(WhereStripRH)).*[1:length(WhereStripRH)]*(-1);
for i=1:length(WhereStripRH)
    PAR2(i)=mean(WhereStripRH(i,:));
    PAG2(i)=mean(WhereStripGH(i,:));%Average value of each of the rows from top to bottom.
end
WhereStripV1=find(PAG2>200);%Finds which rows are brightest, which is where the lines are
WhereStripGV=WhereStripGH((WhereStripV1(1):WhereStripV1(end)),:);%These are all the pixels that the strip occupies
WhereStripRV=WhereStripRH((WhereStripV1(1):WhereStripV1(end)),:);
X3=X2(WhereStripV1(1):WhereStripV1(end));
for i=1:length(WhereStripRV)
    PAR3(i)=mean(WhereStripRV(i,:));
    PAG3(i)=mean(WhereStripGV(i,:));
end
figure(3)
plot(PAR3,X3,'r.',PAG3,X3,'g.')%Shows us the brightness of each row in the region of the strip.

%Each line is 30 pixels long, more or less.
for i=2:length(PAG3)
    PAR3Diff(i-1)=PAR3(i)-PAR3(i-1);
    X4(i-1)=i;
end
figure(4)
plot(PAR3Diff,X4,'r.')
%The next two lines find where the derivative is sharpest, and get values
%for the peak boundaries.
WhereLinesHigh=find(PAR3Diff<-5);%This finds the upper limit.
WhereLinesLow=find(PAR3Diff>5);%This finds the lower limit.
j=1; k=1;
for i=2:length(WhereLinesHigh)
    if WhereLinesHigh(i)-WhereLinesHigh(i-1)<5
        WhereLinesH(j)=ceil(mean(WhereLinesHigh((i-k):i)));
        k=k+1;
    else
        j=j+1; k=1;
    end
end
j=1; k=1;
for i=2:length(WhereLinesLow)
    if WhereLinesLow(i)-WhereLinesLow(i-1)<5
        WhereLinesL(j)=ceil(mean(WhereLinesLow((i-k):i)));
        k=k+1;
    else
        j=j+1; k=1;
    end
end
%Now we have to get rid of false correlations

for i=1:length(WhereLinesH)
    CorrBox(i,:)=abs(WhereLinesH(i)-WhereLinesL);%This will take every high boundary
    %and compare each one to every low boundary.
end
WhereCorr=find(CorrBox<30);%This will index the corresponding peaks.
WhereCorr=WhereCorr';
[Rows,Columns]=size(CorrBox);
[HighPeaks,LowPeaks]=ind2sub([Rows,Columns],WhereCorr);
Lows=WhereLinesL(LowPeaks); Highs=WhereLinesH(HighPeaks);
WhereLines1=floor((Lows-Highs)/2)+Highs;
WhereLines=WhereLines1+WhereStripV1(1)
figure(5)
subplot(1,2,1); plot(PAR2,X2,'r.'), title('R-Data Reading')
subplot(1,2,2); imshow(PictureAR), title('Picture R-Data')
