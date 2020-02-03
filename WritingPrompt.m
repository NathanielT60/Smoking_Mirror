clear
%This is a a writing plot prompt generator.
rng('shuffle');
%First it determines who the hero of the story is.
SHero=["you","your greatest friend","your father","your mother","your love interest"];
HeroRand=ceil(rand*length(SHero));
if HeroRand==1%You must
    Person=1;%Person denotes whether the quest will be 
elseif HeroRand==2|HeroRand==5;%They must
    Person=2;
elseif HeroRand==3;%Your father must
    Person=3;
elseif HeroRand==4;%Your mother must
    Person=4;
end
Hero=char(SHero(HeroRand));
%Second it determines who the companion is
if HeroRand==1;
    SComp=["Your greatest friend","Your father","Your mother","Your love interest","On your own,"];%You have a companion, or no companion
else
    SComp=["You"];%You are the companion
end
CompRand=ceil(rand*length(SComp));
Comp=char(SComp(CompRand));
if CompRand==5;
    Who='';
else
    Who='who';
end
%Third is the urgency of the deed. These must be identical except in
%perspective of the person. Add a space to each one at the beginning.
if CompRand==5;%If you are your on your own
    SUrgency=[" must "," want "," are called "," are commanded "," are asked "];%You are called
    SUrgencyC=[""];
elseif HeroRand==1;%If you are the hero
    SUrgency=[", who must ",", who want ",", who are called ",", who are commanded ",", who are asked "];%You are called
    SUrgencyC=["must","wants to"];
else%If someone else is the hero and you are the companion
    SUrgency=[", who must ",", who wants ",", who is called ",", who is commanded ",", who is asked "];
    SUrgencyC=["must","want to"];
end

UrgencyRand=ceil(rand*length(SUrgency));
UrgencyRandC=ceil(rand*length(SUrgencyC));
Urgency=char(SUrgency(UrgencyRand));%When you must do something
UrgencyC=char(SUrgencyC(UrgencyRandC));%When you want to help

%Fourth is the Sender
if UrgencyRand==1;% If the person "must"
    SSender="";
elseif UrgencyRand==2;% If the person "wants"
    SSender="to";
else
    SSender=["by a council to","by a god to","by a hermit to","by a king to","by a priest to"];
end
SenderRand=ceil(rand*length(SSender));
Sender=char(SSender(SenderRand));

%Now for what the quest is like
SQuest=["journey to","bring the end of","bring the rule of","redeem","travel with","understand the past of","escape"];
%All the person quests have a personal pronoun in there. Make additions to
%each one simultaneously with the appropriate pronouns.
PersonQuest(1,:)=["reconcile your past with","understand your part in"];
PersonQuest(2,:)=["reconcile their past with","understand their part in"];
PersonQuest(3,:)=["reconcile his past with","understand his part in"];
PersonQuest(4,:)=["reconcile her past with","understand her part in"];
horzcat(SQuest,PersonQuest(Person,:));
QuestRand=ceil(rand*length(SQuest));
Quest=char(SQuest(QuestRand));

SObject=["a man","a ruler","a god","a starship","a religious group","an order of knights","an imperial guard","a band of performers","a guild of workers",];
ObjectRand=ceil(rand*length(SObject));
Object=char(SObject(ObjectRand));

%Now to describe the flavoring.

SFlavorB=["Iron","Adamant","Departed","Oldest","Vanquished","Elevated"];%Don't work with End
LB=[1,length(SFlavorB)];
SFlavorC=["Colorless","Spectral","Shapeless","Infernal","Broken","Golden","Remembered"];%Don't work with Virtue,Reign,End
LC=[1,length(SFlavorC)]+LB(end);
SFlavorD=["Pale","Towering","Crumbling"];%Don't work with End,Virtue,Reign,Song,Whisper,Voice
LD=[1,length(SFlavorD)]+LC(end);
SFlavorE=["Distant","Haunted","Lightless","Inexorable"];%Don't work with Virtue
LE=[1,length(SFlavorE)]+LD(end);
SFlavorA=["Eternal","Forbidden","Divine","High","Highest","Deep","Deepest","Last","Lost","Ordained","Sanctified","Hated"];
SFlavor=horzcat(SFlavorB,SFlavorC,SFlavorD,SFlavorE,SFlavorA);
FlavorRand=ceil(rand*length(SFlavor));
Flavor=char(SFlavor(FlavorRand));

PSThing1=["End","Virtue","Reign","Whisper","Voice","Song","Watch","Tomb"];
PSThing2=["Fist","Flame","Flood","Lamp","Altar","Vault","Lance","Sword"];
PSThing3=["Shroud","Mantle","Whisper","Shrine","Temple","Throne","Crown","Spire"];
PSThing4=["Table","Chalice","Harp","Castle","Palace","Lake","Keep"];

if FlavorRand<=LB(end);
    n=1;
    PSThing1(1)=[];
elseif FlavorRand>LB(end)&FlavorRand<=LC(end)
    n=3;
    PSThing1(1:3)=[];
elseif FlavorRand>LC(end)&FlavorRand<=LD(end)
    n=6;
    PSThing1(1:6)=[];
elseif FlavorRand>LD(end)&FlavorRand<=LE(end)
    n=1;
    PSThing1(2)=[];
else
    n=0;
end
SThing=horzcat(PSThing1,PSThing2,PSThing3,PSThing4);
ThingRand=ceil(rand*length(SThing));
Thing=char(SThing(ThingRand));

if ObjectRand<=4;%If it's a single thing
    SPos1=["God","Priest","Keeper","Watcher","Seer","Councillor","Sacrifice","Saint","Prophet","Tender"];
else
    SPos1=["Gods","Priests","Keepers","Watchers","Seers","Councillors","Sacrifices","Saints","Prophets","Tenders"];
end

SPos2=["Shrine","Temple","Rule","Throne","Guard","Charity","Vigil","Scepter","Shadow"];

if (ThingRand+n)==7;%If it is Watch
    SPos1(4)=[];%Removes Watch
elseif (ThingRand+n)==21|(ThingRand+n)==20;%If it's shrine or temple
    SPos2(1:2)=[];%Removes shrine and temple
elseif (ThingRand+n)==3;%If it's Reign
    SPos2(3)=[];
elseif (ThingRand+n)==22;
    SPos2(4)=[];
elseif (ThingRand+n)==31;
    SPos1(3)=[];
end
SPos=horzcat(SPos1,SPos2);
PosRand=ceil(rand*length(SPos));
Position=char(SPos(PosRand));

m=rand*2;
if m<1.5;
if CompRand==5;%If you are on your own
    Prompt=[Comp,' ',Hero,Urgency,' ',Sender,' ',Quest,' ',Object,' known as the ',Flavor,' ',Thing,'.'];
    disp(Prompt)
elseif CompRand~=5;
    Prompt=[Comp,' ',UrgencyC,' help ',Hero,Urgency,Sender,' ',Quest,' ',Object,' known as the ',Flavor,' ',Thing,'.'];
    disp(Prompt)
end
else
if CompRand==5;%If you are on your own
    Prompt=[Comp,' ',Hero,Urgency,Sender,' ',Quest,' ',Object,' known as the ',Position,' of the ',Flavor,' ',Thing,'.'];
    disp(Prompt)
elseif CompRand~=5
    Prompt=[Comp,' ',UrgencyC,' help ',Hero,Urgency,Sender,' ',Quest,' ',Object,' known as the ',Position,' of the ',Flavor,' ',Thing,'.'];
    disp(Prompt)
end
end