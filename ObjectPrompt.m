clear
%This is a prompt generator to make items
rng('shuffle');
SThingA=["lamp","bell","bowl","goblet","hammer","cart","tablet","book","quill","coronet","bridle","coil of rope","set of manacles","torch","cloak","dagger","brooch","comb","bed"];
SThingN=["axe","amulet","astrolabe","urn","orb"];
SThing=horzcat(SThingA,SThingN);
ThingRand=ceil(rand*length(SThing));
if ThingRand>length(SThingA)
    Article=' an ';
else
    Article=' a ';
end
Thing=char(SThing(ThingRand));

SMaterial=["bone","wood","living wood","brass","copper","gold","iron","glass","silk","gossamer","grass","wicker","hair","leather","shell","cloth","rock","crystal","adamant","sand","tears","cloud","mist","darkness","light"];
MatRand=ceil(rand*length(SMaterial));
Material=char(SMaterial(MatRand));

SHappening=["bound with","ornamented with","fashioned from"];
HapRand=ceil(rand*length(SHappening));
Happening=char(SHappening(HapRand));

SUse=["has common use","has ritual purposes","is a symbol of status","can be used as a weapon","has magical properties"];
UseRand=ceil(rand*length(SUse));
Use=char(SUse(UseRand));

Prompt=['Your object is',Article,Thing,' ',Happening,' ',Material,'. It ',Use,'.'];
disp(Prompt)
