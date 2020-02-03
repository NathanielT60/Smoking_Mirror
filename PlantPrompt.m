clear
%This is a writing prompt generator for making plants
rng('shuffle');
SPlant=["flower","tree","grass","bush"];
PlantRand=ceil(rand*length(SPlant));
Plant=char(SPlant(PlantRand));

%Now for the thing about the plant
if PlantRand==1%If it's a flower
    SThings=["fruit","seeds","leaves","petals"];
elseif PlantRand==2%If it's a tree
    SThings=["fruit","seeds","leaves","flowers","bark"];
elseif PlantRand==3%If it's a grass"
    SThings=["flowers","seeds","roots","leaves"];
elseif PlantRand==4%If it's a bush
    SThings=["fruit","seeds","leaves","flowers"];
end
ThingsRand=ceil(rand*length(SThings));
Thing=char(SThings(ThingsRand));

%Add the quality you want the thing to have, in groups of five.
PSQuality(1,:)=["blue","orange","red","purple","golden"]; %colors go here
PSQuality(2,:)=["maroon","grey","bright","pale","dark"];
PSQuality(3,:)=["translucent","elaborately-marked","unusually-shaped","bitter","jewel-like"];
PSQuality(4,:)=["papery","snowy","gleaming","waveringly-gleaming","flowing"];
PSQuality(5,:)=["sharp","airy","whippy","ringing","glass-like"];
PSQuality(6,:)=["striped","spotted","long","luscious","knobby"];

QualityPRand=ceil(rand*length(PSQuality(:,1)));
SQuality=PSQuality(QualityPRand,:);
QualityRand=ceil(rand*length(SQuality));
Quality1=char(SQuality(QualityRand));

QualityPRand2=ceil(rand*length(SQuality(:,1)));
if QualityPRand<=2&QualityPRand2<=2
    Conj=char([" and "]);
else
    Conj=char([", "]);
end

if QualityPRand~=QualityPRand2 %If they aren't from the same row,
   SQuality2=PSQuality(QualityPRand2,:);
   QualityRand2=ceil(rand*length(SQuality2));
   i=2;
else
   i=1;
   SQuality2=PSQuality(QualityPRand2,:);
   QualityRand2=ceil(rand*length(SQuality2));
   while i==1
        if QualityRand2~=QualityRand
            i=2;
        elseif QualityRand2==QualityRand
            QualityRand2=ceil(rand*length(SQuality2));
            i=1;
        end
    end
end
Quality2=char(SQuality2(QualityRand2));

%Now for the climate it's grown in.
SClimate=["the deep ocean","shallow seas","forests","broadleaf forests","boreal forests","jungles","rainforests","grasslands","mountains","highlands","deserts","steppes","savannahs","tundra","arctic climates","wetlands","swamps","the sky","caves"];
ClimateRand=ceil(rand*length(SClimate));
Climate=char(SClimate(ClimateRand));

%Now for the extras
SStuff=["magical properties","influence on magic","symbolic significance","religious significance","rare value","historical significance"];
StuffRand=ceil(rand*length(SStuff));
Stuff=char(SStuff(StuffRand));
m=rand*2;
if m<1.25
    Prompt=['Make a ',Plant,' with ',Quality1,Conj,Quality2,' ',Thing,' that grows in ',Climate,'.'];
    disp(Prompt)
else
    Prompt=['Make a ',Plant,' with ',Quality1,Conj,Quality2,' ',Thing,' that grows in ',Climate,'. Give it ',Stuff,'.'];
    disp(Prompt)
end
%Make a flower with unusually-shaped petals that grows in the ocean. Give
%it symbolic significance.