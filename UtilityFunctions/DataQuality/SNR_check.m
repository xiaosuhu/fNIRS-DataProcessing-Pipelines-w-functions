function SNR = SNR_check(data)
%SNR_CHECK Summary of this function goes here
%   Detailed explanation goes here
for i=1:numel(data)
    % Varience of HbO signal
    tI = 'hbo';
    lsthbo=find(ismember(data(i).probe.link.type,tI));
    for j=1:length(lsthbo)
        SNR(i,j)=20*log(mean(abs(data(i).data(:,lsthbo(j))))/std(abs(data(i).data(:,lsthbo(j)))));
        % Varience of HbR signal
        % SNR(i,j,2)=20*log(mean(abs(data(i).data(:,lsthbr(j))))/std(abs(data(i).data(:,lsthbr(j)))));
    end
end

figure
bar(mean(SNR,2));

end

