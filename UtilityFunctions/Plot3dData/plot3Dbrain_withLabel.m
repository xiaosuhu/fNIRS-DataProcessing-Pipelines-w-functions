function plot3Dbrain_withLabel(intensity,onlypositive,p,coordfile)

coord=load(coordfile,'-mat'); % Load Coordinates - now need to specify names stroing the data
fieldname=fields(coord);
CHMNI=eval(['coord.',fieldname{1}]);

mx=5;
mn=-5;

% remove the negative intensity associated ind
if onlypositive
    negind=find(intensity<=0);
else
    negind=[];
end

insigind=find(p>=0.05);

if ~isempty(negind)
    try
        rind=unique([negind; insigind]);
    catch
        rind=unique([negind insigind]);
    end
else
    rind=insigind;
end

intensity(rind)=[];
CHMNI(rind,:)=[];

CHMNIcoordstd=10*ones(length(CHMNI));

Plot3D_channel_registration_result(intensity, CHMNI, CHMNIcoordstd,mx,mn);

x_translate=96.5;
y_translate=114.5+5;
z_translate=96.5-10;

MNIcoord=CHMNI+repmat([x_translate y_translate z_translate],size(CHMNI,1),1);

for i=1:length(MNIcoord)
    if CHMNI(i,1)>0
        text(MNIcoord(i,1)+5,MNIcoord(i,2),MNIcoord(i,3),num2str(i));
    else
        text(MNIcoord(i,1)-5,MNIcoord(i,2),MNIcoord(i,3),num2str(i));
    end
end

%% Plot 3D data into a video
% OptionZ.FrameRate=15;OptionZ.Duration=5.5;OptionZ.Periodic=true;
% CaptureFigVid([-20,10;-110,10;-190,80;-290,10;-380,10], 'FirstFiveStimDiff',OptionZ)

end