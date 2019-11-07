close all
clear all

folder_list = dir;
k=1;
for i=1:length(folder_list)
    if isfolder(folder_list(i).name) & not(folder_list(i).name == '.') & not(strcmp(folder_list(i).name, 'phi2_scan2'))
        cd(folder_list(i).name);
        disp(folder_list(i).name)
        log_file_list = dir('*.Log*');
        %disp(log_file_list.name)
        for j=1:length(log_file_list)
            
            fname = log_file_list(j).name;
            emitX_file_name = strrep(fname,'Log','Xemit');
            t=load(emitX_file_name);
            emitX(k)=t(end,6);
            emitY_file_name = strrep(fname,'Log','Yemit');
            t=load(emitY_file_name);
            emitY(k)=t(end,6);
            output_file_name = strrep(fname,'Log','0800');
            if isfile(output_file_name)
                y=load(output_file_name);
                Ez_rms(k) = rms(y(2:end,6));
            end
            
            fileID = fopen(fname);
            InputText1 = textscan(fileID,' %s %f %f %f %f','HeaderLines',2632,'Delimiter',',');
            InputText2 = textscan(fileID,' %s','HeaderLines',110,'Delimiter',' ');
            phi1(k) = InputText1{2};
            phi2(k) = InputText1{3};
            maxB(k) = str2num(InputText2{1}{8});
            k=k+1;
            fclose(fileID);            
        end
        cd ..
    end
end

figure
hold on
cmap = jet(128);
for i=1:length(phi1)
    r = (emitX(i)-min(emitX))/(max(emitX)-min(emitX));
%     cmapindex = round(log(r+1)/log(2)*127)+1
    cmapindex = round(r*127)+1
    stem3(maxB(i),phi1(i),emitX(i),'o','color',cmap(cmapindex,:));
end
    
figure
hold on
cmap = jet(128);
for i=1:length(phi2)
    r = (Ez_rms(i)-min(Ez_rms))/(max(Ez_rms)-min(Ez_rms));
%     cmapindex = round(r)*127+1
    cmapindex = round(log(r+1)/log(2)*127)+1
    stem3(maxB(i),phi2(i),Ez_rms(i),'o','color',cmap(cmapindex,:));
end


